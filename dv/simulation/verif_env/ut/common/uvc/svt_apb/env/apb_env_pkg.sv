`ifndef APB_ENV_PACKAGE__SV
`define APB_ENV_PACKAGE__SV
package apb_env_pkg;
  import uvm_pkg::*;
  import svt_uvm_pkg::*;
  //import svt_apb_system_configuration_uvm_pkg::*;
  import svt_apb_uvm_pkg::*;

  `include "apb_basic_env.sv"
  `include "apb_shared_cfg.sv"
  `include "cust_svt_apb_master_transaction.sv"
  `include "apb_master_random_discrete_virtual_sequence.sv"
  `include "apb_simple_reset_sequence.sv"
  `include "apb_base_sequence.sv"

  `include "reg2svt_apb_adapter.svh"

endpackage
 // apb vip
`include "svt_apb_if.svi"
`include "apb_reset_if.svi"

`endif
// ***********************************************************************
// $Log: $
// $Revision $
