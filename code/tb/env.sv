class env extends uvm_env;

`uvm_component_utils(env)

ahb_agent ahb_agt;
apb_agent apb_agt;

env_config e_cfg;
virtual_sequencer v_sqr;
scoreboard sb;
extern function new(string name="env",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function  void connect_phase(uvm_phase phase);

endclass

function env::new(string name="env",uvm_component parent);
	super.new(name,parent);
endfunction

function void env::build_phase(uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db #(env_config)::get(this,"","env_config",e_cfg))
		`uvm_fatal("env","cannot get env_config")
	if(e_cfg.has_ahb_agent)
		begin
		ahb_agt=ahb_agent::type_id::create("ahb_agt",this);
		uvm_config_db #(ahb_config)::set(this,"ahb_agt*","ahb_config",e_cfg.ahb_cfg);
		end
	if(e_cfg.has_apb_agent)
		begin
		apb_agt=apb_agent::type_id::create("apb_agt",this);
		uvm_config_db #(apb_config)::set(this,"apb_agt*","apb_config",e_cfg.apb_cfg);
		end
	v_sqr=virtual_sequencer::type_id::create("v_sqr",this);
	sb=scoreboard::type_id::create("sb",this);
endfunction

function void env::connect_phase(uvm_phase phase);
v_sqr.ahb_sqr=ahb_agt.ahb_seqr;
v_sqr.apb_sqr=apb_agt.apb_seqr;
ahb_agt.ahb_mon.ahb.connect(sb.ahb_fifo.analysis_export);
apb_agt.apb_mon.apb.connect(sb.apb_fifo.analysis_export);

endfunction



