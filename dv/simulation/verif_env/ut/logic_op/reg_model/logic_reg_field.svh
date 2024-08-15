class LOGIC_SEL extends uvm_reg;
	`uvm_object_utils(LOGIC_SEL)
	rand uvm_reg_field logic_sel;

	function new(string name = "LOGIC_SEL");
		super.new(name, 32, UVM_NO_COVERAGE);
	endfunction

	virtual function build();
		logic_sel       = uvm_reg_field::type_id::create("logic_sel",,get_full_name());
	endfunction
endclass

