module logic_op_reg_ctrl(
                 input  wire       clk
                ,input  wire       rst_n
                ,input  wire       i_psel
                ,input  wire       i_penable
                ,input  wire       i_pwrite
                ,input  wire[31:0] i_paddr
                ,input  wire[31:0] i_pwdata
                ,output wire[31:0] o_prdata
                ,output reg        o_pready
								,output reg[1:0] o_reg_logic_sel
							);
	wire i_cs, i_rd, i_wr;
	wire[31:0] i_addr;
	wire[31:0] i_datai;
	reg [31:0] o_datao;

	wire reg_0x0_we;

	assign i_cs     = i_psel;
	assign i_wr     = i_penable && i_pwrite;
	assign i_rd     = (!i_penable) && (!i_pwrite);
	assign i_addr   = i_paddr;
	assign i_datai  = i_pwdata;
	assign o_prdata = o_datao;

	always @(posedge clk or negedge rst_n) begin
		if(!rst_n) o_pready <= 1'b0;
		else       o_pready <= i_psel && !i_penable;
	end

	assign reg_0x0_we = i_cs&&i_wr&&(i_addr==32'h0);

	//0x0 register
	always @(posedge clk or negedge rst_n) begin
		if(!rst_n)
			o_reg_logic_sel <= 2'h0;
		else if(reg_0x0_we==1'b1)
			o_reg_logic_sel <= i_datai[1:0];
	end

	always @(posedge clk or negedge rst_n) begin
		if(!rst_n) o_datao <= 32'h0;
		else if(i_cs&&i_rd) begin
			case(i_addr)
				32'h0: o_datao <= {30'h0,o_reg_logic_sel};
				default: o_datao <= 32'h0;
			endcase
		end
	end

endmodule
