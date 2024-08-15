/***********************************************
#
#      Filename:    logic_op.v
#
#        Author:  Kang Yaopeng   -- 78490223@qq.com
#   Description:  ---
#        Create:  2019-11-06 19:48:33
# Last Modified:  2019-11-06 19:48:33
***********************************************/
module logic_op(
            input  wire       clk     ,
            input  wire       rst_n   ,
            input  wire       in_en   , 
            input  wire[3:0]  in1     , 
            input  wire[3:0]  in2     ,
            output reg [3:0]  out     ,
            output reg        out_en  ,

            input  wire       pclk    , 
            input  wire       presetn , 
            input  wire       psel    , 
            input  wire       penable , 
            input  wire       pwrite  , 
            input  wire[31:0] paddr   , 
            input  wire[31:0] pwdata  , 
            output reg [31:0] prdata  , 
            output reg        pready
           );

  reg[1:0] logic_sel;

	logic_op_reg_ctrl u_logic_op_reg_ctrl(
                .clk                  (pclk     )
                ,.rst_n               (presetn  )
                ,.i_psel              (psel     )
                ,.i_penable           (penable  )
                ,.i_pwrite            (pwrite   )
                ,.i_paddr             (paddr    )
                ,.i_pwdata            (pwdata   )
                ,.o_prdata            (prdata   )
                ,.o_pready            (pready   )
								,.o_reg_logic_sel     (logic_sel)
							);

  always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
      out <= 4'h0;
      out_en <= 1'b0;
    end
    else if(in_en) begin
      if(logic_sel==2'h0) begin
        out <= in1 & in2;
      end
      else if(logic_sel==2'h1) begin
        out <= in1 | in2;
      end
      else if(logic_sel==2'h2) begin
        out <= in1 ^~ in2;
      end
      else begin
        out <= in1 ^ in2;
      end
      out_en <= 1'b1;
    end      
    else begin
      out <= 4'h0;
      out_en <= 1'b0;
    end
  end

endmodule


