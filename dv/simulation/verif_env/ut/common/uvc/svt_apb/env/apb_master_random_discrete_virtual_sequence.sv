
/**
 * Abstract:
 * class apb_master_random_discrete_virtual_sequence defines a virtual sequence
 * which is used as the default sequence for this environment.  The sequence
 * executes a apb_master_random_discrete_master_sequence on every master in the
 * environment.
 *
 * phase: main_phase
 * Sequencer: Virtual sequencer in APB System ENV
*/

`ifndef GUARD_APB_MASTER_RANDOM_DISCRETE_VIRTUAL_SEQUENCE_SV
`define GUARD_APB_MASTER_RANDOM_DISCRETE_VIRTUAL_SEQUENCE_SV

`include "apb_master_random_discrete_sequence.sv"

class apb_master_random_discrete_virtual_sequence extends svt_apb_system_base_sequence;

  /** Sequence length in used to constsrain the sequence length in sub-sequences */
  rand int unsigned sequence_length;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 100;
  }

  /** UVM Object Utility macro */
  `uvm_object_utils(apb_master_random_discrete_virtual_sequence)

  /** Class Constructor */
  function new (string name = "apb_master_random_discrete_virtual_sequence");
    super.new(name);
  endfunction : new

  /** Raise an objection if this is the parent sequence */
  virtual task pre_body();
    uvm_phase starting_phase_for_curr_seq;
    super.pre_body();
`ifdef SVT_UVM_12_OR_HIGHER
    starting_phase_for_curr_seq = get_starting_phase();
`else
    starting_phase_for_curr_seq = starting_phase;
`endif
  if (starting_phase_for_curr_seq!=null) begin
    starting_phase_for_curr_seq.raise_objection(this);
  end
  endtask: pre_body

  /** Drop an objection if this is the parent sequence */
  virtual task post_body();
    uvm_phase starting_phase_for_curr_seq;
    super.post_body();
`ifdef SVT_UVM_12_OR_HIGHER
    starting_phase_for_curr_seq = get_starting_phase();
`else
       starting_phase_for_curr_seq = starting_phase;
`endif
  if (starting_phase_for_curr_seq!=null) begin
    starting_phase_for_curr_seq.drop_objection(this);
  end
  endtask: post_body
  
  virtual task body();
    bit status;
    int local_sequence_length;
    apb_master_random_discrete_sequence master_seq;

    `uvm_info("body", "Entered...", UVM_LOW)

    status = uvm_config_db#(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
    `uvm_info("body", $sformatf("sequence_length is %0d as a result of %0s.", sequence_length, status ? "config DB" : "randomization"), UVM_LOW);

    /**
     * Since the contained sequence and this one have the same property name, the
     * inline constraint was not able to resolve to the correct scope.  Therefore the
     * sequence length of the virtual sequencer is assigned to a local property which
     * is used in the constraint.
     */
    local_sequence_length = sequence_length;

    /** Run the sequence the master sequencer */
    master_seq = new("master_seq");
    `ifndef SVT_UVM_1800_2_2017_OR_HIGHER
      `uvm_do_on_with(master_seq, p_sequencer.master_sequencer, {sequence_length == local_sequence_length;})
    `else
      `uvm_do(master_seq, p_sequencer.master_sequencer,, {sequence_length == local_sequence_length;})
    `endif

    `uvm_info("body", "Exiting...", UVM_LOW)
  endtask: body

endclass: apb_master_random_discrete_virtual_sequence 

`endif // GUARD_APB_VIRTUAL_MASTER_RANDOM_DISCRETE_SEQUENCE_UVM_SV

