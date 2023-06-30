module VgaProcessor
    (
        input i_Clk,
        output reg o_HSync = 0,
        output reg o_VSync = 0,
        output reg o_Red_Colour_On = 0
    );
 
    localparam TOTAL_WIDTH = 800;
    localparam TOTAL_HEIGHT = 525;
    localparam ACTIVE_WIDTH = 640;
    localparam ACTIVE_HEIGHT = 480;
    localparam H_SYNC_COLUMN = 704;
    localparam V_SYNC_LINE = 523;
 
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
 
    //Colour On/Off
    always @(posedge i_Clk)
        begin
          if ((r_HPos >= 50 & r_HPos < 690) & (r_VPos >= 33 & r_VPos < 513))
            begin
                o_Red_Colour_On = 1'b1;
            end
          else
            begin
                o_Red_Colour_On = 1'b0;
            end  
        end
 
endmodule

module top 
    (
        input CLK,
        output VGA_R0,
        output VGA_R1,
        output VGA_R2,
        output VGA_G0,
        output VGA_G1,
        output VGA_G2,
        output VGA_B0,
        output VGA_B1,
        output VGA_B2,
        output VGA_HSync,
        output VGA_VSync
    );
 
    wire w_redColourPin;
 
    VgaProcessor processor
    (
        .i_Clk(CLK),
        .o_HSync(VGA_HSync),
        .o_VSync(VGA_VSync),
        .o_Red_Colour_On(w_redColourPin)
    );
 
    assign VGA_R0 = w_redColourPin; 
    assign VGA_R1 = w_redColourPin;
    assign VGA_R2 = w_redColourPin;
    assign VGA_G0 = w_redColourPin; 
    assign VGA_G1 = w_redColourPin;
    assign VGA_G2 = w_redColourPin;
    assign VGA_B0 = w_redColourPin; 
    assign VGA_B1 = w_redColourPin;
    assign VGA_B2 = w_redColourPin;
 
endmodule
