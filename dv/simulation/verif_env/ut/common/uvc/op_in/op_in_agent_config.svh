`ifndef OP_IN_AGENT_CONFIG__SV
`define OP_IN_AGENT_CONFIG__SV
class op_in_agent_config extends uvm_object;

  // UVM Factory Registration Macro
  //
  `uvm_object_utils(op_in_agent_config)

  // Virtual Interface
  virtual op_in_if vif;

  //------------------------------------------
  // Data Members
  //------------------------------------------
  // Is the agent active or passive
  uvm_active_passive_enum active = UVM_PASSIVE;

  //------------------------------------------
  // Methods
  //------------------------------------------
  // Standard UVM Methods:
  extern function new(string name="op_in_agent_config");

endclass: op_in_agent_config

function op_in_agent_config::new(string name="op_in_agent_config");
  super.new(name);
endfunction: new

`endif
