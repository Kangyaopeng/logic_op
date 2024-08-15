`ifndef LOGIC_OP_TEST__SV
`define LOGIC_OP_TEST__SV
program automatic logic_op_test;
  import uvm_pkg::*;
	`include "uvm_macros.svh"

  import logic_op_testcase_pkg::*;
	initial begin
		$timeformat(-9, 3, " ns", 10);
    //set virtual interface to environment
		run_test();
	end

endprogram
`endif
