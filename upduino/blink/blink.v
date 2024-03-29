/******************************************************************************
*                                                                             *
* Copyright 2016 myStorm Copyright and related                                *
* rights are licensed under the Solderpad Hardware License, Version 0.51      *
* (the “License”); you may not use this file except in compliance with        *
* the License. You may obtain a copy of the License at                        *
* http://solderpad.org/licenses/SHL-0.51. Unless required by applicable       *
* law or agreed to in writing, software, hardware and materials               *
* distributed under this License is distributed on an “AS IS” BASIS,          *
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or             *
* implied. See the License for the specific language governing                *
* permissions and limitations under the License.                              *
*                                                                             *
******************************************************************************/

module blink(input clk, input rst, output led);

	reg [24:0] count;

	assign led = count[24];

	always @(posedge clk)
	    if(rst)
            count = 0;
        else
            count <= count + 1;

endmodule

module main (
	output	LED_R_,
	output	LED_G_,
	output	LED_B_
	);

	wire clk, led;

	SB_HFOSC u_hfosc (
        	.CLKHFPU(1'b1),
        	.CLKHFEN(1'b1),
        	.CLKHF(clk)
    	);

	blink my_blink (
		.clk(clk),
		.rst(0),
    		.led(led)
	);

	assign LED_R_ = ~led;
	assign LED_G_ = ~led;
	assign LED_B_ = ~led;

endmodule
