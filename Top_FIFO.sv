include "uvm_pkg.sv" ;
 `include "uvm_macros.svh" ;
module FIFO_top ();
   bit clk ;
   initial begin
      forever begin
         #10 clk = ~clk ;
      end    
   end
   fifo_if c_if(clk) ;
   FIFO a2(c_if) ;


   initial begin
      run_test("fifo_test") ;
   end
endmodule

