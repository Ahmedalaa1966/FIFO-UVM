package fifo_coverage_pkg
 import uvm_pkg ::* ;
 `include "uvm_macros.svh" ;
 import fifo_seq_item_pkg ::*;  

class fifo_coverage extends uvm_coverage;

   `uvm_component_utils(fifo_coverage) ;
   uvm_analysis_export #(fifo_seq_item) cov_export ;
   uvm_tlm_analysis_fifo #(fifo_seq_item) cov_fifo ;
   fifo_seq_item seq_item_cov ;
covergroup g1;
   wr_en:coverpoint seq_item_cov.wr_en ;
   rd_en:coverpoint seq_item_cov.rd_en ;
   wr_ack :coverpoint seq_item_cov.wr_ack ;
   overflow :coverpoint  seq_item_cov.overflow ;
   full :coverpoint  seq_item_cov.full ;
   empty :coverpoint  seq_item_cov.empty ;
   almostfull :coverpoint  seq_item_cov.almostfull ;
   almostempty :coverpoint  seq_item_cov.almostempty ;
   underflow :coverpoint  seq_item_cov.underflow ;
    cross wr_en , rd_en , wr_ack ;
    cross wr_en , rd_en , overflow ;
    cross wr_en , rd_en , full ;
    cross wr_en , rd_en , empty ;
    cross wr_en , rd_en , almostempty ;
    cross wr_en , rd_en , almostfull ;
    cross wr_en , rd_en , underflow ;
endgroup

function new(string name = "fifo_coverage" , uvm_component parent = null);
    super.new(name,parent) ;
    g1 = new() ;   
endfunction //new()
    
function void build_phase(uvm_phase phase );
   super.build_phase(phase) ;
   cov_export = new("cov_export" , this) ;
   cov_fifo = new("cov_fifo",this) ;    
endfunction  

function void connect_phase(uvm_phase phase);
   super.connect_phase(phase) ;
   cov_export.connect(cov_fifo.analysis_export) ;    
endfunction

task run_phase(uvm_phase phase)
  super.run_phase(phase) ;
  forever begin
    cov_fifo.get(seq_item_cov) ;
    g1.sample() ;
  end
endtask






endclass //fifo_coverage extends uvm_coverage


endpackage