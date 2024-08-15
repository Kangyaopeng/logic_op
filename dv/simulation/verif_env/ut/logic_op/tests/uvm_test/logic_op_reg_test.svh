`ifndef LOGIC_OP_REG_TEST__SV
`define LOGIC_OP_REG_TEST__SV
class logic_op_reg_smoke_test extends logic_op_test_base;

  // UVM Factory Registration Macro
  //
  `uvm_component_utils(logic_op_reg_smoke_test)

  //------------------------------------------
  // Methods
  //------------------------------------------

  // Standard UVM Methods:
  extern function new(string name="logic_op_reg_smoke_test", uvm_component parent);
	extern virtual function void build_phase(uvm_phase phase);

  task main_phase(uvm_phase phase);
    uvm_status_e          status;
    uvm_reg_data_t        data;
    uvm_reg_hw_reset_seq  rst_seq;
    self_reg_access_seq    acs_seq;
  
    phase.raise_objection(this);
    rst_seq = new();
    rst_seq.model = rgm;
    rst_seq.start(null);
  
    acs_seq = new();
    acs_seq.model = rgm;
    acs_seq.start(null);  
    phase.drop_objection(this);
  endtask

endclass: logic_op_reg_smoke_test

function logic_op_reg_smoke_test::new(string name="logic_op_reg_smoke_test", uvm_component parent);
  super.new(name, parent);
endfunction

function void logic_op_reg_smoke_test::build_phase(uvm_phase phase);
	super.build_phase(phase);
  // turn on/off those component
  // Example: env_cfg.has_scoreboard = 0;
endfunction: build_phase


class logic_op_reg_test extends logic_op_test_base;

  // UVM Factory Registration Macro
  //
  `uvm_component_utils(logic_op_reg_test)

  //------------------------------------------
  // Methods
  //------------------------------------------

  // Standard UVM Methods:
  extern function new(string name, uvm_component parent);

  task main_phase(uvm_phase phase);
    logic_op_reg_seq seq;
    phase.raise_objection(this);
    seq = new();
    seq.start(m_env.apb_agt.seqr);
    phase.drop_objection(this);
  endtask

endclass: logic_op_reg_test

function logic_op_reg_test::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction

`endif
