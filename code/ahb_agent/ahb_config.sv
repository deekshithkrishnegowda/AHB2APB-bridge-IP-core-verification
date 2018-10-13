class ahb_config extends uvm_object ;

`uvm_object_utils(ahb_config)
virtual bridge_if vif;

extern function new (string name="ahb_config");

uvm_active_passive_enum is_active =UVM_ACTIVE;

endclass


	function ahb_config::new(string name="ahb_config");
		super.new(name);
	endfunction
