`ifndef OP_OUT_SEQUENCER__SV
`define OP_OUT_SEQUENCER__SV
class op_out_sequencer extends uvm_sequencer #(op_out_seq_item,op_out_seq_item);

  // UVM Factory Registration Macro
  //
	`uvm_component_utils(op_out_sequencer)

  //------------------------------------------
  // Data Members
  //------------------------------------------

  //------------------------------------------
  // Methods
  //------------------------------------------

  // Standard UVM Methods:
	extern function new(string name = "op_out_sequencer", uvm_component parent = null);

endclass: op_out_sequencer

function op_out_sequencer::new(string name = "op_out_sequencer", uvm_component parent = null);
	super.new(name, parent);
endfunction: new

`endif
