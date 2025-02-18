interface fifo_if(clk);
parameter FIFO_WIDTH = 16;
parameter FIFO_DEPTH = 8;
input clk ;  
logic [15:0] data_in ,data_out ;
logic rst_n, wr_en, rd_en ,wr_ack, overflow,full, empty, almostfull, almostempty, underflow ;

modport DUT(input clk,rst_n,wr_en,rd_en,data_in ,output data_out ,wr_ack ,overflow ,full,empty ,almostfull ,almostempty ,underflow );
modport TEST(input clk,data_out ,wr_ack ,overflow ,full,empty ,almostfull ,almostempty ,underflow , output rst_n,wr_en,rd_en,data_in) ;
modport monitor(input clk,data_out ,wr_ack ,overflow ,full,empty ,almostfull ,almostempty ,underflow,rst_n,wr_en,rd_en,data_in) ;
endinterface //inter_fifo