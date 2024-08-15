`ifndef LOGIC_OP_REFM__SV
`define LOGIC_OP_REFM__SV
//import "DPI-C" function <return_type> xxx(input int a, output int b, ...);
import "DPI-C" function void logic_op_dpi(input int data1, input int data2, input int sel, output int data);

class logic_op_refm extends uvm_component;

  // UVM Factory Registration Macro
  //
  `uvm_component_utils(logic_op_refm)
  //------------------------------------------
  // Data Members
  //------------------------------------------
  logic_op_env_config   env_cfg;
  op_in_seq_item    op_in1_trans;
  op_out_seq_item op_out1_exp_trans;
  op_out_seq_item op_out1_exp_trans_clone;

  //------------------------------------------
  // Component Members
  //------------------------------------------
  uvm_tlm_analysis_fifo #(op_in_seq_item) op_in1_fifo;
  uvm_analysis_port #(op_out_seq_item) op_out1_ap;

  //------------------------------------------
  // Methods
  //------------------------------------------

  // Standard UVM Methods:
  extern function new(string name="logic_op_refm", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);

endclass: logic_op_refm

function logic_op_refm::new(string name="logic_op_refm", uvm_component parent);
  super.new(name, parent);
  op_in1_fifo  = new("op_in1_fifo", this);
  op_out1_ap         = new("op_out1_ap", this);
  op_in1_trans = op_in_seq_item::type_id::create("op_in1_trans");;
  op_out1_exp_trans = op_out_seq_item::type_id::create("op_out1_exp_trans");
endfunction: new

function void logic_op_refm::build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!uvm_config_db#(logic_op_env_config)::get(this, "*", "logic_op_env_config", env_cfg))
    `uvm_error("CFGERR", "environment config is not set to reference_model!")
endfunction

task logic_op_refm::run_phase(uvm_phase phase);
  time rst_start_time = 0;
  time rst_end_time = 0;
  time exp_start_time = 0;
  time exp_end_time = 0;
  fork
    forever begin
      env_cfg.sys_rst.wait_for_reset();
      rst_start_time = $realtime;
      env_cfg.sys_rst.wait_for_reset_leave();
      rst_end_time = $realtime;
      `uvm_info("RESET_TIME", $sformatf("rst_begin_time = %0d, rst_end_time = %0d", rst_start_time, rst_end_time), UVM_MEDIUM)
    end
  join_none
  forever begin
    do begin
      op_in1_fifo.get(op_in1_trans);
      exp_start_time = op_in1_trans.get_begin_time();
      exp_end_time   = op_in1_trans.get_end_time();
      `uvm_info("EXP_TIME", $sformatf("exp_begin_time = %0d, exp_end_time = %0d", op_in1_trans.get_begin_time(), op_in1_trans.get_end_time()), UVM_MEDIUM)
    end while((exp_start_time<=rst_start_time&&exp_end_time>rst_start_time) || (exp_start_time<=rst_end_time&&exp_end_time>rst_end_time));
    op_in1_trans.accept_tr(); //rcv_trans.accept_time set to current time

    //op_out1_exp_trans.data = op_in1_trans.data1 & op_in1_trans.data2;
    logic_op_dpi(op_in1_trans.data1, op_in1_trans.data2, env_cfg.rgm.logic_sel.logic_sel.get(), op_out1_exp_trans.data);
    $cast(op_out1_exp_trans_clone, op_out1_exp_trans.clone());

    //op_out1_exp_trans_clone.begin_tr(op_in1_exp_trans.get_begin_time);
    //op_out1_exp_trans_clone.end_tr(op_in1_exp_trans.get_end_time);
    //op_out1_exp_trans_clone.accept_tr(op_in1_exp_trans.get_accept_time);
    op_out1_ap.write(op_out1_exp_trans_clone);
  end
endtask

`endif
