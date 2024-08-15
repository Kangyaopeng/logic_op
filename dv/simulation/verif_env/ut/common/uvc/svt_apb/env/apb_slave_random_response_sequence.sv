

/**
 * Abstract:
 * class apb_slave_random_response_sequence defines a sequence class that the
 * testbench uses to provide slave response to the Slave agent present in the
 * System agent. The sequence receives a response object of type
 * svt_apb_slave_transaction, from slave sequencer. The sequence class then
 * randomizes the response with constraints and provides it to the slave driver
 * within the slave agent.
 */
`ifndef GUARD_APB_SLAVE_RANDOM_RESPONSE_SEQUENCE_SV
`define GUARD_APB_SLAVE_RANDOM_RESPONSE_SEQUENCE_SV

class apb_slave_random_response_sequence extends svt_apb_slave_base_sequence;

  /** UVM Object Utility macro */
  `uvm_object_utils(apb_slave_random_response_sequence)

  /** Class Constructor */
  function new(string name="apb_slave_random_response_sequence");
    super.new(name);
  endfunction

  virtual task body();
    `uvm_info("body", "Entered ...", UVM_LOW)

    forever begin
      p_sequencer.response_request_port.peek(req);
      if (req.cfg == null) begin
        req.cfg = cfg;
      end

      /** 
       * Demonstration of response randomization with constraints.
       */
      `ifndef SVT_UVM_1800_2_2017_OR_HIGHER
        `uvm_rand_send_with(req, { pslverr_enable == 1'b0; })
      `else 
        `uvm_rand_send(req,, { pslverr_enable == 1'b0; })
      `endif
    end

    `uvm_info("body", "Exiting...", UVM_LOW)
  endtask: body

endclass: apb_slave_random_response_sequence

`endif // GUARD_APB_SLAVE_RANDOM_RESPONSE_SEQUENCE_SV
