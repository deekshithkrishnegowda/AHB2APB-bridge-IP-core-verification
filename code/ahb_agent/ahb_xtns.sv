class ahb_xtns extends uvm_sequence_item;

`uvm_object_utils(ahb_xtns)
logic Hclk;
rand logic Hwrite;
logic Hresetn;


randc logic [2:0] Hsize;
rand logic [1:0] Htrans;
rand logic [31:0] Hwdata;

rand logic Hreadyin;

rand logic [31:0] Haddr;
rand logic [2:0] Hburst;

logic [31:0]  Irdata;


logic 	Penable;
logic Pwrite;

logic  [31:0]Pwdata;
logic  [31:0]Paddr;

logic 	Hreadyout;

logic  [2:0] Pselx;

logic  [31:0]	Hrdata;

logic [1:0]	Hresp;

extern function void do_print (uvm_printer printer);

constraint valid {Haddr inside {[32'h80000000:32'h8C000000]};}
constraint valid1 {Hsize inside {[3'b000:3'b010]};}
constraint valid2 {(Hsize==1)-> (Haddr[0]==1'b0);
		   (Hsize==2)-> (Haddr[1:0]==2'b0);	}
endclass

 function void ahb_xtns::do_print(uvm_printer printer);

		super.do_print(printer);
		printer.print_field("Haddr",this.Haddr,32,UVM_HEX);
		printer.print_field("Hwdata",this.Hwdata,32,UVM_HEX);
		printer.print_field("Hreadyin",this.Hreadyin,1,UVM_DEC);
		printer.print_field("Hwrite",this.Hwrite,1,UVM_DEC);
		printer.print_field("Htrans",this.Htrans,2,UVM_DEC);
	//	printer.print_field("Pselx",this.Pselx,3,UVM_DEC);
	//	printer.print_field("Irdata",this.Irdata,32,UVM_DEC);
		


	endfunction

