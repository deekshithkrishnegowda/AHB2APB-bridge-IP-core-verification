class ahb_monitor extends uvm_monitor;

`uvm_component_utils(ahb_monitor)

virtual bridge_if.AHB_MON_MP vif;

ahb_config ahb_cfg;
ahb_xtns xtns,copy_xtns;
uvm_analysis_port #(ahb_xtns) ahb;


extern function new(string name="ahb_monitor",uvm_component parent);
extern function void build_phase (uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task run_phase (uvm_phase phase);
extern task collect_data(ahb_xtns xtns);
endclass



//**************************functions***********************************


function ahb_monitor::new(string name="ahb_monitor",uvm_component parent);
	super.new(name,parent);
endfunction

function void ahb_monitor::build_phase(uvm_phase phase);
	
	super.build_phase(phase);
	
	if(!uvm_config_db #(ahb_config)::get(this,"","ahb_config",ahb_cfg))
		`uvm_fatal("ahb_monitor","cannot get ahb_config")
	ahb=new("ahb",this);
endfunction

function void ahb_monitor::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	vif=ahb_cfg.vif;
endfunction

task ahb_monitor :: collect_data(ahb_xtns xtns);
	
//	wait(vif.ahb_mon_cb.Hresetn)
	
		//	@(vif.ahb_mon_cb);

	
//	wait(vif.ahb_mon_cb.Hreadyout)
		wait((vif.ahb_mon_cb.Htrans==2'd2)||(vif.ahb_mon_cb.Htrans==2'd3))
			begin
		xtns.Htrans=vif.ahb_mon_cb.Htrans;
		xtns.Hwrite=vif.ahb_mon_cb.Hwrite;
		xtns.Hsize=vif.ahb_mon_cb.Hsize;
		xtns.Haddr=vif.ahb_mon_cb.Haddr;
		xtns.Hburst=vif.ahb_mon_cb.Hburst;

	@(vif.ahb_mon_cb);

	wait(vif.ahb_mon_cb.Hreadyout)
		xtns.Hwdata=vif.ahb_mon_cb.Hwdata;
	end
	
	//@(vif.ahb_mon_cb);
	endtask

task ahb_monitor::run_phase(uvm_phase phase);
	copy_xtns=ahb_xtns::type_id::create("copy_xtns");
	//	@(vif.ahb_mon_cb);
	//	@(vif.ahb_mon_cb);
xtns=ahb_xtns::type_id::create("xtns");

	forever
		begin
   		     	
			collect_data(xtns);
			copy_xtns=new xtns;
			ahb.write(copy_xtns);
		//	$display("this is ahbmonitor");
		//	$display("%m ",$time);
		//	xtns.print();
	   		end
	endtask
	

	

