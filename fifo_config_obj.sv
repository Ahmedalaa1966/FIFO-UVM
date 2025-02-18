package fifo_config_obj_pkg
import uvm_package ::*;
`include "uvm_macros.svh" ;
class fifo_config extends uvm_objects;
    `uvm_object_utils(fifo_config ;
    virtual fifo_if fifo_vif ;

    function new(string name = "fifo_config");
     super.new(name) ;
    endfunction 
endclass //fifo_config_obj extends uvm_objects

        
endpackage