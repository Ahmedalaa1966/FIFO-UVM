 package read_only_sequence_pkg;
 import uvm_pkg ::* ;
 `include "uvm_macros.svh" ;
 import fifo_seq_item_pkg::*;
class read_only_sequence extends uvm_sequence #(fifo_seq_item);
  `uvm_object_utils(read_only_sequence) ;
   fifo_seq_item seq_item ;
    function new(string name = "read_only_sequence");
        super.new(name) ;
    endfunction //new()
    task body;
     repeat(1000) begin
     seq_item = fifo_seq_item :: type_id::create("seq_item") ;
     start_item(seq_item) ;
     assert(seq_item,randomize() with {rd_en == 1 ; wr_en == 0;}) ;
     finish_item(seq_item) ;
     end
    endtask
endclass 
endpackage