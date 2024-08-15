`ifndef OP_IN_SEQUENCER__SV
`define OP_IN_SEQUENCER__SV
class op_in_sequencer extends uvm_sequencer #(op_in_seq_item,op_in_seq_item);

  // UVM Factory Registration Macro
  //
	`uvm_component_utils(op_in_sequencer)

  //------------------------------------------
  // Data Members
  //------------------------------------------

  //------------------------------------------
  // Methods
  //------------------------------------------

  // Standard UVM Methods:
	extern function new(string name = "op_in_sequencer", uvm_component parent = null);

endclass: op_in_sequencer

function op_in_sequencer::new(string name = "op_in_sequencer", uvm_component parent = null);
	super.new(name, parent);
endfunction: new

`endif
