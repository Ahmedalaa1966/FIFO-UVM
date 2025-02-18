module FIFO(fifo_if.DUT c_if);
parameter FIFO_WIDTH = 16;
parameter FIFO_DEPTH = 8;
localparam max_fifo_addr = $clog2(FIFO_DEPTH);

reg [FIFO_WIDTH-1:0] mem [FIFO_DEPTH-1:0];

reg [max_fifo_addr-1:0] wr_ptr, rd_ptr;
reg [max_fifo_addr:0] count;

always @(posedge c_if.clk or negedge c_if.rst_n) begin
	if (!c_if.rst_n) begin
		wr_ptr <= 0;
		c_if.overflow <= 0 ;
		c_if.wr_ack <= 0 ;
	end
	else if (c_if.wr_en && count < FIFO_DEPTH) begin
		mem[wr_ptr] <= c_if.data_in;
		c_if.wr_ack <= 1;
		wr_ptr <= wr_ptr + 1;
	end
	else begin 
		c_if.wr_ack <= 0; 
		if (c_if.full & c_if.wr_en)
			c_if.overflow <= 1;
		else
			c_if.overflow <= 0;
	end  
end
always @(posedge c_if.clk or negedge c_if.rst_n) begin
	if (!c_if.rst_n) begin
		rd_ptr <= 0;
		c_if.underflow <= 0 ;
	end
	else if (c_if.rd_en && count != 0) begin
		c_if.data_out <= mem[rd_ptr];
		rd_ptr <= rd_ptr + 1;
		c_if.underflow <= 0 ;
	end
	else begin
		if(c_if.empty && c_if.rd_en)
		c_if.underflow <= 0;
		else
		c_if.underflow <=1 ;
	end
end
always @(posedge c_if.clk or negedge c_if.rst_n) begin
	if (!c_if.rst_n) begin
		count <= 0;
	end
	else begin
		if(c_if.wr_en && c_if.rd_en && !c_if.full && c_if.empty)
		  count <= count ;
		else if(c_if.w_en && !c_if.full)
		 count <= count +1 ;
		else if(c_if.rd_en && !c_iif.empty)
		 count <= count -1 ;
	end
     assign c_if.full = (count == FIFO_DEPTH)? 1 : 0;
	  assign c_if.empty = (count == 0)? 1 : 0;
	 assign  c_if.almostfull = (count == FIFO_DEPTH-2)? 1 : 0; 
	 assign c_if.almostempty = (count == 1)? 1 : 0;

end











property p1 ;
   @(posedge c_if.clk) (count == FIFO_DEPTH) |-> c_if.full ;
endproperty
property p2 ;
   @(posedge c_if.clk) $fell(count) |-> c_if.empty ;
endproperty
property p3;
	@(posedge c_if.clk) count == 1 |-> c_if.almostempty ;
endproperty
property p4;
    @(posedge c_if.clk) (count == FIFO_DEPTH-2 ) |-> c_if.almostfull ;
endproperty
property p5;
    @(posedge c_if.clk)   (c_if.empty && c_if.rd_en) |-> c_if.underflow ;
endproperty


assert property(p1) ;
assert property(p2) ;
assert property(p3) ;
assert property(p4) ;
assert property(p5) ;





endmodule





