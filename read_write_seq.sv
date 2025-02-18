 package read_write_sequence_pkg;
 import uvm_pkg ::* ;
 import fifo_seq_item::* ;
 `include "uvm_macros.svh" ;
class read_write_sequence extends uvm_sequence #(fifo_seq_item);
  `uvm_object_utils(read_only_sequence) ;
   fifo_seq_item seq_item ;
    function new(string name = "read_write_sequence");
        super.new(name) ;
    endfunction //new()
    task body;
     repeat(1000) begin
     seq_item = fifo_seq_item :: type_id::create("seq_item") ;
     start_item(seq_item) ;
     assert(seq_item.randomize());
     end
    endtask
endclass 
endpackage