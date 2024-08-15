
/**
 * Abstract: 
 * class 'apb_basic_env' is extended from uvm_env base class.  It implements
 * the build phase to construct the structural elements of this environment.
 *
 * apb_basic_env is the testbench environment, which constructs two APB System
 * ENVs in the build_phase method using the UVM factory service.  The APB System
 * ENV  is the top level component provided by the APB VIP. The APB System ENV
 * in turn, instantiates constructs the APB Master and Slave agents. 
 *
 * apb_basic env also constructs the virtual sequencer. This virtual sequencer
 * in the testbench environment obtains a handle to the reset interface using
 * the config db.  This allows reset sequences to be written for this virtual
 * sequencer.
 *
 * The simulation ends after all the objections are dropped.  This is done by
 * using objections provided by phase arguments.
 */
`ifndef GUARD_APB_BASIC_ENV_SV
`define GUARD_APB_BASIC_ENV_SV

`include "apb_virtual_sequencer.sv"
`include "apb_shared_cfg.sv"

class apb_basic_env extends uvm_env;

  /** APB VIP Master ENV */
  svt_apb_system_env apb_master_env;

  /** APB VIP Slave  ENV */
  svt_apb_system_env apb_slave_env;

  /** Virtual Sequencer */
  apb_virtual_sequencer sequencer;

  /** APB System Configuration */
  apb_shared_cfg cfg;

  /** UVM Component Utility macro */
  `uvm_component_utils(apb_basic_env)

  /** Class Constructor */
  function new (string name="apb_basic_env", uvm_component parent=null);
    super.new (name, parent);
  endfunction

  /** Build the APB System ENV */
  virtual function void build_phase(uvm_phase phase);
    `uvm_info("build_phase", "Entered...",UVM_LOW)

    super.build_phase(phase);

    /**
     * Check if the configuration is passed to the environment.
     * If not then create the configuration and pass it to the VIP ENV.
     */
    if (!uvm_config_db#(apb_shared_cfg)::get(this, "", "cfg", cfg)) begin
      cfg = apb_shared_cfg::type_id::create("cfg", this);
    end

    /** Apply the configuration to the Master ENV */
    uvm_config_db#(svt_apb_system_configuration)::set(this, "apb_master_env", "cfg", cfg.master_cfg);

    /** Apply the configuration to the Slave ENV */
    uvm_config_db#(svt_apb_system_configuration)::set(this, "apb_slave_env", "cfg", cfg.slave_cfg);

    /** Construct the system agents */
    if(cfg.has_master_env) begin
      apb_master_env = svt_apb_system_env::type_id::create("apb_master_env", this);
    end
    if(cfg.has_slave_env) begin
      apb_slave_env = svt_apb_system_env::type_id::create("apb_slave_env", this);
    end

    /** Construct the virtual sequencer */
    sequencer = apb_virtual_sequencer::type_id::create("sequencer", this);

    `uvm_info("build_phase", "Exiting...", UVM_LOW)
  endfunction

endclass

`endif // GUARD_APB_BASIC_ENV_SV
