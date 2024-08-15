`ifndef OP_OUT_ITF__SV
`define OP_OUT_ITF__SV
interface op_out_if(input clk, input rst_n);
  logic[3:0] data;
  logic data_en;

  parameter setup_time = 0.1ns;
  parameter hold_time = 0.1ns;

  clocking drv_cb @(posedge clk);
    default input #setup_time output #hold_time;
    //output in;
  endclocking: drv_cb

  clocking mon_cb @(posedge clk);
    default input #setup_time output #hold_time;
    //input in, out;
    input rst_n;
    input data;
    input data_en;
  endclocking: mon_cb

  modport drv(clocking drv_cb);
  modport mon(clocking mon_cb);
    

endinterface: op_out_if
`endif
