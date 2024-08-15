class apb_base_sequence extends svt_apb_master_base_sequence;

  /** UVM Object Utility macro */
  `uvm_object_utils(apb_base_sequence)

  /** Class Constructor */
  function new(string name="apb_base_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    svt_apb_master_transaction write_tran, read_tran, idle_trans;
    bit status;
    `uvm_info("body", "Entered ...", UVM_LOW)

    super.body();

    `uvm_info("body", "apb_base_sequence completed", UVM_LOW);
    `uvm_info("body", "Exiting...", UVM_LOW)
  endtask: body

    extern virtual task apb_write(input bit [31:0] waddr, input  bit [31:0] wdata);
    extern virtual task apb_read (input bit [31:0] raddr, output bit [31:0] rdata);

endclass: apb_base_sequence


task apb_base_sequence::apb_write(input bit [31:0] waddr, input  bit [31:0] wdata);
  
  svt_apb_master_transaction write_tran;

   `uvm_create(write_tran)
   write_tran.cfg       = cfg;
   write_tran.xact_type = svt_apb_transaction::WRITE;
   write_tran.address   = waddr;
   write_tran.data      = wdata;
   write_tran.num_wait_cycles = 3;
 
   /** Send the write transaction */
   `uvm_send(write_tran)
 
   /** Wait for the write transaction to complete */
   get_response(rsp);
endtask


task apb_base_sequence::apb_read(input bit [31:0] raddr, output  bit [31:0] rdata);
   
  svt_apb_master_transaction read_tran;
  
  `uvm_create(read_tran)
   read_tran.cfg       = cfg;
   read_tran.xact_type = svt_apb_transaction::READ;
   read_tran.address   = raddr;
   //write_tran.data      = wdata;
   //write_tran.num_wait_cycles = 3;
 
   /** Send the write transaction */
   `uvm_send(read_tran)
 
   /** Wait for the write transaction to complete */
   get_response(rsp);

   rdata = rsp.data;

endtask

