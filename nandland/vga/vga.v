module VGA
    (
        input i_Clk,
        output reg o_HSync = 0,
        output reg o_VSync = 0,
        output [11:0] o_x = 0,
        output [11:0] o_y = 0,
        output reg o_valid = 0
    );
 
    localparam TOTAL_WIDTH = 800;
    localparam TOTAL_HEIGHT = 525;
    localparam ACTIVE_WIDTH = 640;
    localparam ACTIVE_HEIGHT = 480;
    localparam H_SYNC_COLUMN = 704;
    localparam V_SYNC_LINE = 523;
    localparam H_PORCH = 50;
    localparam V_PORCH = 33;
 
    reg [11:0] r_HPos = 0;
    reg [11:0] r_VPos = 0;
 
    //step pixel position throughout the screen
    always @(posedge i_Clk)
        begin
          if (r_HPos < TOTAL_WIDTH-1)
            begin
                r_HPos <= r_HPos + 1;
            end
          else
            begin
                r_HPos <= 0;
                if (r_VPos < TOTAL_HEIGHT-1)
                  begin
                    r_VPos <= r_VPos + 1;
                  end
                else
                  begin
                    r_VPos <= 0;
                  end
 
            end  
        end
 
    //Horizontal sync
    always @(posedge i_Clk)
        begin
          if (r_HPos < H_SYNC_COLUMN)
            begin
                o_HSync = 1'b1;
            end
          else
            begin
                o_HSync = 1'b0;
            end  
        end
 
    //Vertical sync
    always @(posedge i_Clk)
        begin
          if (r_VPos < V_SYNC_LINE)
            begin
                o_VSync = 1'b1;
            end
          else
            begin
                o_VSync = 1'b0;
            end  
        end
 
    //Valid region
    always @(posedge i_Clk)
        begin
          if ((r_HPos >= H_PORCH & r_HPos < 690) & (r_VPos >= V_PORCH & r_VPos < 513))
            begin
                o_valid = 1'b1;
            end
          else
            begin
                o_valid = 1'b0;
            end  
        end

    //assign o_x = r_HPos - H_PORCH;
    //assign o_y = r_VPos - V_PORCH;
    assign o_x = r_HPos;
    assign o_y = r_VPos;
 
endmodule

module main 
    (
        input CLK,
        output [2:0] VGA_R,
        output [2:0] VGA_G,
        output [2:0] VGA_B,
        output VGA_HSync,
        output VGA_VSync
    );
 
    wire w_valid;
    wire [11:0] w_x;
    wire [11:0] w_y;
 
    VGA processor
    (
        .i_Clk(CLK),
        .o_HSync(VGA_HSync),
        .o_VSync(VGA_VSync),
        .o_x(w_x),
        .o_y(w_y),
        .o_valid(w_valid)
    );

    wire on = w_valid;
    //wire on = w_valid & w_x[4];
    //wire on = w_valid & (w_x[0] ^ w_y[0]);
    wire [2:0] value = {on, on, on};

    //assign VGA_R = w_x[0:2];
    assign VGA_R = value;
    assign VGA_G = 3'b0;
    assign VGA_B = 3'b0;
 
endmodule
