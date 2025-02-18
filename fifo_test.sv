 package fifo_test_pkg;
 import uvm_pkg ::* ;
 `include "uvm_macros.svh" ;
 import fifo_env_pkg::*;
 import read_only_sequence_pkg::*;
 import write_only_sequence_pkg::*;
 import read_write_sequence_pkg::*;
 import fifo_config_obj_pkg ::*;
class fifo_test extends uvm_test;
  `uvm_component_utils(fifo_test) ;
  fifo_env env;
  fifo_config fifo_cfg ;
  virtual fifo_if fifo_vif 
  read_only_sequence rd_seq ;
  write_only_sequence wr_seq ;
  read_write_sequence rdwr_seq ;
    function new(string naame = "fifo_test" , uvm_component parent = null);
        super.new(name,parent) ;
    endfunction 

  function void build_phase(uvm_phase uvm_phase);
    super.build_phase(phase) ;
    env = fifo_env::type_id::create("env",this) ;
    fifo_cfg = fifo_config::type_id::create("fifo_cfg",this) ;
    rd_seq = read_only_sequence::type_id::create("rd_seq",this) ;
    wr_seq = write_only_sequence::type_id::create("wr_seq",this) ;
    rdwr_seq = read_write_sequence::type_id::create("rdwr_seq",this) ;
     if(!uvm_config_db #(virtual fifo_if)::get(this,"","fifo_if",fifo_cfg.fifo_vif))
       `uvm_fatal("build_phase","Test - unable to get the virtual interface of the fifo from the uvm configration database")
    
     uvm_config_db #(fifo_config)::(this,"*","ABC",fifo_cfg) ;
  endfunction
  //run_phase task
endclass //fifo_test extends uvm_test
 endpackage