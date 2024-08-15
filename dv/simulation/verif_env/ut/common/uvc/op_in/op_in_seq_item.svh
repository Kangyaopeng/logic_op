`ifndef OP_IN_SEQ_ITEM__SV
`define OP_IN_SEQ_ITEM__SV
class op_in_seq_item extends uvm_sequence_item;

  //------------------------------------------
  // Data Members (Outputs rand, inputs non-rand)
  //------------------------------------------
  rand bit[3:0] data1;
  rand bit[3:0] data2;


  // UVM Factory Registration Macro
  //
  `uvm_object_utils_begin(op_in_seq_item)
    `uvm_field_int(data1, UVM_ALL_ON)
    `uvm_field_int(data2, UVM_ALL_ON)
  `uvm_object_utils_end

  //------------------------------------------
  // Constraints
  //------------------------------------------
  constraint valid{
    //data inside {[8'h0:8'hf0]};
  }

  //------------------------------------------
  // Methods
  //------------------------------------------

  // Standard UVM Methods:
  extern function new(string name = "op_in_seq_item");

endclass: op_in_seq_item

function op_in_seq_item::new(string name = "op_in_seq_item");
  super.new(name);
  `uvm_info("TRACE",$sformatf("%m"), UVM_HIGH)
endfunction: new

`endif

