`ifndef LOGIC_OP_REG_SEQ__SV
`define LOGIC_OP_REG_SEQ__SV
class logic_op_reg_seq_base extends uvm_reg_sequence;
  // UVM Factory Registration Macro
  //
  `uvm_object_utils(logic_op_reg_seq_base)
  //`uvm_declare_p_sequencer(xxx_sequencer)

  //------------------------------------------
  // Data Members
  //------------------------------------------
  logic_op_env_config env_cfg;

  //------------------------------------------
  // Component Members
  //------------------------------------------
  logic_reg_model rgm;

  //------------------------------------------
  // Methods
  //------------------------------------------

  // Standard UVM Methods:  
  extern function new(string name = "logic_op_reg_seq_base");
  extern task pre_start();


endclass: logic_op_reg_seq_base

function logic_op_reg_seq_base::new(string name = "logic_op_reg_seq_base");
  super.new(name);
  //if(!uvm_config_db#(logic_op_reg_model)::get(null, "uvm_test_top.m_env*", "logic_op_rgm", rgm)) begin
  //  `uvm_error("GETRGM", "no top-down RGM hangle is assigned")
  //end
endfunction

task logic_op_reg_seq_base::pre_start();
  if(!uvm_config_db#(logic_op_env_config)::get(get_sequencer(), "", "logic_op_env_config", env_cfg))
    `uvm_fatal("CFGERR", "environment config is not set to reg_sequence!")
  else
    rgm = env_cfg.rgm;
endtask

class logic_op_reg_seq extends logic_op_reg_seq_base;
  // UVM Factory Registration Macro
  //
  `uvm_object_utils(logic_op_reg_seq)
  //`uvm_declare_p_sequencer(xxx_sequencer)

  //------------------------------------------
  // Data Members
  //------------------------------------------

  //------------------------------------------
  // Component Members
  //------------------------------------------

  //------------------------------------------
  // Methods
  //------------------------------------------

  // Standard UVM Methods:  
  extern function new(string name = "logic_op_reg_seq");


  task body();
    uvm_status_e status;
    uvm_reg_data_t data;
    rgm.logic_sel.logic_sel.set(1);
    rgm.update(status, UVM_FRONTDOOR);
  endtask

endclass: logic_op_reg_seq

function logic_op_reg_seq::new(string name = "logic_op_reg_seq");
  super.new(name);
endfunction

class logic_op_and_reg_seq extends logic_op_reg_seq_base;
  // UVM Factory Registration Macro
  //
  `uvm_object_utils(logic_op_and_reg_seq)
  //`uvm_declare_p_sequencer(xxx_sequencer)

  //------------------------------------------
  // Data Members
  //------------------------------------------

  //------------------------------------------
  // Component Members
  //------------------------------------------

  //------------------------------------------
  // Methods
  //------------------------------------------

  // Standard UVM Methods:  
  extern function new(string name = "logic_op_and_reg_seq");


  task body();
    uvm_status_e status;
    uvm_reg_data_t data;
    rgm.logic_sel.logic_sel.set(0);
    rgm.update(status, UVM_FRONTDOOR);
  endtask

endclass: logic_op_and_reg_seq

function logic_op_and_reg_seq::new(string name = "logic_op_and_reg_seq");
  super.new(name);
endfunction

class logic_op_or_reg_seq extends logic_op_reg_seq_base;
  // UVM Factory Registration Macro
  //
  `uvm_object_utils(logic_op_or_reg_seq)
  //`uvm_declare_p_sequencer(xxx_sequencer)

  //------------------------------------------
  // Data Members
  //------------------------------------------

  //------------------------------------------
  // Component Members
  //------------------------------------------

  //------------------------------------------
  // Methods
  //------------------------------------------

  // Standard UVM Methods:  
  extern function new(string name = "logic_op_or_reg_seq");


  task body();
    uvm_status_e status;
    uvm_reg_data_t data;
    rgm.logic_sel.logic_sel.set(1);
    rgm.update(status, UVM_FRONTDOOR);
  endtask

endclass: logic_op_or_reg_seq

function logic_op_or_reg_seq::new(string name = "logic_op_or_reg_seq");
  super.new(name);
endfunction

class logic_op_nxor_reg_seq extends logic_op_reg_seq_base;
  // UVM Factory Registration Macro
  //
  `uvm_object_utils(logic_op_nxor_reg_seq)
  //`uvm_declare_p_sequencer(xxx_sequencer)

  //------------------------------------------
  // Data Members
  //------------------------------------------

  //------------------------------------------
  // Component Members
  //------------------------------------------

  //------------------------------------------
  // Methods
  //------------------------------------------

  // Standard UVM Methods:  
  extern function new(string name = "logic_op_nxor_reg_seq");


  task body();
    uvm_status_e status;
    uvm_reg_data_t data;
    rgm.logic_sel.logic_sel.set(2);
    rgm.update(status, UVM_FRONTDOOR);
  endtask

endclass: logic_op_nxor_reg_seq

function logic_op_nxor_reg_seq::new(string name = "logic_op_nxor_reg_seq");
  super.new(name);
endfunction

class logic_op_xor_reg_seq extends logic_op_reg_seq_base;
  // UVM Factory Registration Macro
  //
  `uvm_object_utils(logic_op_xor_reg_seq)
  //`uvm_declare_p_sequencer(xxx_sequencer)

  //------------------------------------------
  // Data Members
  //------------------------------------------

  //------------------------------------------
  // Component Members
  //------------------------------------------

  //------------------------------------------
  // Methods
  //------------------------------------------

  // Standard UVM Methods:  
  extern function new(string name = "logic_op_xor_reg_seq");


  task body();
    uvm_status_e status;
    uvm_reg_data_t data;
    rgm.logic_sel.logic_sel.set(3);
    rgm.update(status, UVM_FRONTDOOR);
  endtask

endclass: logic_op_xor_reg_seq

function logic_op_xor_reg_seq::new(string name = "logic_op_xor_reg_seq");
  super.new(name);
endfunction
`endif
