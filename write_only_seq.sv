package write_only_sequence_pkg ;
import uvm_pkg ::* ;
import fifo_seq_item::* ;
`include "uvm_macros.svh"
class write_only_sequence extends uvm_sequence #(fifo_seq_item);
  `uvm_object_utils(write_only_sequence) ;
   fifo_seq_item seq_item ;
    function new(string name = "write_only_sequence");
        super.new(name) ;
    endfunction //new()
    task body;
     repeat(1000) begin
     seq_item = fifo_seq_item :: type_id::create("seq_item") ;
     start_item(seq_item) ;
     assert(seq_item,randomize() with {rd_en == 0 ; wr_en == 1;}) ;
     finish_item(seq_item) ;
     end
    endtask
endclass 
endpackage