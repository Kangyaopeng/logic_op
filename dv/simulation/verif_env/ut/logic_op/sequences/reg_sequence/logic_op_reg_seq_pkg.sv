`ifndef LOGIC_OP_REG_SEQ_PACKAGE__SV
`define LOGIC_OP_REG_SEQ_PACKAGE__SV
package logic_op_reg_seq_pkg;
  import uvm_pkg::*;

  //agent package

  //reg_model package
  import logic_reg_model_pkg::*;

  //env package
  import logic_op_env_pkg::*;

  //include reg_sequence
  `include "self_reg_access_seq.svh"
  `include "logic_op_reg_seq_lib.svh"

  //include other reg_sequence

endpackage
`endif
