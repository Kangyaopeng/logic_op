
/**
 * Abstract:
 * Defines an interface that provides access to a reset signal.  This
 * interface can be used to write sequences to drive the reset logic.
 */

`ifndef GUARD_APB_RESET_IF_SVI
`define GUARD_APB_RESET_IF_SVI

interface apb_reset_if();

  logic presetn;
  logic pclk;

  modport apb_reset_modport (input pclk, output presetn);

endinterface

`endif // GUARD_APB_RESET_IF_SVI
