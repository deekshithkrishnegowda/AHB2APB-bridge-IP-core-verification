module top;
    import bridge_test_pkg::*;
	import uvm_pkg::*;

	bit clock;  
	always 
	#10 clock=!clock;     







	 bridge_if in_ahb(clock);
	 bridge_if in_apb(clock);

   rtl2_top DUT(.Hclk(clock),.Hresetn(in_ahb.Hresetn),.Hwrite(in_ahb.Hwrite),.Hsize(in_ahb.Hsize),.Htrans(in_ahb.Htrans),.Hwdata(in_ahb.Hwdata),.Hreadyin(in_ahb.Hreadyin),.Haddr(in_ahb.Haddr),.Penable(in_apb.Penable),.Pwrite(in_apb.Pwrite),.Pwdata(in_apb.Pwdata),.Paddr(in_apb.Paddr),.Hreadyout(in_ahb.Hreadyout),.Pselx(in_apb.Pselx),.Hrdata(in_apb.Hrdata),.Hresp(in_ahb.Hresp),.Irdata(in_apb.Irdata));
       	initial 
	begin
  
 	uvm_config_db #(virtual bridge_if)::set(null,"*","vif_ahb",in_ahb); //ahb_agent 
	uvm_config_db #(virtual bridge_if)::set(null,"*","vif_apb",in_apb); //apb_agent 

 	run_test();
     	end
 

   
endmodule


  

