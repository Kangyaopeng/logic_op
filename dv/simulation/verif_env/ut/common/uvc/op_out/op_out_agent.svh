`ifndef OP_OUT_AGENT__SV
`define OP_OUT_AGENT__SV
class op_out_agent extends uvm_agent;

  // UVM Factory Registration Macro
  //
  `uvm_component_utils(op_out_agent)

  // Virtual Interface
  //virtual op_out_if vif;

  //------------------------------------------
  // Component Members
  //------------------------------------------
  op_out_sequencer seqr;
  op_out_driver drv;
  op_out_monitor mon;
  uvm_analysis_port #(op_out_seq_item) analysis_port;

  //------------------------------------------
  // Data Members
  //------------------------------------------
  op_out_agent_config agt_cfg;

  //------------------------------------------
  // Methods
  //------------------------------------------

  // Standard UVM Methods:
  extern function new(string name, uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual function void start_of_simulation_phase(uvm_phase phase);

endclass: op_out_agent

function op_out_agent::new(string name, uvm_component parent);
  super.new(name, parent);
  `uvm_info("TRACE",$sformatf("%m"), UVM_HIGH)
endfunction: new

function void op_out_agent::build_phase(uvm_phase phase);
  super.build_phase(phase);
  `uvm_info("TRACE",$sformatf("%m"), UVM_HIGH)
  if(!uvm_config_db#(op_out_agent_config)::get(this, "", "op_out_agent_config", agt_cfg)) begin
    `uvm_error("build_phase",$sformatf("agent config not found"))
  end

  //uvm_config_db#(virtual op_out_if)::get(this, "", "op_out_if", vif);
  //if(vif == null) begin
  //  `uvm_fatal("CFGERR",$sformatf("Interface for Agent not set"))
  //end

  //agt_cfg.vif = vif;
  if(agt_cfg.active == UVM_ACTIVE) begin
    seqr = op_out_sequencer::type_id::create("seqr", this);
    drv = op_out_driver::type_id::create("drv", this);
    drv.vif = agt_cfg.vif;
  end

  mon = op_out_monitor::type_id::create("mon", this);
  mon.vif = agt_cfg.vif;
endfunction: build_phase

function void op_out_agent::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  `uvm_info("TRACE",$sformatf("%m"), UVM_HIGH)

  if(agt_cfg.active == UVM_ACTIVE) begin
    drv.seq_item_port.connect(seqr.seq_item_export);
  end
  this.analysis_port = mon.analysis_port;

endfunction: connect_phase

function void op_out_agent::start_of_simulation_phase(uvm_phase phase);
  super.start_of_simulation_phase(phase);
  `uvm_info("TRACE",$sformatf("%m"), UVM_HIGH)
endfunction: start_of_simulation_phase

`endif
