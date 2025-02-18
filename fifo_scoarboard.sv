package fifo_scoreboard_pkg;

  import uvm_pkg ::* ;
 `include "uvm_macros.svh" ;
  import fifo_seq_item_pkg::* ;
  
class fifo_scoreboard extends uvm_scoreboard;
   `uvm_component_utils(alu_scoreboard)  ;
   uvm_analysis_export #(fifo_seq_item) sb_export ;
   uvm_tlm_analysis_fifo#(fifo_seq_item) sb_fifo ;
   fifo_seq_item seq_item_sb ;
   logic [15:0] data_out_ref ;
   logic wr_ack_ref ,overflow_ref ,full_ref,empty_ref ,almostfull_ref ,almostempty_ref ,underflow_ref ;
   int correct_count = 0 ;
   int error_count = 0 ;
   //internals
   logic [15:0] mem[7:0] ;
   logic [2:0] wr_ptr , rd_ptr ;
   logic [3:0] count ;
   ////////
    function new(string name = "fifo_scoreboeard" , uvm_component parent  = null);
    super.new(name,parent) ;        
    endfunction 
    function void build_phase(uvm_phase phase);
        super.build_phase(phase) ;
        sb_export = new("sb_export",this) ;
        sb_fifo = new("sb_fifo",this) ;
    endfunction
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase) ;
        sb_export.connect(sb_fifo.analysis_export) ;
    endfunction


    task run_phase (uvm_phase phase);
        super.run_phase(phase) ;
        forever begin
            sb_fifo.get(seq_item_sb) ;
            ref_model(seq_item_sb) ;
            if(seq_item_sb.data_out != data_out_ref || seq_item_sb.wr_ack != wr_ack_ref || seq_item_sb.overflow != overflow_ref 
            || seq_item_sb.full != full_ref || seq_item_sb.empty != empty_ref || seq_item_sb.almost_full != almostfull_ref ||
             seq_item_sb.almost_empty != almostempty_ref || seq_item_sb.underflow != underflow_ref)begin
            
                `uvm_error("run_phase",$sformat("comparison failed , Transaction received by the DUT:%s while the refrence model out is 0b%0b",seq_item_sb.convert2string(),data_out_ref)) ;
            error_count++ ;
            end
        end
        else
        correct_count++
    endtask 
    task ref_model(fifo_seq_item seq_item_chk) ;
            if(!seq_item_sb.rst_n) begin
                wr_ptr = 0 ;
                overflow_ref = 0 ;
                wr_ack_ref = 0 ;
            end 
            else if(seq_item_sb.wr_en && !full_ref) begin
                mem[wr_ptr] = seq_item_sb.data_in ;
                wr_ack_ref =1 ;
                wr_ptr ++ ;
                overflow_ref = 0 ;
            end
            else begin
                wr_ack_ref = 0 ;
                if(full_ref && seq_item_sb.wr_en ) 
                overflow_ref = 1 ;
                else 
                overflow_ref = 0 ;
            end
            if(!seq_item_sb.rst_n) begin
                rd_ptr = 0 ;
                underflow_ref = 0 ;
            end 
            else if(seq_item_sb.rd_en && !empty_ref) begin
                data_out_ref = mem[rd_ptr] ;
                rd_ptr ++ ;
                underflow_ref = 0 ;
            end
            else begin
                if(empty_ref && seq_item_sb.rd_en)
                underflow_ref = 1 ;
                else
                underflow_ref = 0 ; 
            end
            if(!seq_item_sb.rst_n)begin
                count = 0 ;
            end
            else begin
                if(seq_item_sb.wr_en && seq_item_sb.rd_en && !full_ref !empty_ref)
                count = count ;
                else if(seq_item_sb.wr_en && !full_ref)
                count = count+1 ;
                else if(seq_item_sb.rd_en && !empty_ref)
                count = count -1 
            end
            full_ref = (count == 8)? 1 : 0;
            empty_ref = (count == 0)? 1 : 0;
            underflow_ref = (empty_ref && seq_item_sb.rd_en)? 1 : 0; 
            almostfull_ref = (count == 6)? 1 : 0; 
            almostempty_ref = (count == 1)? 1 : 0;

    endtask

endclass 
endpackage