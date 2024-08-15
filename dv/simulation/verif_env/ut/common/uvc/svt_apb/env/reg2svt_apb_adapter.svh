`ifndef REG2SVT_APB_ADAPTER__SV
`define REG2SVT_APB_ADAPTER__SV
class reg2svt_apb_adapter extends uvm_reg_adapter;

  // UVM Factory Registration Macro
  //
  `uvm_object_utils(reg2svt_apb_adapter)

  //------------------------------------------
  // Methods
  //------------------------------------------

  // Standard UVM Methods:
  extern function new(string name = "svt_apb_seq_item");
  extern function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
  extern function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);

endclass: reg2svt_apb_adapter

function reg2svt_apb_adapter::new(string name = "svt_apb_seq_item");
  super.new(name);
//  provides_responses = 1;
endfunction

function uvm_sequence_item reg2svt_apb_adapter::reg2bus(const ref uvm_reg_bus_op rw);
  svt_apb_master_transaction apb = svt_apb_master_transaction::type_id::create("apb");
  apb.xact_type = (rw.kind == UVM_READ) ? svt_apb_master_transaction::READ : svt_apb_master_transaction::WRITE;
  apb.address   = rw.addr;
  apb.data      = rw.data;
 
  return apb;

endfunction

function void reg2svt_apb_adapter::bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
  svt_apb_master_transaction apb;
  
  if(!($cast(apb, bus_item))) begin
    `uvm_fatal("NOT_APB_TYPT", "Provided bus_item is not of the correct type")
    return;
  end
  assert(rw.kind != svt_apb_master_transaction::IDLE) else begin
    `uvm_fatal("APB_IDLE", "svt_apb_master_transaction Should not be <IDLE> type in reg_adapter")
  end
  rw.kind = (apb.xact_type == svt_apb_master_transaction::READ) ? UVM_READ : UVM_WRITE;
  rw.addr = apb.address;
  rw.data = apb.data;

endfunction

`endif
