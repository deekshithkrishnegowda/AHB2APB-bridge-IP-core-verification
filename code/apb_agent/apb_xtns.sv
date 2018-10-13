class apb_xtns extends uvm_sequence_item;

`uvm_object_utils(apb_xtns)
logic Hclk;
logic Hwrite,Hresetn;


logic [2:0] Hsize;
logic [1:0] Htrans;
logic [31:0] Hwdata;

logic Hreadyin;

logic [31:0] Haddr;


rand logic [31:0]  Irdata;


logic 	Penable;
 logic Pwrite;

logic  [31:0]Pwdata;
logic  [31:0]Paddr;

logic 	Hreadyout;

logic  [2:0] Pselx;

logic  [31:0]	Hrdata;

logic [1:0]	Hresp;

extern function void do_print (uvm_printer printer);

//constraint valid {Haddr inside {[32'h80000000:32'h8C000000]};}


endclass

 function void apb_xtns::do_print(uvm_printer printer);

		super.do_print(printer);
		printer.print_field("Paddr",this.Paddr,32,UVM_HEX);
		printer.print_field("Penable",this.Penable,1,UVM_DEC);
		//printer.print_field("Hreadyin",this.Hreadyin,1,UVM_DEC);
		printer.print_field("Pwrite",this.Pwrite,1,UVM_DEC);
		printer.print_field("Pwdata",this.Pwdata,32,UVM_HEX);
		printer.print_field("Pselx",this.Pselx,3,UVM_DEC);
		printer.print_field("Irdata",this.Irdata,32,UVM_HEX);
		


	endfunction

