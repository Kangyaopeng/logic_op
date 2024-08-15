class logic_reg_model extends uvm_reg_block;
	`uvm_object_utils(logic_reg_model)

	rand LOGIC_SEL       logic_sel;

	uvm_reg_map map;

	function new(string name = "logic_reg_model");
		super.new(name, UVM_NO_COVERAGE);
	endfunction

	virtual function build();
		logic_sel = LOGIC_SEL::type_id::create("logic_sel");
		logic_sel.configure(this, null, "");
		logic_sel.build();



		map = create_map("logic_op_map", 32'h00000, 'h4, UVM_LITTLE_ENDIAN);

		map.add_reg(logic_sel, 'h0, "RW");

		logic_sel.logic_sel.configure(logic_sel, 2, 0, "RW", 0, 2'h0, 1, 1, 0);
		logic_sel.add_hdl_path_slice("o_reg_logic_sel", 0, 2);

	endfunction:build

	virtual function void pack2struct(int id);
	endfunction: pack2struct

endclass
