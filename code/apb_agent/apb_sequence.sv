class base_sequence_apb extends uvm_sequence #(apb_xtns);

`uvm_object_utils(base_sequence_apb)

extern function new(string name="base_sequence_apb");

endclass

	function base_sequence_apb ::new(string name="base_sequence_apb");
		super.new(name);
	endfunction




class Ir_data extends base_sequence_apb;

`uvm_object_utils(Ir_data)

extern function new(string name="Ir_data");
extern task body();

endclass

	function Ir_data::new(string name="Ir_data");
		super.new(name);
	endfunction

	task Ir_data::body();
	begin
		req=apb_xtns::type_id::create("req");
		start_item(req);
		assert(req.randomize());
		finish_item(req);


	end
	endtask

class Ir_data_16 extends base_sequence_apb;

`uvm_object_utils(Ir_data_16)

extern function new(string name="Ir_data_16");
extern task body();

endclass

	function Ir_data_16::new(string name="Ir_data_16");
		super.new(name);
	endfunction

	task Ir_data_16::body();
	begin
		req=apb_xtns::type_id::create("req");
		repeat(16)
		begin
		start_item(req);
		assert(req.randomize());
		finish_item(req);
		end

	end
	endtask

class Ir_data_4 extends base_sequence_apb;

`uvm_object_utils(Ir_data_4)

extern function new(string name="Ir_data_4");
extern task body();

endclass

	function Ir_data_4::new(string name="Ir_data_4");
		super.new(name);
	endfunction

	task Ir_data_4::body();
	begin
		repeat(4)
		req=apb_xtns::type_id::create("req");
		start_item(req);
		assert(req.randomize());
		finish_item(req);


	end
	endtask


class Ir_data_8 extends base_sequence_apb;

`uvm_object_utils(Ir_data_8)

extern function new(string name="Ir_data_8");
extern task body();

endclass

	function Ir_data_8::new(string name="Ir_data_8");
		super.new(name);
	endfunction

	task Ir_data_8::body();
	begin
		repeat(8)
		req=apb_xtns::type_id::create("req");
		start_item(req);
		assert(req.randomize());
		finish_item(req);


	end
	endtask

