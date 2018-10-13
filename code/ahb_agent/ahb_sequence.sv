class base_sequence_ahb extends uvm_sequence #(ahb_xtns);

`uvm_object_utils(base_sequence_ahb)

extern function new(string name="base_sequence_ahb");

endclass

	function base_sequence_ahb ::new(string name="base_sequence_ahb");
		super.new(name);
	endfunction






class simple_write extends base_sequence_ahb;

`uvm_object_utils(simple_write)

extern function new(string name="simple_write");
extern task body();

endclass

	function simple_write::new(string name="simple_write");
		super.new(name);
	endfunction

	task simple_write::body();
	begin
		req=ahb_xtns::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {Hwrite==1;Htrans==2'b10;Hsize==3'b010;Hreadyin==1;Hburst==3'd0;})
		$display("******************this is AHB_WRITE_SEQUENCE**********************");
		req.print;
		finish_item(req);

		req=ahb_xtns::type_id::create("req");
		start_item(req);
		assert(req.randomize()with {Hwrite==1;Htrans==2'b00;Hsize==3'b010;Hreadyin==1;Hburst==3'd0;})
		$display("******************this is AHB_WRITE_SEQUENCE**********************");
		req.print;
		finish_item(req);
		
	end
	endtask



//**************************************WRAP 4********************************************
class wrap_4 extends base_sequence_ahb;

`uvm_object_utils(wrap_4)

extern function new(string name="wrap_4");
extern task body();

endclass

	function wrap_4::new(string name="wrap_4");
		super.new(name);
	endfunction

	task wrap_4::body();
	bit [32:0] ha;
	bit [2:0] hs;
	bit  hw;
	begin
		req=ahb_xtns::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {Htrans==2'b10;Hreadyin==1;Hburst==3'd2;})
		ha=req.Haddr;
		hw=req.Hwrite;
		hs=req.Hsize;
		finish_item(req);
	
	repeat(3)
		begin
		if(hs==0) ha={ha[31:2],ha[1:0]+1'b1};
		else if(hs==1) ha={ha[31:3],ha[2:1]+1'b1,ha[0]};
		else if(hs==2) ha={ha[31:4],ha[3:2]+1'b1,ha[1:0]};
	
		
		start_item(req);
		assert(req.randomize()with {Hwrite==hw;Htrans==2'b11;Hsize==hs;Haddr==ha;Hreadyin==1;Hburst==3'd2;})
		//$display("******************this is AHB_WRITE_SEQUENCE**********************");
		//req.print;
		finish_item(req);
		end
		
		start_item(req);
		assert(req.randomize() with {Hwrite==hw;Htrans==2'b00;Hsize==hs;Hreadyin==1;Hburst==3'd2;})
		finish_item(req);

		
		
	end
	endtask
//*******************************************************WRAP 8*************************************************************


class wrap_8 extends base_sequence_ahb;

`uvm_object_utils(wrap_8)

extern function new(string name="wrap_8");
extern task body();

endclass

	function wrap_8::new(string name="wrap_8");
		super.new(name);
	endfunction

	task wrap_8::body();
	bit [32:0] ha;
	bit [2:0] hs;
	bit  hw;
	begin
		req=ahb_xtns::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {Htrans==2'b10;Hsize==3'b001;Hreadyin==1;Hburst==3'b100;})
		ha=req.Haddr;
		hw=req.Hwrite;
		hs=req.Hsize;
		finish_item(req);
	
	repeat(7)
		begin
		if(hs==0) ha={ha[31:3],ha[2:0]+1'b1};
		else if(hs==1) ha={ha[31:4],ha[3:1]+1'b1,ha[0]};
		else if(hs==2) ha={ha[31:5],ha[4:2]+1'b1,ha[1:0]};
	
		
		start_item(req);
		assert(req.randomize()with {Hwrite==hw;Htrans==2'b11;Hsize==hs;Haddr==ha;Hreadyin==1;Hburst==3'b100;})
		finish_item(req);
		end
		
		start_item(req);
		assert(req.randomize() with {Hwrite==hw;Htrans==2'b00;Hsize==hs;Hreadyin==1;Hburst==3'b100;})
		finish_item(req);

		
		
	end
	endtask
//*******************************************************WRAP 16*************************************************************


class wrap_16 extends base_sequence_ahb;

`uvm_object_utils(wrap_16)

extern function new(string name="wrap_16");
extern task body();

endclass

	function wrap_16::new(string name="wrap_16");
		super.new(name);
	endfunction

	task wrap_16::body();
	bit [32:0] ha;
	bit [2:0] hs;
	//int [1:0] ht;
	begin
		req=ahb_xtns::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {Hwrite==1;Htrans==2'b10;Hsize==3'b001;Hreadyin==1;Hburst==3'b110;})
		ha=req.Haddr;
		//ht=req.Htrans;
		hs=req.Hsize;
		finish_item(req);
	
	repeat(15)
		begin
		if(hs==0) ha={ha[31:4],ha[3:0]+1'b1};
		else if(hs==1) ha={ha[31:5],ha[4:1]+1'b1,ha[0]};
		else if(hs==2) ha={ha[31:6],ha[5:2]+1'b1,ha[1:0]};
	
		
		start_item(req);
		assert(req.randomize()with {Hwrite==1;Htrans==2'b11;Hsize==hs;Haddr==ha;Hreadyin==1;Hburst==3'b110;})
		finish_item(req);
		end
		
		start_item(req);
		assert(req.randomize() with {Hwrite==1;Htrans==2'b00;Hsize==hs;Hreadyin==1;Hburst==3'b110;})
		finish_item(req);

		
		
	end
	endtask
//*********************************************************increment 4**************************************************************


class increment_4 extends base_sequence_ahb;

`uvm_object_utils(increment_4)

extern function new(string name="increment_4");
extern task body();

endclass

	function increment_4::new(string name="increment_4");
		super.new(name);
	endfunction

	task increment_4::body();
	bit [32:0] ha;
	bit [2:0] hs;
	//int [1:0] ht;
	begin
		req=ahb_xtns::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {Hwrite==1;Htrans==2'b10;Hsize==3'b010;Hreadyin==1;Hburst==3'b011;})
		ha=req.Haddr;
		//ht=req.Htrans;
		hs=req.Hsize;
		finish_item(req);
	
	repeat(3)
		begin
		ha=ha+(2**hs);
		start_item(req);
		assert(req.randomize()with {Hwrite==1;Htrans==2'b11;Hsize==hs;Haddr==ha;Hreadyin==1;Hburst==3'b011;})
		finish_item(req);
		end
		
		start_item(req);
		assert(req.randomize() with {Hwrite==1;Htrans==2'b00;Hsize==hs;Hreadyin==1;Hburst==3'b011;})
		finish_item(req);

		
		
	end
	endtask
//*********************************************************increment 8**************************************************************


class increment_8 extends base_sequence_ahb;

`uvm_object_utils(increment_8)

extern function new(string name="increment_8");
extern task body();

endclass

	function increment_8::new(string name="increment_8");
		super.new(name);
	endfunction

	task increment_8::body();
	bit [32:0] ha;
	bit [2:0] hs;
	//int [1:0] ht;
	begin
		req=ahb_xtns::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {Hwrite==1;Htrans==2'b10;Hsize==3'b000;Hreadyin==1;Hburst==3'b101;})
		ha=req.Haddr;
		//ht=req.Htrans;
		hs=req.Hsize;
		finish_item(req);
	
	repeat(7)
		begin
		ha=ha+(2**hs);
		start_item(req);
		assert(req.randomize()with {Hwrite==1;Htrans==2'b11;Hsize==hs;Haddr==ha;Hreadyin==1;Hburst==3'b101;})
		finish_item(req);
		end
		
		start_item(req);
		assert(req.randomize() with {Hwrite==1;Htrans==2'b00;Hsize==hs;Hreadyin==1;Hburst==3'b101;})
		finish_item(req);

		
		
	end
	endtask
//*********************************************************increment 16**************************************************************


class increment_16 extends base_sequence_ahb;

`uvm_object_utils(increment_16)

extern function new(string name="increment_16");
extern task body();

endclass

	function increment_16::new(string name="increment_16");
		super.new(name);
	endfunction

	task increment_16::body();
	bit [32:0] ha;
	bit [2:0] hs;
	//int [1:0] ht;
	begin
		req=ahb_xtns::type_id::create("req");
		start_item(req);
		assert(req.randomize() with {Hwrite==0;Htrans==2'b10;Hsize==3'b001;Hreadyin==1;Hburst==3'b111;})
		ha=req.Haddr;
		//ht=req.Htrans;
		hs=req.Hsize;
		finish_item(req);
	
	repeat(15)
		begin
		ha=ha+(2**hs);
		start_item(req);
		assert(req.randomize()with {Hwrite==0;Htrans==2'b11;Hsize==hs;Haddr==ha;Hreadyin==1;Hburst==3'b111;})
		finish_item(req);
		end
		
		start_item(req);
		assert(req.randomize() with {Hwrite==0;Htrans==2'b00;Hsize==hs;Hreadyin==1;Hburst==3'b111;})
		finish_item(req);

		
		
	end
	endtask

