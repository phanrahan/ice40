module top (input PIO1_02, input PIO1_03, output D1);

wire a, b;
wire y;

SB_IO #(.PIN_TYPE(6'b00_0000)) 
    ina ( .PACKAGE_PIN(PIO1_02), .D_IN_0(a) );
SB_IO #(.PIN_TYPE(6'b00_0000)) 
    inb ( .PACKAGE_PIN(PIO1_03), .D_IN_0(b) );

(* LOC="2,2/0" *)
SB_LUT4 #(.LUT_INIT(16'b1000_1000_1000_1000)) 
    lut ( .I0(a), .I1(b), .I2(1'b0), .I3(1'b0), .O(y) );

SB_IO #(.PIN_TYPE(6'b01_0110)) 
    out ( .PACKAGE_PIN(D1), .D_OUT_0(y) );

endmodule

