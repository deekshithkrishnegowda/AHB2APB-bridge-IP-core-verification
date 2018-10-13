class apb_monitor extends uvm_monitor;

`uvm_component_utils(apb_monitor)

virtual bridge_if.APB_MON_MP vif;

apb_config apb_cfg;
apb_xtns xtns;
uvm_analysis_port #(apb_xtns) apb;


extern function new(string name="apb_monitor",uvm_component parent);
extern function void build_phase (uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task run_phase (uvm_phase phase);
extern task collect_data(apb_xtns xtns);
endclass



//**************************functions***********************************


function apb_monitor::new(string name="apb_monitor",uvm_component parent);
	super.new(name,parent);
endfunction

function void apb_monitor::build_phase(uvm_phase phase);
	
	super.build_phase(phase);
	
	if(!uvm_config_db #(apb_config)::get(this,"","apb_config",apb_cfg))
		`uvm_fatal("apb_monitor","cannot get apb_config")
	apb=new("apb",this);
endfunction

function void apb_monitor::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	vif=apb_cfg.vif;
endfunction

/*task apb_monitor :: collect_data(apb_xtns xtns);
@(vif.apb_mon_cb);

	xtns.Pwrite=vif.apb_mon_cb.Pwrite;
	if(xtns.Pwrite)
	begin
	xtns.Penable=vif.apb_mon_cb.Penable;
	wait(xtns.Penable)
	xtns.Pwdata=vif.apb_mon_cb.Pwdata;
	xtns.Paddr=vif.apb_mon_cb.Paddr;
	xtns.Pselx=vif.apb_mon_cb.Pselx;
	end
		else
		begin
	xtns.Penable=vif.apb_mon_cb.Penable;
	wait(xtns.Penable)
	xtns.Irdata=vif.apb_mon_cb.Irdata;
	xtns.Paddr=vif.apb_mon_cb.Paddr;
	xtns.Pselx=vif.apb_mon_cb.Pselx;
	xtns.Hrdata=vif.apb_mon_cb.Hrdata;
	end


	//	$display("***********************THIS IS APB_MONITOR************************");
		xtns.print();
	endtask*/
	
task apb_monitor :: collect_data(apb_xtns xtns);

//	xtns.Pwrite=vif.apb_mon_cb.Pwrite;
//	fork
	//	begin
		wait(vif.apb_mon_cb.Penable)
			if(vif.apb_mon_cb.Pwrite)
			begin
				xtns.Penable=vif.apb_mon_cb.Penable;
				xtns.Pwdata=vif.apb_mon_cb.Pwdata;
				xtns.Paddr=vif.apb_mon_cb.Paddr;
				xtns.Pselx=vif.apb_mon_cb.Pselx;
			end
		
		//	xtns.Penable=vif.apb_mon_cb.Penable;
		
		else//wait((vif.apb_mon_cb.Penable)&&(!vif.apb_mon_cb.Pwrite))
			begin
				xtns.Irdata=vif.apb_mon_cb.Irdata;
				xtns.Paddr=vif.apb_mon_cb.Paddr;
				xtns.Pselx=vif.apb_mon_cb.Pselx;
				xtns.Hrdata=vif.apb_mon_cb.Hrdata;
		end
	
	//join_any

	//	$display("***********************THIS IS APB_MONITOR************************");
	//	xtns.print();
@(vif.apb_mon_cb);

	endtask

task apb_monitor::run_phase(uvm_phase phase);
	xtns=apb_xtns::type_id::create("xtns");
	forever
		begin
   		     
		//	$display("*****************collect data phase of apb monitor*********************************");
			collect_data(xtns);
		//	$display("********************writing into apb fifo*************************");
			apb.write(xtns);
		//	$display("*********************writing done apbfifo**************************");
   		end
	endtask
	

	
