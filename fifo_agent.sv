 package fifo_agent_pkg;

 import uvm_pkg ::* ;
 import fifo_sequencer_pkg ::*;
 import fifo_monitor_pkg ::*;
 import fifo_driver_pkg ::*;
 import fifo_monitor_pkg ::*;
 `include "uvm_macros.svh" ;
 import fifo_config_obj_pkg::*;

class fifo_agent extends uvm_agent;
`uvm_component_utils(fifo_agent) ;
 fifo_sequencer sqr ;
 fifo_driver drv ;
 fifo_monitor mon;
 fifo_config fifo_cfg ;
 uvm_analysis_port #(fifo_seq_item) agt_ab;
   function new(string naame = "fifo_agent" , uvm_component parent = null);
        super.mew(name,parent) ;
    endfunction 
 function void build_phase(uvm_phase phase);
 super.build_phase(phase) ;
 if(!uvm_config_db=#(alu_config)::get(this,"","ABC",fifo_cfg)) ;
 `uvm_fatal("build_phase","unable to get the configeration object") ;
  sqr = fifo_sequencer::type_id::create("sqr",this) ;
  drv = fifo_driver::type_id::create("drv",this) ;
  mon = fifo_monitor::type_id::create("mon",this) ;
  //fifo_cfg = fifo_config::
 endfunction
function void connect_phase(uvm_phase phase);
    drv.fifo_vif = fifo_cfg.fifo_vif ;
    mon.fifo_vif = fifo_cfg.fifo_vif ;
    drv.seq_item_port.connect(sqr.seq_item_export) ;  
endfunction
endclass //fifo_agent extends uvm_agent
 endpackage