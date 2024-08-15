`ifndef OP_IN_ITF__SV
`define OP_IN_ITF__SV
interface op_in_if(input clk, input rst_n);
  logic[3:0] data1;
  logic[3:0] data2;
  logic data_en;

  parameter setup_time = 0.1ns;
  parameter hold_time = 0.1ns;

  clocking drv_cb @(posedge clk);
    default input #setup_time output #hold_time;
    output data1;
    output data2;
    output data_en;
    input  rst_n;
  endclocking: drv_cb

  clocking mon_cb @(posedge clk);
    default input #setup_time output #hold_time;
    input data1;
    input data2;
    input data_en;
    input  rst_n;
  endclocking: mon_cb

  modport drv(clocking drv_cb);
  modport mon(clocking mon_cb);
    

endinterface: op_in_if
`endif
