
/**
 * Abstract:
 * This file defines a class that represents a customized APB Master 
 * transaction.  This class extends the APB VIP's svt_apb_master_transaction
 * class.  It adds distribution constraints for the transaction type.
 *
 * The transaction instance replaces the default master transaction object,
 * which is shown in env/ts.apb_base_test.sv
 */

`ifndef GUARD_CUST_SVT_APB_MASTER_TRANSACTION_SV
`define GUARD_CUST_SVT_APB_MASTER_TRANSACTION_SV

class cust_svt_apb_master_transaction extends svt_apb_master_transaction;

  int WRITE_wt = 40;
  int READ_wt  = 40;
  int IDLE_wt  = 10;

  // Declare user-defined constraints
  constraint master_constraints {
    xact_type dist { svt_apb_transaction::WRITE := WRITE_wt,
                     svt_apb_transaction::READ  := READ_wt,
                     svt_apb_transaction::IDLE  := IDLE_wt
                   }; 
  }

  /** UVM Object Utility macro */
  `uvm_object_utils_begin(cust_svt_apb_master_transaction)
     `uvm_field_int(WRITE_wt, UVM_ALL_ON)
     `uvm_field_int(READ_wt, UVM_ALL_ON)
     `uvm_field_int(IDLE_wt, UVM_ALL_ON)
  `uvm_object_utils_end

  /** Class Constructor */
  function new (string name = "cust_svt_apb_master_transaction");
    super.new(name);
  endfunction: new

endclass: cust_svt_apb_master_transaction

`endif // GUARD_CUST_SVT_APB_MASTER_TRANSACTION_SV
