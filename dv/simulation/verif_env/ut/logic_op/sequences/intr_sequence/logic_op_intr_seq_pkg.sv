`ifndef LOGIC_OP_INTR_SEQ_PACKAGE__SV
`define LOGIC_OP_INTR_SEQ_PACKAGE__SV
package logic_op_intr_seq_pkg;
  import uvm_pkg::*;

  //agent package

  //reg_model package
  import logic_reg_model_pkg::*;

  //env package
  import logic_op_env_pkg::*;

  // include intr_sequence
  `include "logic_op_intr_sequence_base.svh"

endpackage
`endif
