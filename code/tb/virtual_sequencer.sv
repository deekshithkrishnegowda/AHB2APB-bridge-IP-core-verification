class virtual_sequencer extends uvm_sequencer #(uvm_sequence_item);

`uvm_component_utils(virtual_sequencer)

ahb_sequencer ahb_sqr;
apb_sequencer apb_sqr;

extern function new(string name="virtual_sequencer",uvm_component parent); 
//extern function void build_phase(uvm_phase phase);

endclass

	function virtual_sequencer::new(string name="virtual_sequencer",uvm_component parent);
		super.new(name,parent);
	endfunction 

	/*function void virtual_sequencer::build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction*/	
