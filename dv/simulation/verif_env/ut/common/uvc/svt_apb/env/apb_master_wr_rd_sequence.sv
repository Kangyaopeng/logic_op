
/**
 * Abstract:
 * apb_master_wr_rd_sequence is used by test to provide initiator scenario
 * information to the Master agent present in the System agent.  This class
 * defines a sequence in which a random APB WRITE followed by a random APB READ
 * sequence is generated using `uvm_do_with macros.
 *
 * Execution phase: main_phase
 * Sequencer: Master agent sequencer
 */

`ifndef GUARD_APB_MASTER_WR_RD_SEQUENCE_SV
`define GUARD_APB_MASTER_WR_RD_SEQUENCE_SV

class apb_master_wr_rd_sequence extends svt_apb_master_base_sequence;

  /** Parameter that controls the number of transactions that will be generated */
  rand int unsigned sequence_length = 10;

  /** Constrain the sequence length to a reasonable value */
  constraint reasonable_sequence_length {
    sequence_length <= 100;
  }

  /** UVM Object Utility macro */
  `uvm_object_utils(apb_master_wr_rd_sequence)

  /** Class Constructor */
  function new(string name="apb_master_wr_rd_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    bit status;
    `uvm_info("body", "Entered ...", UVM_LOW)

    super.body();

    status = uvm_config_db #(int unsigned)::get(null, get_full_name(), "sequence_length", sequence_length);
    `uvm_info("body", $sformatf("sequence_length is %0d as a result of %0s.", sequence_length, status ? "config DB" : "randomization"), UVM_LOW);
    
    repeat (sequence_length) begin
      `ifndef SVT_UVM_1800_2_2017_OR_HIGHER
        `uvm_do_with(req, { xact_type == svt_apb_transaction::WRITE; })
      `else 
        `uvm_do(req,,, { xact_type == svt_apb_transaction::WRITE; })
      `endif
      // Turn off rand_mode of the address so that we read from the same location
      req.address.rand_mode(0);
      `ifndef SVT_UVM_1800_2_2017_OR_HIGHER
        `uvm_rand_send_with(req, { xact_type == svt_apb_transaction::READ; })
      `else 
        `uvm_rand_send(req,, { xact_type == svt_apb_transaction::READ; })
      `endif
    end

    `uvm_info("body", "Exiting...", UVM_LOW)
  endtask: body

endclass: apb_master_wr_rd_sequence

`endif // GUARD_APB_MASTER_WR_RD_SEQUENCE_SV
