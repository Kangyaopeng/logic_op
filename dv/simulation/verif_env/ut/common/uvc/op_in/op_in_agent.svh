`ifndef OP_IN_AGENT__SV
`define OP_IN_AGENT__SV
class op_in_agent extends uvm_agent;

  // UVM Factory Registration Macro
  //
  `uvm_component_utils(op_in_agent)

  // Virtual Interface
  //virtual op_in_if vif;

  //------------------------------------------
  // Component Members
  //------------------------------------------
  op_in_sequencer seqr;
  op_in_driver drv;
  op_in_monitor mon;
  uvm_analysis_port #(op_in_seq_item) analysis_port;

  //------------------------------------------
  // Data Members
  //------------------------------------------
  op_in_agent_config agt_cfg;

  //------------------------------------------
  // Methods
  //------------------------------------------

  // Standard UVM Methods:
  extern function new(string name, uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual function void start_of_simulation_phase(uvm_phase phase);

endclass: op_in_agent

function op_in_agent::new(string name, uvm_component parent);
  super.new(name, parent);
  `uvm_info("TRACE",$sformatf("%m"), UVM_HIGH)
endfunction: new

function void op_in_agent::build_phase(uvm_phase phase);
  super.build_phase(phase);
  `uvm_info("TRACE",$sformatf("%m"), UVM_HIGH)
  if(!uvm_config_db#(op_in_agent_config)::get(this, "", "op_in_agent_config", agt_cfg)) begin
    `uvm_error("build_phase",$sformatf("agent config not found"))
  end

  //uvm_config_db#(virtual op_in_if)::get(this, "", "op_in_if", vif);
  //if(vif == null) begin
  //  `uvm_fatal("CFGERR",$sformatf("Interface for Agent not set"))
  //end

  //agt_cfg.vif = vif;
  if(agt_cfg.active == UVM_ACTIVE) begin
    seqr = op_in_sequencer::type_id::create("seqr", this);
    drv = op_in_driver::type_id::create("drv", this);
    drv.vif = agt_cfg.vif;
  end

  mon = op_in_monitor::type_id::create("mon", this);
  mon.vif = agt_cfg.vif;
endfunction: build_phase

function void op_in_agent::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  `uvm_info("TRACE",$sformatf("%m"), UVM_HIGH)

  if(agt_cfg.active == UVM_ACTIVE) begin
    drv.seq_item_port.connect(seqr.seq_item_export);
  end
  this.analysis_port = mon.analysis_port;

endfunction: connect_phase

function void op_in_agent::start_of_simulation_phase(uvm_phase phase);
  super.start_of_simulation_phase(phase);
  `uvm_info("TRACE",$sformatf("%m"), UVM_HIGH)
endfunction: start_of_simulation_phase

`endif
