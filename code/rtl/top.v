module rtl2_top (Hclk,
	   	Hresetn,
		Hwrite,
		Htrans,
		Hwdata,
		Hreadyin,
		Hreadyout,
		Haddr,
		Hrdata,
		Hresp,
		Hsize,
		Penable,
		Pwrite,
		Pwdata,
		Paddr,
		Pselx,
		Irdata);

input	Hclk,Hresetn,Hwrite;

input  [2:0]	Hsize;
input[1:0]	Htrans;

input[31:0]	Hwdata;

input		Hreadyin;

input[31:0]	Haddr;


input [31:0]  Irdata;

/////////      Output_declaration             //////////

output 	Penable,Pwrite;

output  [31:0]Pwdata;
output  [31:0]Paddr;

output 	Hreadyout;

output  [2:0] Pselx;

output  [31:0]	Hrdata;

output [1:0]	Hresp;

wire [2:0]temp;
wire [31:0]temp_addr0;
wire [31:0]temp_addr1;
wire [31:0]temp_addr2;
wire [31:0]temp_data0;
wire [31:0]temp_data1;
wire [31:0]temp_data2;

////////////////////////////////////////////////////////
/////////      AHB_SLAVE Initialization      ///////////
////////////////////////////////////////////////////////


ahb_slave AHB_SLAVE (	.Hclk(Hclk),
		 	.Hresetn(Hresetn),
			.Hwrite(Hwrite),
			.Htrans(Htrans),
			.Hwdata(Hwdata),
			.Hrdata(Hrdata),
			.Hreadyin(Hreadyin),
			.Hreadyout(Hreadyout),
			.Haddr(Haddr),
			.Hresp(Hresp),
			.temp_sel(temp),
			.valid(valid),
			.Hwritereg(Hwritereg),
			.Hwdata0(temp_data0),
			.Hwdata1(temp_data1),
			.Hwdata2(temp_data2),
			.Haddr0(temp_addr0),
			.Haddr1(temp_addr1),
			.Haddr2(temp_addr2),
			.Prdata(CONTROLLER.Prdata),
			.Preadyout(Preadyout));


apb_controller CONTROLLER(.Hclk(Hclk),
			  .Hwrite(Hwrite),
			  .Hresetn(Hresetn),
			  .temp_sel(temp),
			.valid(valid),
			.Hwritereg(Hwritereg),
			.Hwdata0(temp_data0),
			.Hwdata1(temp_data1),
			.Hwdata2(temp_data2),
			.Hsize(Hsize),
			.Haddr0(temp_addr0),
			.Haddr1(temp_addr1),
			.Haddr2(temp_addr2),
			.Preadyout(Preadyout),       //Apb controller output signal
			.Prdata(AHB_SLAVE.Prdata),          //Apb controller Output data
			.Penable(Penable),
			.Pwrite(Pwrite),
			.Pwdata(Pwdata),
			.Paddr(Paddr),
			.Pselx(Pselx),
			.Irdata(Irdata)          //Apb Interface Data
			);
endmodule
