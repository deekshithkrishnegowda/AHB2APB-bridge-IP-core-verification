class apb_driver extends uvm_driver #(apb_xtns);

`uvm_component_utils(apb_driver)

virtual bridge_if.APB_DRV_MP vif;

apb_config apb_cfg;
apb_xtns xtns;

extern function new(string name="apb_driver",uvm_component parent);
extern function void build_phase (uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task drive_to_DUT(apb_xtns xtns);
endclass



//**************************functions***********************************


function apb_driver::new(string name="apb_driver",uvm_component parent);
	super.new(name,parent);
endfunction

function void apb_driver::build_phase(uvm_phase phase);
	
	super.build_phase(phase);
	
	if(!uvm_config_db #(apb_config)::get(this,"","apb_config",apb_cfg))
		`uvm_fatal("apb_driver","cannot get apb_config")
endfunction

function void apb_driver::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	vif=apb_cfg.vif;
endfunction

task apb_driver::drive_to_DUT(apb_xtns xtns);
	
	wait(vif.apb_drv_cb.Penable)

	if(!vif.apb_drv_cb.Pwrite)
	vif.apb_drv_cb.Irdata<=xtns.Irdata;
	
	@(vif.apb_drv_cb);
endtask

task apb_driver::run_phase(uvm_phase phase);
forever 
	begin
		seq_item_port.get_next_item(req);
   		    	
		drive_to_DUT(req);
   		//req.print();	
		seq_item_port.item_done();

	end
	
endtask

