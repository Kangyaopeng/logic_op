`ifndef LOGIC_OP_SMOKE_TEST__SV
`define LOGIC_OP_SMOKE_TEST__SV
class logic_op_smoke_test extends logic_op_test_base;

  // UVM Factory Registration Macro
  //
	`uvm_component_utils(logic_op_smoke_test)

  //------------------------------------------
  // Members
  //------------------------------------------
  //<agent_name>_driver_example_callback <agent_name>_drv_exp_cb;

  //use for wait scoreboard compare completely
  //sb_eot_call_back eot_cb; 


  //------------------------------------------
  // Methods
  //------------------------------------------

  // Standard UVM Methods:
	extern function new(string name="logic_op_smoke_test", uvm_component parent);
	extern virtual function void build_phase(uvm_phase phase);
	extern virtual function void connect_phase(uvm_phase phase);

  task main_phase(uvm_phase phase);
    logic_op_smoke_vseq logic_op_vseq;
    phase.raise_objection(this);
    logic_op_vseq = new();
    logic_op_vseq.start(m_env.logic_op_vseqr);
    phase.drop_objection(this);
  endtask

endclass: logic_op_smoke_test

function logic_op_smoke_test::new(string name="logic_op_smoke_test", uvm_component parent);
	super.new(name, parent);
endfunction: new

function void logic_op_smoke_test::build_phase(uvm_phase phase);
	super.build_phase(phase);
  //env_cfg.has_logic_op_vseqr = 1;
	uvm_config_db #(uvm_object_wrapper)::set(this,"*m_env.logic_op_vseqr.main_phase","default_sequence", null);
  //uvm_config_db #(int)::set(this,"*m_env.logic_op_vseqr.*","item_count", 10);
endfunction: build_phase

function void logic_op_smoke_test::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
  //<agent_name>_drv_exp_cb = new();
  //uvm_callbacks #(<agent_name>_driver, <agent_name>_driver_callback)::add(m_env.<agent_name>_agt.drv, <agent_name>_drv_exp_cb);
  //uvm_callbacks #(<agent_name>_driver, <agent_name>_driver_callback)::display();

  //eot_cb = new();
  //uvm_callbacks #(xxx_scoreboard, xxx_scoreboard_callback)::add(m_env.xxx_scb, eot_cb);
endfunction: connect_phase

class logic_op_and_test extends logic_op_test_base;

  // UVM Factory Registration Macro
  //
	`uvm_component_utils(logic_op_and_test)

  //------------------------------------------
  // Members
  //------------------------------------------
  //<agent_name>_driver_example_callback <agent_name>_drv_exp_cb;

  //use for wait scoreboard compare completely
  //sb_eot_call_back eot_cb; 


  //------------------------------------------
  // Methods
  //------------------------------------------

  // Standard UVM Methods:
	extern function new(string name="logic_op_and_test", uvm_component parent);
	extern virtual function void build_phase(uvm_phase phase);
	extern virtual function void connect_phase(uvm_phase phase);

  task main_phase(uvm_phase phase);
    logic_op_and_vseq logic_op_vseq;
    phase.raise_objection(this);
    logic_op_vseq = new();
    logic_op_vseq.start(m_env.logic_op_vseqr);
    phase.drop_objection(this);
  endtask

endclass: logic_op_and_test

function logic_op_and_test::new(string name="logic_op_and_test", uvm_component parent);
	super.new(name, parent);
endfunction: new

function void logic_op_and_test::build_phase(uvm_phase phase);
	super.build_phase(phase);
  //env_cfg.has_logic_op_vseqr = 1;
	uvm_config_db #(uvm_object_wrapper)::set(this,"*m_env.logic_op_vseqr.main_phase","default_sequence", null);
  //uvm_config_db #(int)::set(this,"*m_env.logic_op_vseqr.*","item_count", 10);
endfunction: build_phase

function void logic_op_and_test::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
  //<agent_name>_drv_exp_cb = new();
  //uvm_callbacks #(<agent_name>_driver, <agent_name>_driver_callback)::add(m_env.<agent_name>_agt.drv, <agent_name>_drv_exp_cb);
  //uvm_callbacks #(<agent_name>_driver, <agent_name>_driver_callback)::display();

  //eot_cb = new();
  //uvm_callbacks #(xxx_scoreboard, xxx_scoreboard_callback)::add(m_env.xxx_scb, eot_cb);
endfunction: connect_phase

class logic_op_or_test extends logic_op_test_base;

  // UVM Factory Registration Macro
  //
	`uvm_component_utils(logic_op_or_test)

  //------------------------------------------
  // Members
  //------------------------------------------
  //<agent_name>_driver_example_callback <agent_name>_drv_exp_cb;

  //use for wait scoreboard compare completely
  //sb_eot_call_back eot_cb; 


  //------------------------------------------
  // Methods
  //------------------------------------------

  // Standard UVM Methods:
	extern function new(string name="logic_op_or_test", uvm_component parent);
	extern virtual function void build_phase(uvm_phase phase);
	extern virtual function void connect_phase(uvm_phase phase);

  task main_phase(uvm_phase phase);
    logic_op_or_vseq logic_op_vseq;
    phase.raise_objection(this);
    logic_op_vseq = new();
    logic_op_vseq.start(m_env.logic_op_vseqr);
    phase.drop_objection(this);
  endtask

endclass: logic_op_or_test

function logic_op_or_test::new(string name="logic_op_or_test", uvm_component parent);
	super.new(name, parent);
endfunction: new

function void logic_op_or_test::build_phase(uvm_phase phase);
	super.build_phase(phase);
  //env_cfg.has_logic_op_vseqr = 1;
	uvm_config_db #(uvm_object_wrapper)::set(this,"*m_env.logic_op_vseqr.main_phase","default_sequence", null);
  //uvm_config_db #(int)::set(this,"*m_env.logic_op_vseqr.*","item_count", 10);
endfunction: build_phase

function void logic_op_or_test::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
  //<agent_name>_drv_exp_cb = new();
  //uvm_callbacks #(<agent_name>_driver, <agent_name>_driver_callback)::add(m_env.<agent_name>_agt.drv, <agent_name>_drv_exp_cb);
  //uvm_callbacks #(<agent_name>_driver, <agent_name>_driver_callback)::display();

  //eot_cb = new();
  //uvm_callbacks #(xxx_scoreboard, xxx_scoreboard_callback)::add(m_env.xxx_scb, eot_cb);
endfunction: connect_phase

class logic_op_nxor_test extends logic_op_test_base;

  // UVM Factory Registration Macro
  //
	`uvm_component_utils(logic_op_nxor_test)

  //------------------------------------------
  // Members
  //------------------------------------------
  //<agent_name>_driver_example_callback <agent_name>_drv_exp_cb;

  //use for wait scoreboard compare completely
  //sb_eot_call_back eot_cb; 


  //------------------------------------------
  // Methods
  //------------------------------------------

  // Standard UVM Methods:
	extern function new(string name="logic_op_nxor_test", uvm_component parent);
	extern virtual function void build_phase(uvm_phase phase);
	extern virtual function void connect_phase(uvm_phase phase);

  task main_phase(uvm_phase phase);
    logic_op_nxor_vseq logic_op_vseq;
    phase.raise_objection(this);
    logic_op_vseq = new();
    logic_op_vseq.start(m_env.logic_op_vseqr);
    phase.drop_objection(this);
  endtask

endclass: logic_op_nxor_test

function logic_op_nxor_test::new(string name="logic_op_nxor_test", uvm_component parent);
	super.new(name, parent);
endfunction: new

function void logic_op_nxor_test::build_phase(uvm_phase phase);
	super.build_phase(phase);
  //env_cfg.has_logic_op_vseqr = 1;
	uvm_config_db #(uvm_object_wrapper)::set(this,"*m_env.logic_op_vseqr.main_phase","default_sequence", null);
  //uvm_config_db #(int)::set(this,"*m_env.logic_op_vseqr.*","item_count", 10);
endfunction: build_phase

function void logic_op_nxor_test::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
  //<agent_name>_drv_exp_cb = new();
  //uvm_callbacks #(<agent_name>_driver, <agent_name>_driver_callback)::add(m_env.<agent_name>_agt.drv, <agent_name>_drv_exp_cb);
  //uvm_callbacks #(<agent_name>_driver, <agent_name>_driver_callback)::display();

  //eot_cb = new();
  //uvm_callbacks #(xxx_scoreboard, xxx_scoreboard_callback)::add(m_env.xxx_scb, eot_cb);
endfunction: connect_phase

class logic_op_xor_test extends logic_op_test_base;

  // UVM Factory Registration Macro
  //
	`uvm_component_utils(logic_op_xor_test)

  //------------------------------------------
  // Members
  //------------------------------------------
  //<agent_name>_driver_example_callback <agent_name>_drv_exp_cb;

  //use for wait scoreboard compare completely
  //sb_eot_call_back eot_cb; 


  //------------------------------------------
  // Methods
  //------------------------------------------

  // Standard UVM Methods:
	extern function new(string name="logic_op_xor_test", uvm_component parent);
	extern virtual function void build_phase(uvm_phase phase);
	extern virtual function void connect_phase(uvm_phase phase);

  task main_phase(uvm_phase phase);
    logic_op_xor_vseq logic_op_vseq;
    phase.raise_objection(this);
    logic_op_vseq = new();
    logic_op_vseq.start(m_env.logic_op_vseqr);
    phase.drop_objection(this);
  endtask

endclass: logic_op_xor_test

function logic_op_xor_test::new(string name="logic_op_xor_test", uvm_component parent);
	super.new(name, parent);
endfunction: new

function void logic_op_xor_test::build_phase(uvm_phase phase);
	super.build_phase(phase);
  //env_cfg.has_logic_op_vseqr = 1;
	uvm_config_db #(uvm_object_wrapper)::set(this,"*m_env.logic_op_vseqr.main_phase","default_sequence", null);
  //uvm_config_db #(int)::set(this,"*m_env.logic_op_vseqr.*","item_count", 10);
endfunction: build_phase

function void logic_op_xor_test::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
  //<agent_name>_drv_exp_cb = new();
  //uvm_callbacks #(<agent_name>_driver, <agent_name>_driver_callback)::add(m_env.<agent_name>_agt.drv, <agent_name>_drv_exp_cb);
  //uvm_callbacks #(<agent_name>_driver, <agent_name>_driver_callback)::display();

  //eot_cb = new();
  //uvm_callbacks #(xxx_scoreboard, xxx_scoreboard_callback)::add(m_env.xxx_scb, eot_cb);
endfunction: connect_phase

`endif

