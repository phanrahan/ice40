// adapted from example spi slave at http://www.fpga4fun.com/SPI2.html

module SPISlave (
    input clk,
    // act as slave for microcontroller
    input ucSCLK,
    input ucMOSI,
    output ucMISO,
    input ucSEL_,
    // the data bits to be read and written
    input [WIDTH-1:0] data_in,
    output reg [WIDTH-1:0] data_out
);

parameter WIDTH = 32;

// sync ucSCLK to the FPGA clock using a 3-bits shift register
reg [2:0] SCLKr; always @(posedge clk) SCLKr <= {SCLKr[1:0],ucSCLK&~ucSEL_};
wire SCLK_rising = SCLKr[2:1] == 2'b01;     // detect ucSCLK rising edges

// same thing for ucSEL_
reg [2:0] SSELr; always @(posedge clk) SSELr <= {SSELr[1:0],ucSEL_};
wire SSEL_start = SSELr[2:1] == 2'b10;      // start on falling edge
wire SSEL_end = SSELr[2:1] == 2'b01;        // stop on rising edge

// and for ucMOSI, but no need to detect edges
reg [1:0] MOSIr; always @(posedge clk) MOSIr <= {MOSIr[0],ucMOSI};
wire MOSI_data = MOSIr[1];

reg [WIDTH-1:0] shifter;
always @(posedge clk) begin
    if (SSEL_start)
        shifter <= data_in;
    if (SCLK_rising) // rotate left, i.e. MSB out and LSB in
        shifter <= {shifter[WIDTH-2:0],MOSI_data};
    if (SSEL_end)
        data_out <= shifter;
end

// we'll need to tri-state ucMISO if there's more than one slave on the SPI bus
assign ucMISO = shifter[WIDTH-1]; // send MSB first

endmodule
