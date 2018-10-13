class ahb_driver extends uvm_driver #(ahb_xtns);

`uvm_component_utils(ahb_driver)

virtual bridge_if.AHB_DRV_MP vif;

ahb_config ahb_cfg;
ahb_xtns xtns;

extern function new(string name="ahb_driver",uvm_component parent);
extern function void build_phase (uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task drive_to_DUT(ahb_xtns xtns);
endclass



//**************************functions***********************************


function ahb_driver::new(string name="ahb_driver",uvm_component parent);
	super.new(name,parent);
endfunction

function void ahb_driver::build_phase(uvm_phase phase);
	
	super.build_phase(phase);
	
	if(!uvm_config_db #(ahb_config)::get(this,"","ahb_config",ahb_cfg))
		`uvm_fatal("ahb_driver","cannot get ahb_config")
endfunction

function void ahb_driver::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	vif=ahb_cfg.vif;
endfunction

task ahb_driver::drive_to_DUT(ahb_xtns xtns);

	wait(vif.ahb_drv_cb.Hreadyout)
		vif.ahb_drv_cb.Hwrite<=xtns.Hwrite;
		vif.ahb_drv_cb.Htrans<=xtns.Htrans;
		vif.ahb_drv_cb.Hsize<=xtns.Hsize;
		vif.ahb_drv_cb.Haddr<=xtns.Haddr;
		vif.ahb_drv_cb.Hreadyin<=xtns.Hreadyin;
		vif.ahb_drv_cb.Hburst<=xtns.Hburst;
		
	@(vif.ahb_drv_cb);

	wait(vif.ahb_drv_cb.Hreadyout)
		vif.ahb_drv_cb.Hwdata<=xtns.Hwdata;

//	@(vif.ahb_drv_cb);


endtask

task ahb_driver::run_phase(uvm_phase phase);
		@(vif.ahb_drv_cb);
			vif.ahb_drv_cb.Hresetn<=1'b0;                   //testing reset
		@(vif.ahb_drv_cb);
			vif.ahb_drv_cb.Hresetn<=1'b1;
	
forever 
	begin
			
		seq_item_port.get_next_item(req);	    	
		drive_to_DUT(req);
   	//	req.print();	
		seq_item_port.item_done();

	end
	
endtask

