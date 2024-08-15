`ifndef OP_IN_AGENT_PACKAGE__SV
`define OP_IN_AGENT_PACKAGE__SV
package op_in_agent_pkg;

import uvm_pkg::*;

`include "op_in_agent_config.svh"
`include "op_in_seq_item.svh"
`include "op_in_driver.svh"
`include "op_in_monitor.svh"
`include "op_in_sequencer.svh"
`include "op_in_agent.svh"

//adapter here

`include "op_in_seq_lib.svh"

endpackage

`include "op_in_if.sv"

  

`endif
