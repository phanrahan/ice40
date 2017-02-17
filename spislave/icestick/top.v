`define N 8

module main (
    input clk,
    input PMOD0,
    input PMOD1,
    output PMOD2,
    input PMOD3,
    input [7:0] J1,
    output [7:0] J3
);

wire ucSEL_;
wire ucSCLK;
wire ucMOSI;
wire ucMISO;

assign ucSEL_ = PMOD0;
assign ucMOSI = PMOD1;
assign PMOD2 = ucMISO;
assign ucSCLK = PMOD3;

//wire clk100;
//pll U1 ( .clkin(clk), .clkout(clk100));

wire [`N-1:0] spiin;
wire [`N-1:0] spiout;

assign spiin = J1;

SPISlave #(.WIDTH(`N)) spi (
    .clk(clk),
    //.clk(clk100),
    .ucSCLK(ucSCLK),
    .ucMOSI(ucMOSI),
    .ucMISO(ucMISO),
    .ucSEL_(ucSEL_),
    .data_in(spiin),
    .data_out(spiout)
);

assign J3 = spiout;

endmodule
