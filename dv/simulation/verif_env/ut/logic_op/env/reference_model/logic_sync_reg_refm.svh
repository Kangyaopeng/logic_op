`ifndef LOGIC_SYNC_REG_REFM__SV
`define LOGIC_SYNC_REG_REFM__SV

class logic_sync_reg_refm extends uvm_component;

  // UVM Factory Registration Macro
  //
  `uvm_component_utils(logic_sync_reg_refm)

  //------------------------------------------
  // Data Members
  //------------------------------------------
  logic_op_env_config   env_cfg;
  //{trans_name}_seq_item rcv_trans;
  //{adp_name}_seq_item reg_trans;
  //reg update_flag = 1'b0;

  //------------------------------------------
  // Component Members
  //------------------------------------------
  //uvm_tlm_analysis_fifo #({trans_name}_seq_item) trans_fifo;
  //uvm_tlm_analysis_fifo #({adp_name}_seq_item) reg_fifo;

  //------------------------------------------
  // Methods
  //------------------------------------------

  // Standard UVM Methods:
  extern function new(string name="logic_sync_reg_refm", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);

  extern task get_reg_update();

endclass: logic_sync_reg_refm

function logic_sync_reg_refm::new(string name="logic_sync_reg_refm", uvm_component parent);
  super.new(name, parent);
  //trans_fifo = new("trans_fifo", this);
  //reg_fifo   = new("reg_fifo", this);
  //rcv_trans  = {trans_name}_seq_item::type_id::create("rcv_trans");
  //reg_trans  = {adp_name}_seq_item::type_id::create("reg_trans");
endfunction: new

function void logic_sync_reg_refm::build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!uvm_config_db#(logic_op_env_config)::get(this, "*", "logic_op_env_config", env_cfg))
    `uvm_error("CFGERR", "environment config is not set to reference_model!")
endfunction

task logic_sync_reg_refm::run_phase(uvm_phase phase);
  uvm_reg_field rgm_fields[$];
  uvm_reg_field local_field;
  get_reg_update();
  //forever begin
  //  if(get_parent().get_name()!="m_env") begin
  //    uvm_config_db#(bit)::wait_modified(null, "*", "{adp_name}_update");
  //    uvm_config_db#(bit)::get(null, "*", "{adp_name}_update", update_flag);
  //  end
  //  trans_fifo.get(rcv_trans);
  //  //@(posedge env_cfg.op_m_agt_cfg.vif.start);
  //  if(update_flag) begin
  //    update_flag = 0;
  //    env_cfg.rgm.get_fields(rgm_fields);
  //    foreach(rgm_fields[i]) begin
  //      local_field = env_cfg.sync_rgm.get_field_by_name(rgm_fields[i].get_name());
  //      local_field.predict(rgm_fields[i].get_mirrored_value());
  //    end
  //    `uvm_info("RGM_SYNC", {"\n", env_cfg.sync_rgm.sprint()}, UVM_MEDIUM)
  //  end
  //end
endtask

task logic_sync_reg_refm::get_reg_update();
  //fork
  //  forever begin
  //    reg_fifo.get(reg_trans);
  //    if(reg_trans.addr == `REG_UPD_ADDR && reg_trans.data == 32'h1) begin
  //      update_flag = 1;
  //      if(get_parent().get_name()=="m_env") begin
  //        uvm_config_db#(bit)::set(null, "*", "{adp_name}_update", update_flag);
  //      end
  //    end
  //  end  
  //join_none
endtask

`endif

