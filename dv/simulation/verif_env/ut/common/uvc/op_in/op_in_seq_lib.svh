`ifndef OP_IN_SEQ__SV
`define OP_IN_SEQ__SV
class op_in_seq_base extends uvm_sequence #(op_in_seq_item);

  // UVM Factory Registration Macro
  //
  `uvm_object_utils_begin(op_in_seq_base)
  `uvm_object_utils_end

  //------------------------------------------
  // Data Members
  //------------------------------------------

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
  extern function new(string name = "op_in_seq_base");
  extern function void pre_randomize();
  extern task pre_body();
  extern task post_body();

endclass: op_in_seq_base

function op_in_seq_base::new(string name = "op_in_seq_base");
  super.new(name);
  `uvm_info("TRACE",$sformatf("%m"), UVM_HIGH)
endfunction: new

function void op_in_seq_base::pre_randomize();
  
endfunction

task op_in_seq_base::pre_body();
  `ifdef UVM_VERSION_1_1
    if(get_parent_sequence() == null && starting_phase != null) begin
      uvm_objection objection = starting_phase.get_objection();
      objection.set_drain_time(this,25ns);
      starting_phase.raise_objection(this);
    end
  `endif
endtask

task op_in_seq_base::post_body();
  `ifdef UVM_VERSION_1_1
    if(get_parent_sequence() == null && starting_phase != null) begin 
      starting_phase.drop_objection(this);
    end
  `endif
endtask


class op_in_seq extends op_in_seq_base;

  // UVM Factory Registration Macro
  //
  `uvm_object_utils(op_in_seq)

  //------------------------------------------
  // Data Members
  //------------------------------------------

  //------------------------------------------
  // Constraints
  //------------------------------------------

  //------------------------------------------
  // Methods
  //------------------------------------------

  // Standard UVM Methods:
  extern function new(string name = "op_in_seq");
  extern virtual task body();

endclass: op_in_seq

function op_in_seq::new(string name = "op_in_seq");
  super.new(name);
  `uvm_info("TRACE",$sformatf("%m"), UVM_HIGH)
endfunction: new

task op_in_seq::body();
    
  `uvm_info("TRACE",$sformatf("%m"), UVM_HIGH)
  `uvm_do(req)
endtask
`endif

