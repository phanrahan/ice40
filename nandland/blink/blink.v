// This should blink at a rate of ~ second

module main (output  LED, input  CLK);
  
  parameter N = 24;
  
  reg [N-1:0] cnt;
  
  always @(posedge CLK) begin
    cnt <= cnt+1;
  end
  assign LED = cnt[N-1];

endmodule
