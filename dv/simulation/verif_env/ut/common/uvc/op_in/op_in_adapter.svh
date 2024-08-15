`ifndef REG2OP_IN_ADAPTER__SV
`define REG2OP_IN_ADAPTER__SV
class reg2op_in_adapter extends uvm_reg_adapter;

  // UVM Factory Registration Macro
  //
  `uvm_object_utils(reg2op_in_adapter)

  //------------------------------------------
  // Methods
  //------------------------------------------

  // Standard UVM Methods:
  extern function new(string name = "op_in_seq_item");
  extern function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
  extern function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);

endclass: reg2op_in_adapter

function reg2op_in_adapter::new(string name = "op_in_seq_item");
  super.new(name);
//  provides_responses = 1;
endfunction

function uvm_sequence_item reg2op_in_adapter::reg2bus(const ref uvm_reg_bus_op rw);
  op_in_seq_item t = op_in_seq_item::type_id::create("t");
//  t.cmd = (rw.kind == UVM_WRITE) ? `WRITE : `READ;
//  t.addr = rw.addr;
//  t.wdata = rw.data;
  return t;
endfunction

function void reg2op_in_adapter::bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
  op_in_seq_item t;
  if (!$cast(t, bus_item)) begin
    `uvm_fatal("NOT_MCDF_BUS_TYPE","Provided bus_item is not of the correct type")
    return;
  end
//  rw.kind = (t.cmd == `WRITE) ? UVM_WRITE : UVM_READ;
//  rw.addr = t.addr;
//  rw.data = (t.cmd == `WRITE) ? t.wdata : t.rdata;
//  rw.status = UVM_IS_OK;
endfunction

`endif
