class virtual_sequence extends uvm_sequence #(uvm_sequence_item);

`uvm_object_utils(virtual_sequence)

ahb_sequencer ahb_sqr;
apb_sequencer apb_sqr;
virtual_sequencer v_sqr;

simple_write test_case_write; 
Ir_data ir_data;
Ir_data_4 ir_data_4;
Ir_data_8 ir_data_8;
Ir_data_16 ir_data_16;

wrap_4 wr_4;
wrap_8 wr_8;
wrap_16 wr_16;
increment_4 in_4;
increment_8 in_8;
increment_16 in_16;
extern function new (string name="virtual_sequence");
extern task body(); 

endclass	

	function virtual_sequence::new(string name="virtual_sequence");
		super.new(name);
	endfunction

	task virtual_sequence::body();
		if(!$cast(v_sqr,m_sequencer))
			`uvm_error("virtual_sequence","casting failed");
	this.ahb_sqr=v_sqr.ahb_sqr;
	this.apb_sqr=v_sqr.apb_sqr;
	endtask

//**simple_trasfer
class virtual_sequence_one extends virtual_sequence;

`uvm_object_utils(virtual_sequence_one)

extern function new(string name="virtual_sequence_one");
extern task body();

endclass

	function virtual_sequence_one::new(string name="virtual_sequence_one");
		super.new(name);
	endfunction

	task virtual_sequence_one::body();
		super.body();
		test_case_write=simple_write::type_id::create("test_case_write");
		//test_case_read=simple_read::type_id::create("test_case_read");
		//wr_4=wrap_4::type_id::create("wr_4");
		//wr_8=wrap_8::type_id::create("wr_8");
		

		ir_data=Ir_data::type_id::create("ir_data");
		fork
			begin
				test_case_write.start(ahb_sqr);
			//	wr_4.start(ahb_sqr);
			//	wr_8.start(ahb_sqr);
			//	test_case_read.start(ahb_sqr);
				
			end	
			begin
				ir_data.start(apb_sqr);
			end
		join
	endtask

//**wrap_4

class virtual_sequence_two extends virtual_sequence;

`uvm_object_utils(virtual_sequence_two)

extern function new(string name="virtual_sequence_two");
extern task body();

endclass

	function virtual_sequence_two::new(string name="virtual_sequence_two");
		super.new(name);
	endfunction

	task virtual_sequence_two::body();
		super.body();
	//	test_case_write=simple_write::type_id::create("test_case_write");
	//	test_case_read=simple_read::type_id::create("test_case_read");
		wr_4=wrap_4::type_id::create("wr_4");
	//	wr_8=wrap_8::type_id::create("wr_8");
		

		ir_data_4=Ir_data_4::type_id::create("ir_data_4");
		fork
			begin
			//	test_case_write.start(ahb_sqr);
				wr_4.start(ahb_sqr);
			//	wr_8.start(ahb_sqr);
			//	test_case_read.start(ahb_sqr);
				
			end	
			begin
				ir_data_4.start(apb_sqr);
			end
		join
	
	endtask


//**wrap_8

class virtual_sequence_three extends virtual_sequence;

`uvm_object_utils(virtual_sequence_three)

extern function new(string name="virtual_sequence_three");
extern task body();

endclass

	function virtual_sequence_three::new(string name="virtual_sequence_three");
		super.new(name);
	endfunction

	task virtual_sequence_three::body();
		super.body();
	//	test_case_write=simple_write::type_id::create("test_case_write");
	//	test_case_read=simple_read::type_id::create("test_case_read");
	//	wr_4=wrap_4::type_id::create("wr_4");
		wr_8=wrap_8::type_id::create("wr_8");
		

		ir_data_8=Ir_data_8::type_id::create("ir_data_8");
		fork
			begin
			//	test_case_write.start(ahb_sqr);
			//	wr_4.start(ahb_sqr);
				wr_8.start(ahb_sqr);
			//	test_case_read.start(ahb_sqr);
				
			end	
			begin
				ir_data_8.start(apb_sqr);
			end
		join
	
	endtask

//**wrap_16
class virtual_sequence_four extends virtual_sequence;

`uvm_object_utils(virtual_sequence_four)

extern function new(string name="virtual_sequence_four");
extern task body();

endclass

	function virtual_sequence_four::new(string name="virtual_sequence_four");
		super.new(name);
	endfunction

	task virtual_sequence_four::body();
		super.body();
	//	test_case_write=simple_write::type_id::create("test_case_write");
	//	test_case_read=simple_read::type_id::create("test_case_read");
	//	wr_4=wrap_4::type_id::create("wr_4");
		wr_16=wrap_16::type_id::create("wr_16");
		

		ir_data_16=Ir_data_16::type_id::create("ir_data_16");
		fork
			begin
			//	test_case_write.start(ahb_sqr);
			//	wr_4.start(ahb_sqr);
				wr_16.start(ahb_sqr);
			//	test_case_read.start(ahb_sqr);
				
			end	
			begin
				ir_data_16.start(apb_sqr);
			end
		join
	
	endtask

//**in_4

class virtual_sequence_five extends virtual_sequence;

`uvm_object_utils(virtual_sequence_five)

extern function new(string name="virtual_sequence_five");
extern task body();

endclass

	function virtual_sequence_five::new(string name="virtual_sequence_five");
		super.new(name);
	endfunction

	task virtual_sequence_five::body();
		super.body();
		in_4=increment_4::type_id::create("in_4");

		ir_data_4=Ir_data_4::type_id::create("ir_data_4");
		fork
			begin
				in_4.start(ahb_sqr);
						
			end	
			begin
				ir_data_4.start(apb_sqr);
			end
		join
	
	endtask

//**in_8

class virtual_sequence_six extends virtual_sequence;

`uvm_object_utils(virtual_sequence_six)

extern function new(string name="virtual_sequence_six");
extern task body();

endclass

	function virtual_sequence_six::new(string name="virtual_sequence_six");
		super.new(name);
	endfunction

	task virtual_sequence_six::body();
		super.body();
		in_8=increment_8::type_id::create("in_8");

		ir_data_8=Ir_data_8::type_id::create("ir_data_8");
		fork
			begin
				in_8.start(ahb_sqr);
						
			end	
			begin
				ir_data_8.start(apb_sqr);
			end
		join
	
	endtask

//**in_16

class virtual_sequence_seven extends virtual_sequence;

`uvm_object_utils(virtual_sequence_seven)

extern function new(string name="virtual_sequence_seven");
extern task body();

endclass

	function virtual_sequence_seven::new(string name="virtual_sequence_seven");
		super.new(name);
	endfunction

	task virtual_sequence_seven::body();
		super.body();
		in_16=increment_16::type_id::create("in_16");

		ir_data_16=Ir_data_16::type_id::create("ir_data_16");
		fork
			begin
				in_16.start(ahb_sqr);
						
			end	
			begin
				ir_data_16.start(apb_sqr);
			end
		join
	
	endtask
