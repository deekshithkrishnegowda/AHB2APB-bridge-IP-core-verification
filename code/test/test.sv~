class test extends uvm_test;

`uvm_component_utils(test)

env env_handle;
env_config e_cfg;

ahb_config ahb_cfg;
apb_config apb_cfg;
//virtual_sequence_one test_one;


extern function new(string name="test",uvm_component parent);
extern  function void  build_phase(uvm_phase phase);
//extern task run_phase(uvm_phase phase);

endclass

function test::new(string name="test",uvm_component parent);
	super.new(name,parent);
endfunction

function void test::build_phase(uvm_phase phase);
	super.build_phase(phase);
	
	env_handle=env::type_id::create("env_handle",this);
	
	e_cfg=env_config::type_id::create("e_cfg");
	ahb_cfg=ahb_config::type_id::create("ahb_cfg");

	if(!uvm_config_db #(virtual bridge_if)::get(this,"","vif_ahb",ahb_cfg.vif))	
		`uvm_fatal("test","cannot get interface")
	e_cfg.ahb_cfg=ahb_cfg;
		

	apb_cfg=apb_config::type_id::create("apb_cfg");
	if(!uvm_config_db #(virtual bridge_if)::get(this,"","vif_apb",apb_cfg.vif))	
		`uvm_fatal("test","cannot get interface")
	e_cfg.apb_cfg=apb_cfg;

	uvm_config_db #(env_config)::set(this,"*","env_config",e_cfg);

endfunction
//*************************************************************************************************************

class test_1 extends test;

`uvm_component_utils(test_1)

virtual_sequence_one test_one;


extern function new(string name="test_1",uvm_component parent);
extern  function void  build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);

endclass

function test_1::new(string name="test_1",uvm_component parent);
	super.new(name,parent);
endfunction

function void test_1::build_phase(uvm_phase phase);
	super.build_phase(phase);
	
endfunction
	
	task test_1::run_phase(uvm_phase phase);
		test_one=virtual_sequence_one::type_id::create("test_one");
		phase.raise_objection(this);
		test_one.start(env_handle.v_sqr);
		#200; 
		phase.drop_objection(this);
	endtask	

//*************************************************************************************************************

class test_2 extends test;

`uvm_component_utils(test_2)
virtual_sequence_two test_two;


extern function new(string name="test_2",uvm_component parent);
extern  function void  build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);

endclass

function test_2::new(string name="test_2",uvm_component parent);
	super.new(name,parent);
endfunction

function void test_2::build_phase(uvm_phase phase);
	super.build_phase(phase);
	
endfunction
	
	task test_2::run_phase(uvm_phase phase);
		test_two=virtual_sequence_two::type_id::create("test_two");
		phase.raise_objection(this);
		test_two.start(env_handle.v_sqr);
		#200; 
		phase.drop_objection(this);
	endtask	

//**************************************************************************************************************

class test_3 extends test;

`uvm_component_utils(test_3)
virtual_sequence_three test_three;


extern function new(string name="test_3",uvm_component parent);
extern  function void  build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);

endclass

function test_3::new(string name="test_3",uvm_component parent);
	super.new(name,parent);
endfunction

function void test_3::build_phase(uvm_phase phase);
	super.build_phase(phase);
	
endfunction
	
	task test_3::run_phase(uvm_phase phase);
		test_three=virtual_sequence_three::type_id::create("test_three");
		phase.raise_objection(this);
		test_three.start(env_handle.v_sqr);
		#200; 
		phase.drop_objection(this);
	endtask	
//*******************************************************************************************************************
class test_4 extends test;

`uvm_component_utils(test_4)
virtual_sequence_four test_four;


extern function new(string name="test_4",uvm_component parent);
extern  function void  build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);

endclass

function test_4::new(string name="test_4",uvm_component parent);
	super.new(name,parent);
endfunction

function void test_4::build_phase(uvm_phase phase);
	super.build_phase(phase);
	
endfunction
	
	task test_4::run_phase(uvm_phase phase);
		test_four=virtual_sequence_four::type_id::create("test_four");
		phase.raise_objection(this);
		test_four.start(env_handle.v_sqr);
		#200; 
		phase.drop_objection(this);
	endtask	
//**************************************************increment_4********************************************************

class test_5 extends test;

`uvm_component_utils(test_5)
virtual_sequence_five test_five;


extern function new(string name="test_5",uvm_component parent);
extern  function void  build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);

endclass

function test_5::new(string name="test_5",uvm_component parent);
	super.new(name,parent);
endfunction

function void test_5::build_phase(uvm_phase phase);
	super.build_phase(phase);
	
endfunction
	
	task test_5::run_phase(uvm_phase phase);
		test_five=virtual_sequence_five::type_id::create("test_five");
		phase.raise_objection(this);
		test_five.start(env_handle.v_sqr);
		#200; 
		phase.drop_objection(this);
	endtask	

//**************************************************increment_8********************************************************

class test_6 extends test;

`uvm_component_utils(test_6)
virtual_sequence_six test_six;


extern function new(string name="test_6",uvm_component parent);
extern  function void  build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);

endclass

function test_6::new(string name="test_6",uvm_component parent);
	super.new(name,parent);
endfunction

function void test_6::build_phase(uvm_phase phase);
	super.build_phase(phase);
	
endfunction
	
	task test_6::run_phase(uvm_phase phase);
		test_six=virtual_sequence_six::type_id::create("test_six");
		phase.raise_objection(this);
		test_six.start(env_handle.v_sqr);
		#200; 
		phase.drop_objection(this);
	endtask	

//**************************************************increment_16********************************************************

class test_7 extends test;

`uvm_component_utils(test_7)
virtual_sequence_seven test_seven;


extern function new(string name="test_7",uvm_component parent);
extern  function void  build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);

endclass

function test_7::new(string name="test_7",uvm_component parent);
	super.new(name,parent);
endfunction

function void test_7::build_phase(uvm_phase phase);
	super.build_phase(phase);
	
endfunction
	
	task test_7::run_phase(uvm_phase phase);
		test_seven=virtual_sequence_seven::type_id::create("test_seven");
		phase.raise_objection(this);
		test_seven.start(env_handle.v_sqr);
		#200; 
		phase.drop_objection(this);
	endtask	



