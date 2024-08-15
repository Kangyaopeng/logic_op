`ifndef OP_OUT_DRIVER__SV
`define OP_OUT_DRIVER__SV
`define DRV_VIF vif.drv_cb
typedef class op_out_driver;
class op_out_driver_callback extends uvm_callback;
  function new(string name = "op_out_driver_callback");
    super.new(name);
  endfunction
  virtual task pre_send(op_out_driver drv, op_out_seq_item tr); endtask
  virtual task post_send(op_out_driver drv, op_out_seq_item tr); endtask
endclass
class op_out_driver_example_callback extends op_out_driver_callback;
  virtual task pre_send(op_out_driver drv, op_out_seq_item tr); 
    `uvm_info("OP_OUT_DRIVER_CALLBACK", "callback test", UVM_MEDIUM)  
  endtask
endclass

class op_out_driver extends uvm_driver #(op_out_seq_item);

  // UVM Factory Registration Macro
  //
  `uvm_component_utils(op_out_driver)
  `uvm_register_cb(op_out_driver, op_out_driver_callback)

  // Virtual Interface
  virtual op_out_if vif;

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
  extern virtual task send(op_out_seq_item tr);

endclass: op_out_driver

function op_out_driver::new(string name, uvm_component parent);
  super.new(name, parent);
  `uvm_info("TRACE",$sformatf("%m"), UVM_HIGH)
endfunction: new

function void op_out_driver::build_phase(uvm_phase phase);
  super.build_phase(phase);
  `uvm_info("TRACE",$sformatf("%m"), UVM_HIGH)
endfunction: build_phase

function void op_out_driver::start_of_simulation_phase(uvm_phase phase);
  super.start_of_simulation_phase(phase);
  `uvm_info("TRACE",$sformatf("%m"), UVM_HIGH)
endfunction: start_of_simulation_phase

task op_out_driver::main_phase(uvm_phase phase);
  
  `uvm_info("TRACE",$sformatf("%m"), UVM_HIGH)
  forever begin
    seq_item_port.get_next_item(req);
    `uvm_info("OP_OUT_DRIVER_TRANS", req.sprint(), UVM_MEDIUM)

    `uvm_do_callbacks(op_out_driver, op_out_driver_callback, pre_send(this, req));
    send(req);
    `uvm_do_callbacks(op_out_driver, op_out_driver_callback, post_send(this, req));

    seq_item_port.item_done();
  end
endtask: main_phase

task op_out_driver::pre_reset_phase(uvm_phase phase);
  super.pre_reset_phase(phase);
  `uvm_info("TRACE",$sformatf("%m"), UVM_HIGH)
  phase.raise_objection(this);


  phase.drop_objection(this);
endtask: pre_reset_phase

task op_out_driver::reset_phase(uvm_phase phase);
  super.reset_phase(phase);
  `uvm_info("TRACE",$sformatf("%m"), UVM_HIGH)
  phase.raise_objection(this);


  phase.drop_objection(this);
endtask: reset_phase

task op_out_driver::send(op_out_seq_item tr);
    @(`DRV_VIF);
//    `DRV_VIF.in <= $urandom();
endtask: send

`undef DRV_VIF
`endif
