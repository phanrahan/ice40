module VGA
    (
        input i_Clk,
        output reg o_HSync = 0,
        output reg o_VSync = 0,
        output reg o_valid = 0,
        output [11:0] o_x,
        output [11:0] o_y
    );
 
    localparam WIDTH = 640;
    localparam HEIGHT = 480;

    localparam H_FRONT_PORCH = 16;
    localparam H_SYNC_WIDTH = 96;
    localparam H_BACK_PORCH = 48;
    localparam H_BEGIN = H_SYNC_WIDTH + H_BACK_PORCH;
    localparam H_END = H_BEGIN + WIDTH;
    localparam H_WIDTH = H_SYNC_WIDTH + H_BACK_PORCH + WIDTH + H_FRONT_PORCH;


    localparam V_FRONT_PORCH = 10;
    localparam V_SYNC_WIDTH =  2;
    localparam V_BACK_PORCH = 33;
    localparam V_BEGIN = V_SYNC_WIDTH + V_BACK_PORCH;
    localparam V_END = V_BEGIN + HEIGHT;
    localparam V_HEIGHT = V_SYNC_WIDTH + V_BACK_PORCH + HEIGHT + V_FRONT_PORCH;

    reg [11:0] r_HPos = 0;
    reg [11:0] r_VPos = 0;
 
    //step pixel position throughout the screen
    always @(posedge i_Clk)
        begin
          if (r_HPos <  H_WIDTH-1)
            begin
                r_HPos <= r_HPos + 1;
            end
          else
            begin
                r_HPos <= 0;
                if (r_VPos < V_HEIGHT-1)
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
          if (r_HPos < H_SYNC_WIDTH)
            begin
                o_HSync = 1'b0;
                //o_HSync = 1'b1;
            end
          else
            begin
                o_HSync = 1'b1;
                //o_HSync = 1'b0;
            end  
        end
 
    //Vertical sync
    always @(posedge i_Clk)
        begin
          if (r_VPos < V_SYNC_WIDTH)
            begin
                o_VSync = 1'b0;
                //o_VSync = 1'b1;
            end
          else
            begin
                o_VSync = 1'b1;
                //o_VSync = 1'b0;
            end  
        end
 
    //Valid region
    always @(posedge i_Clk)
        begin
          if ((r_HPos >= H_BEGIN & r_HPos < H_END) & (r_VPos >= V_BEGIN & r_VPos < V_END ))
            begin
                o_valid = 1'b1;
            end
          else
            begin
                o_valid = 1'b0;
            end  
        end

    assign o_x = r_HPos - H_BEGIN;
    assign o_y = r_VPos - V_BEGIN;
 
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
        .o_valid(w_valid),
        .o_x(w_x),
        .o_y(w_y)
    );

    //wire on = w_valid;
    //wire on = w_valid & w_x[4];
    wire on = w_valid & (w_x[4] ^ w_y[4]);

    wire [2:0] value = {on, on, on};

    assign VGA_R = value;
    assign VGA_G = value;
    assign VGA_B = value;
 
endmodule
