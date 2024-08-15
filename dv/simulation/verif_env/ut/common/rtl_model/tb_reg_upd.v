`ifndef TB_REG_UPD__SV
`define TB_REG_UPD__SV
module tb_reg_upd#(parameter UPDATE_ADDR = 32'h0000_0000)(
                 input  wire       clk
                ,input  wire       reg_clk
                ,input  wire       rst_n
                ,input  wire       sync
                ,input  wire       i_psel
                ,input  wire       i_penable
                ,input  wire       i_pwrite
                ,input  wire[31:0] i_paddr
                ,input  wire[31:0] i_pwdata
                ,output wire[31:0] o_prdata
                ,output reg        o_pready

								,output wire[0:0] o_reg_update
							);
endmodule
`endif
