interface bridge_if (input bit clock);

logic	Hclk,Hresetn,Hwrite;

logic  [2:0]	Hsize;
logic [1:0]	Htrans;

logic [31:0]	Hwdata;

logic		Hreadyin;

logic [31:0]	Haddr;
logic [2:0] Hburst;

logic [31:0]  Irdata;

/////////      Output_declaration             //////////

logic 	Penable,Pwrite;

logic  [31:0]Pwdata;
logic  [31:0]Paddr;

logic 	Hreadyout;

logic  [2:0] Pselx;

logic  [31:0]	Hrdata;

logic [1:0]	Hresp;






clocking ahb_drv_cb @(posedge clock);
default input #1 output #1;
output Hwdata;
output Haddr;
output Hwrite;
output Hresetn;
output Hreadyin;
input  Hreadyout;
output Hsize;
output Htrans;
output Hburst;



endclocking

clocking ahb_mon_cb @(posedge clock);
default input #1 output #1;
input Hwdata;
input Haddr;
input Hwrite;
input Hresetn;
input Hreadyin;
input  Hreadyout;
input Hsize;
input Htrans;
input Hburst;


endclocking

clocking apb_drv_cb @(posedge clock);
default input #1 output #1;
output Irdata;
input Pwrite;
input Penable;


endclocking

clocking apb_mon_cb @(posedge clock);
default input #1 output #1;
input Irdata;
input Pwrite;
input Penable;
input Pwdata;
input Paddr;
input Pselx;
input Hrdata;

endclocking

modport AHB_DRV_MP(clocking ahb_drv_cb);
modport AHB_MON_MP(clocking ahb_mon_cb);
modport APB_DRV_MP(clocking apb_drv_cb);
modport APB_MON_MP(clocking apb_mon_cb);

endinterface
 
