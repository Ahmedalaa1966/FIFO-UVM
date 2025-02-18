 package fifo_seq_item_pkg ;
 import uvm_pkg ::* ;
 `include "uvm_macros.svh" 
class fifo_seq_item extends uvm_sequence_item;
    `uvm_object_utils(fifo_seq_item)
    rand bit rst_n ;
    rand logic wr_en, rd_en ;
    rand logic [15:0] data_in ;
    logic [15:0] data_out ;
    logic wr_ack ,overflow ,full,empty ,almost_full ,almost_empty ,underflow ;
   
    function new(string name= "fifo_seq_item");
        super.new(name) ;
    endfunction 

    function string convert2string();
     return $sformatf("%s reset = 0b%0b,data_in = 0b%0b, wr_en = 0b%0b ,rd_en = 0b%0b , dataout = 0b%0b , wr_ack = 0b%0b 
     , overflow = 0b%0b , full = 0b%0b ,empty = 0b%0b , almost_full = 0b%0b , almost_empty = 0b%0b ,
      underflow = 0b%0b",super.convert2string(),rst_n,data_in,wr_en,rd_en,data_out,wr_ack,overflow
       ,full , empty , almost_full ,almost_empty,underflow ) ;
    endfunction

    function string convert2string_stimulus();
     return $sformatf("reset = 0b%0b,data_in = 0b%0b, wr_en = 0b%0b ,rd_en = 0b%0b",rst_n,data_in,wr_en,rd_en) ;
    endfunction  
      
endclass 
endpackage