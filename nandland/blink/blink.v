// This should blink at a rate of ~ second

module top (input CLK, output [0:3] LED);
  
  parameter N = 24;
  
  reg [N-1:0] cnt;
  
  always @(posedge CLK) begin
    cnt <= cnt+1;
  end
  assign LED[0] = cnt[N-1];

endmodule
