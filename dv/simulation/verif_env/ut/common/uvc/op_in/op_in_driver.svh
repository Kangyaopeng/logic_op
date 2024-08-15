`ifndef OP_IN_DRIVER__SV
`define OP_IN_DRIVER__SV
`define DRV_VIF vif.drv_cb
typedef class op_in_driver;
class op_in_driver_callback extends uvm_callback;
  function new(string name = "op_in_driver_callback");
    super.new(name);
  endfunction
  virtual task pre_send(op_in_driver drv, op_in_seq_item tr); endtask
  virtual task post_send(op_in_driver drv, op_in_seq_item tr); endtask
endclass
class op_in_driver_example_callback extends op_in_driver_callback;
  virtual task pre_send(op_in_driver drv, op_in_seq_item tr); 
    `uvm_info("OP_IN_DRIVER_CALLBACK", "callback test", UVM_MEDIUM)  
  endtask
endclass

class op_in_driver extends uvm_driver #(op_in_seq_item);

  // UVM Factory Registration Macro
  //
  `uvm_component_utils(op_in_driver)
  `uvm_register_cb(op_in_driver, op_in_driver_callback)

  // Virtual Interface
  virtual op_in_if vif;

  //------------------------------------------
  // Data Members (Outputs rand, inputs non-rand)
  //------------------------------------------  

  //------------------------------------------
  // Methods
  //------------------------------------------

  // Standard UVM Methods:
  extern function new(string name, uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern virtual function void start_of_simulation_phase(uvm_phase phase);
  extern virtual task main_phase(uvm_phase phase);
  extern virtual task pre_reset_phase(uvm_phase phase);
  extern virtual task reset_phase(uvm_phase phase);

  // User_defined Methods
  extern virtual task send(op_in_seq_item tr);

endclass: op_in_driver

function op_in_driver::new(string name, uvm_component parent);
  super.new(name, parent);
  `uvm_info("TRACE",$sformatf("%m"), UVM_HIGH)
endfunction: new

function void op_in_driver::build_phase(uvm_phase phase);
  super.build_phase(phase);
  `uvm_info("TRACE",$sformatf("%m"), UVM_HIGH)
endfunction: build_phase

function void op_in_driver::start_of_simulation_phase(uvm_phase phase);
  super.start_of_simulation_phase(phase);
  `uvm_info("TRACE",$sformatf("%m"), UVM_HIGH)
endfunction: start_of_simulation_phase

task op_in_driver::main_phase(uvm_phase phase);
  
  `uvm_info("TRACE",$sformatf("%m"), UVM_HIGH)
  forever begin
    seq_item_port.get_next_item(req);
    `uvm_info("OP_IN_DRIVER_TRANS", req.sprint(), UVM_MEDIUM)

    `uvm_do_callbacks(op_in_driver, op_in_driver_callback, pre_send(this, req));
    send(req);
    `uvm_do_callbacks(op_in_driver, op_in_driver_callback, post_send(this, req));

    seq_item_port.item_done();
  end
endtask: main_phase

task op_in_driver::pre_reset_phase(uvm_phase phase);
  super.pre_reset_phase(phase);
  `uvm_info("TRACE",$sformatf("%m"), UVM_HIGH)
  phase.raise_objection(this);

  @(`DRV_VIF);
  `DRV_VIF.data1   <= 'x;
  `DRV_VIF.data2   <= 'x;
  `DRV_VIF.data_en <= 'x;

  phase.drop_objection(this);
endtask: pre_reset_phase

task op_in_driver::reset_phase(uvm_phase phase);
  super.reset_phase(phase);
  `uvm_info("TRACE",$sformatf("%m"), UVM_HIGH)
  phase.raise_objection(this);

  wait(`DRV_VIF.rst_n===1);
  wait(`DRV_VIF.rst_n===0);
  while(!`DRV_VIF.rst_n) begin
    @(`DRV_VIF);
  end

  @(`DRV_VIF);
  `DRV_VIF.data1   <= 'h0;
  `DRV_VIF.data2   <= 'h0;
  `DRV_VIF.data_en <= 'h0;

  phase.drop_objection(this);
endtask: reset_phase

task op_in_driver::send(op_in_seq_item tr);
    @(`DRV_VIF);
    `DRV_VIF.data_en <= 'b1;
    `DRV_VIF.data1   <= tr.data1;
    `DRV_VIF.data2   <= tr.data2;
    @(`DRV_VIF);
    `DRV_VIF.data_en <= 'b0;
    repeat(1) @(`DRV_VIF);
endtask: send

`undef DRV_VIF
`endif
