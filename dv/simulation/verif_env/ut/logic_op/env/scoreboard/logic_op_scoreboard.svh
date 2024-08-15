`ifndef LOGIC_OP_SCOREBOARD__SV
`define LOGIC_OP_SCOREBOARD__SV
typedef logic_op_scoreboard;
class logic_op_scoreboard_callback extends uvm_callback;
  function new(string name = "logic_op_scoreboard_callback");
    super.new(name);
  endfunction
  virtual task end_of_test(logic_op_scoreboard sb, uvm_phase phase); endtask
endclass

class logic_op_scoreboard_eot_callback extends logic_op_scoreboard_callback;
  logic_op_env_config  env_cfg;
  virtual task end_of_test(logic_op_scoreboard sb, uvm_phase phase);
    if(!uvm_config_db#(logic_op_env_config)::get(sb, "", "logic_op_env_config", env_cfg))
      `uvm_error("ENV_CFG_ERR", "env_cfg is not set to logic_op_scoreboard_callback")
    //@(negedge env_cfg.op_s_agt_cfg.vif.finish);
  endtask
endclass


class logic_op_scoreboard extends uvm_scoreboard;

  // UVM Factory Registration Macro
  //
  `uvm_component_utils(logic_op_scoreboard)
  `uvm_register_cb(logic_op_scoreboard, logic_op_scoreboard_callback)

  //------------------------------------------
  // Data Members
  //------------------------------------------
  logic_op_env_config  env_cfg;
  int exp_num=0, act_num=0;

  //------------------------------------------
  // Component Members
  //------------------------------------------
  //pre_fifo inst
  uvm_tlm_analysis_fifo #(op_out_seq_item) golden_op_out1_fifo;
  
  //post_fifo inst
  uvm_tlm_analysis_fifo #(op_out_seq_item) acutal_op_out1_fifo;

  //seq_item inst
  op_out_seq_item result_op_out1_expect;
  op_out_seq_item result_op_out1_actual;


  //------------------------------------------
  // File Members
  //------------------------------------------
  integer exp_prt_hdl;
  integer act_prt_hdl;
  uvm_table_printer print_debug;

  //------------------------------------------
  // Methods
  //------------------------------------------

  // Standard UVM Methods:
  extern function new(string name="logic_op_scoreboard", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void end_of_elaboration_phase(uvm_phase phase);
  extern function void final_phase(uvm_phase phase);
  extern function void report_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);

  virtual task shutdown_phase(uvm_phase phase);
    phase.raise_objection(this);
    //`uvm_do_callbacks(logic_op_scoreboard, logic_op_scoreboard_callback, end_of_test(this, phase));
    phase.drop_objection(this);
  endtask

endclass: logic_op_scoreboard

function logic_op_scoreboard::new(string name="logic_op_scoreboard", uvm_component parent);
  super.new(name, parent);
  $system("mkdir -p out");
  //pre_fifo new
  golden_op_out1_fifo = new("golden_op_out1_fifo", this);
  //golden_op_out1_fifo.print_enabled = 0;
  
  //post_fifo new
  acutal_op_out1_fifo = new("acutal_op_out1_fifo", this);
  //acutal_op_out1_fifo.print_enabled = 0;

  print_debug = new();
  print_debug.knobs.begin_elements = -1;
endfunction: new

function void logic_op_scoreboard::build_phase(uvm_phase phase);
  super.build_phase(phase);
  if(!uvm_config_db#(logic_op_env_config)::get(this, "*", "logic_op_env_config", env_cfg))
    `uvm_error("CFGERR", "environment config is not set to scoreboard!")
endfunction
function void logic_op_scoreboard::end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
  exp_prt_hdl = $fopen($psprintf("./out/%s_exp.log", this.get_full_name()), "w");
  act_prt_hdl = $fopen($psprintf("./out/%s_act.log", this.get_full_name()), "w");
endfunction
function void logic_op_scoreboard::final_phase(uvm_phase phase);
  super.final_phase(phase);
  $fclose(exp_prt_hdl);
  $fclose(act_prt_hdl);
endfunction
function void logic_op_scoreboard::report_phase(uvm_phase phase);
  super.report_phase(phase);
  if(act_num != exp_num) begin
    `uvm_error("LOGIC_OP_SCOREBOARD_MISS_COMPARE", $sformatf("Actual item is %d, Expect item is %d", act_num, exp_num))
  end
endfunction

task logic_op_scoreboard::run_phase(uvm_phase phase);
time rst_start_time = 0;
time rst_end_time = 0;
time exp_start_time = 0;
time exp_end_time = 0;
time act_start_time = 0;
time act_end_time = 0;
fork
  forever begin
    env_cfg.sys_rst.wait_for_reset();
    rst_start_time = $realtime;
    env_cfg.sys_rst.wait_for_reset_leave();
    rst_end_time = $realtime;
    `uvm_info("TIME_DEBUG", $sformatf("rst_begin_time = %0d, rst_end_time = %0d", rst_start_time, rst_end_time), UVM_MEDIUM)
  end
join_none
  forever begin
    fork
      //pre_fifo get
      begin
      do begin
        golden_op_out1_fifo.get(result_op_out1_expect);
        exp_start_time = result_op_out1_expect.get_begin_time();
        exp_end_time   = result_op_out1_expect.get_end_time();
        `uvm_info("EXP_TIME", $sformatf("exp_begin_time = %0d, exp_end_time = %0d", result_op_out1_expect.get_begin_time(), result_op_out1_expect.get_end_time()), UVM_MEDIUM)
      end while((exp_start_time<=rst_start_time&&exp_end_time>rst_start_time) || (exp_start_time<=rst_end_time&&exp_end_time>rst_end_time));
        exp_num += 1;
      end
      //post_fifo get
      begin
      do begin
        acutal_op_out1_fifo.get(result_op_out1_actual);
        act_start_time = result_op_out1_actual.get_begin_time();
        act_end_time   = result_op_out1_actual.get_end_time();
        `uvm_info("ACT_TIME", $sformatf("act_begin_time = %0d, act_end_time = %0d", result_op_out1_actual.get_begin_time(), result_op_out1_actual.get_end_time()), UVM_MEDIUM)
      end while((act_start_time<=rst_start_time&&act_end_time>rst_start_time) || (act_start_time<=rst_end_time&&act_end_time>rst_end_time));
        act_num += 1;
      end
    join
    if(result_op_out1_expect.compare(result_op_out1_actual)) begin
      `uvm_info("CHECK_PASS", "Transcation compared correct", UVM_LOW)
      `uvm_info("LOGIC_OP_SCOREBOARD_ACTUAL_RESULT", {"\n", result_op_out1_actual.sprint()}, UVM_MEDIUM)
    end
    else begin
      $fwrite(act_prt_hdl, "%s", "-----------------act-----------------");
      $fwrite(act_prt_hdl, "%s", "-------------------------------------");
      $fwrite(act_prt_hdl, "@%0t\n%s", $time, result_op_out1_actual.sprint(print_debug));
      $fwrite(exp_prt_hdl, "%s", "-----------------exp-----------------");
      $fwrite(exp_prt_hdl, "%s", "-------------------------------------");
      $fwrite(exp_prt_hdl, "@%0t\n%s", $time, result_op_out1_expect.sprint(print_debug));
      `uvm_error("CHECK_FAIL", "Transcation compared error")
      `uvm_info("LOGIC_OP_SCOREBOARD_EXPECT_RESULT", {"\n", result_op_out1_expect.sprint()}, UVM_MEDIUM)
      `uvm_info("LOGIC_OP_SCOREBOARD_EXPECT_RESULT", {"\n", result_op_out1_actual.sprint()}, UVM_MEDIUM)
    end
  end
endtask

`endif
