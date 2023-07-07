module main (input [0:7] J1, output D5);

wire a, b;
wire y;

SB_IO #(.PIN_TYPE(6'b00_0000)) 
    ina ( .PACKAGE_PIN(J1[0]), .D_IN_0(a) );
SB_IO #(.PIN_TYPE(6'b00_0000)) 
    inb ( .PACKAGE_PIN(J1[1]), .D_IN_0(b) );

(* LOC="2,2/0" *)
SB_LUT4 #(.LUT_INIT(16'b1000_1000_1000_1000)) 
    lut ( .I0(a), .I1(b), .I2(1'b0), .I3(1'b0), .O(y) );

SB_IO #(.PIN_TYPE(6'b01_0110)) 
    out ( .PACKAGE_PIN(D5), .D_OUT_0(y) );

endmodule

