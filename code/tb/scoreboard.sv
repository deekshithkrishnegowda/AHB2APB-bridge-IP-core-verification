


class scoreboard extends uvm_scoreboard;

`uvm_component_utils(scoreboard)

uvm_tlm_analysis_fifo #(ahb_xtns) ahb_fifo;
uvm_tlm_analysis_fifo #(apb_xtns) apb_fifo;

ahb_xtns ahb_xtn;
apb_xtns apb_xtn;

ahb_xtns cov_data;

bit [31:0] ahb_addr[$];
bit [31:0] apb_addr[$];
bit [31:0] ahb_data[$];
bit [31:0] apb_data[$];

bit [31:0] ahb_addr_reg;
bit [31:0] apb_addr_reg;
bit [31:0] ahb_data_reg;
bit [31:0] apb_data_reg;



covergroup bridge_coverage;
option.per_instance=1;
HSIZE : coverpoint cov_data.Hsize { bins a[]={[0:2]};}
HBURST: coverpoint cov_data.Hburst {bins b[]={[0:7]};}
HWRITE: coverpoint cov_data.Hwrite {bins zero={0}; bins one={1};}

endgroup

extern function new(string name="scoreboard",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task check_data();
endclass

function scoreboard::new(string name,uvm_component parent);
super.new(name,parent);
bridge_coverage=new;

endfunction


function void scoreboard::build_phase(uvm_phase phase);
super.build_phase(phase);
ahb_fifo=new("ahb_fifo",this);
apb_fifo=new("apb_fifo",this);
endfunction

task scoreboard::run_phase(uvm_phase phase);
bit [31:0] ahb_addr_reg,ahb_data_reg;
begin
fork
	
	forever	
		begin
			ahb_fifo.get(ahb_xtn);
				if(ahb_xtn.Hwrite==1)
					begin
					ahb_data_reg=ahb_xtn.Hwdata;
					ahb_addr_reg=ahb_xtn.Haddr;
					ahb_addr.push_back(ahb_addr_reg);
					ahb_data.push_back(ahb_data_reg);
					end
				else
					begin
				//	ahb_data_reg=ahb_xtn.Hrdata;
					ahb_addr_reg=ahb_xtn.Haddr;
					ahb_addr.push_back(ahb_addr_reg);
				//	ahb_data.push_back(ahb_data_reg);
					end
			
		end

	forever
		begin
			apb_fifo.get(apb_xtn);
	
					if(ahb_xtn.Hwrite==1)
					begin
					
					apb_data_reg=apb_xtn.Pwdata;
					apb_addr_reg=apb_xtn.Paddr;
					ahb_addr_reg=ahb_addr.pop_front();
					ahb_data_reg=ahb_data.pop_front();
					cov_data=ahb_xtn;
					bridge_coverage.sample();
						if(ahb_xtn.Hsize==2)
						begin
							if(apb_addr_reg==ahb_addr_reg)
								begin
								$display("ADDRESS MATCH \t AHB_ADDR %h \t APB_ADDR %h",ahb_addr_reg,apb_addr_reg, $time);
								bridge_coverage.sample();
								end
							else
								
								$display("ADDRESS MISMATCH \t ahb_addr %h \t apb_addr %h",ahb_addr_reg,apb_addr_reg,$time);
								
							if(apb_data_reg==ahb_data_reg)
								
								$display("DATA MATCH \t \t \t AHB_DATA %h \t APB_DATA %h",ahb_data_reg,apb_data_reg, $time);
								
							else
								
								$display("DATA MISMATCH  \t \t \t ahb_data %h \t apb_data %h",ahb_data_reg,apb_data_reg,$time );
								
						end
						
	else if(ahb_xtn.Hsize==3'b001)
			begin		
						
		if(ahb_addr_reg[1:0]==2'b00)
				begin
				if(apb_addr_reg==ahb_addr_reg)
					begin
					$display("ADDRESS MATCH \t AHB_ADDR %h \t APB_ADDR %h",ahb_addr_reg,apb_addr_reg, $time);
					bridge_coverage.sample();
					
					end
					else
					$display("ADDRESS MISMATCH \t ahb_addr %h \t apb_addr %h",ahb_addr_reg,apb_addr_reg,$time);
					
							
				if(apb_data_reg[15:0]==ahb_data_reg[15:0])
					$display("DATA MATCH \t \t \t AHB_DATA %h \t APB_DATA %h",ahb_data_reg[15:0],apb_data_reg[15:0], $time);
				else
					
					$display("DATA MISMATCH  \t \t \t ahb_data %h \t apb_data %h",ahb_data_reg[15:0],apb_data_reg[15:0],$time );
				end
		else if(ahb_addr_reg[1:0]==2'b10)
				begin
				if(apb_addr_reg==ahb_addr_reg)
					begin
					$display("ADDRESS MATCH \t AHB_ADDR %h \t APB_ADDR %h",ahb_addr_reg,apb_addr_reg, $time);
					bridge_coverage.sample();
					
					end
					else
					$display("ADDRESS MISMATCH \t ahb_addr %h \t apb_addr %h",ahb_addr_reg,apb_addr_reg,$time);
								
				if(apb_data_reg[15:0]==ahb_data_reg[31:16])	
					$display("DATA MATCH \t \t \t AHB_DATA %h \t APB_DATA %h",ahb_data_reg[31:16],apb_data_reg[15:0], $time);
				else
								
					$display("DATA MISMATCH  \t \t \t ahb_data %h \t apb_data %h",ahb_data_reg[31:16],apb_data_reg[15:0],$time );
								

				end
			end
	
		else if(ahb_xtn.Hsize==3'b000)
			begin		
						
		if(ahb_addr_reg[1:0]==2'b00)
				begin
				if(apb_addr_reg==ahb_addr_reg)
					begin
					$display("ADDRESS MATCH \t AHB_ADDR %h \t APB_ADDR %h",ahb_addr_reg,apb_addr_reg, $time);
					bridge_coverage.sample();
					
					end
				else
					$display("ADDRESS MISMATCH \t ahb_addr %h \t apb_addr %h",ahb_addr_reg,apb_addr_reg,$time);
					
							
				if(apb_data_reg[7:0]==ahb_data_reg[7:0])
					$display("DATA MATCH \t \t \t AHB_DATA %h \t APB_DATA %h",ahb_data_reg[7:0],apb_data_reg[7:0], $time);
				else
					
					$display("DATA MISMATCH  \t \t \t ahb_data %h \t apb_data %h",ahb_data_reg[7:0],apb_data_reg[7:0],$time );
				end
		else if(ahb_addr_reg[1:0]==2'b01)
				begin
				if(apb_addr_reg==ahb_addr_reg) begin
					$display("ADDRESS MATCH \t AHB_ADDR %h \t APB_ADDR %h",ahb_addr_reg,apb_addr_reg, $time);
								bridge_coverage.sample();
								end				
					else
					$display("ADDRESS MISMATCH \t ahb_addr %h \t apb_addr %h",ahb_addr_reg,apb_addr_reg,$time);
								
				if(apb_data_reg[7:0]==ahb_data_reg[15:8])	
					$display("DATA MATCH \t \t \t AHB_DATA %h \t APB_DATA %h",ahb_data_reg[15:8],apb_data_reg[7:0], $time);
				else
								
					$display("DATA MISMATCH  \t \t \t ahb_data %h \t apb_data %h",ahb_data_reg[15:8],apb_data_reg[7:0],$time );
								

				end
		else if(ahb_addr_reg[1:0]==2'b10)
				begin
				if(apb_addr_reg==ahb_addr_reg) begin
					$display("ADDRESS MATCH \t AHB_ADDR %h \t APB_ADDR %h",ahb_addr_reg,apb_addr_reg, $time);
								bridge_coverage.sample();
								end				
				else
					$display("ADDRESS MISMATCH \t ahb_addr %h \t apb_addr %h",ahb_addr_reg,apb_addr_reg,$time);
					
							
				if(apb_data_reg[7:0]==ahb_data_reg[23:16])
					$display("DATA MATCH \t \t \t AHB_DATA %h \t APB_DATA %h",ahb_data_reg[23:16],apb_data_reg[7:0], $time);
				else
					
					$display("DATA MISMATCH  \t \t \t ahb_data %h \t apb_data %h",ahb_data_reg[23:16],apb_data_reg[7:0],$time );
				end
		else if(ahb_addr_reg[1:0]==2'b11)
				begin
				if(apb_addr_reg==ahb_addr_reg)
						begin
					$display("ADDRESS MATCH \t AHB_ADDR %h \t APB_ADDR %h",ahb_addr_reg,apb_addr_reg, $time);
								bridge_coverage.sample();
				
						end
					else
					$display("ADDRESS MISMATCH \t ahb_addr %h \t apb_addr %h",ahb_addr_reg,apb_addr_reg,$time);
					
							
				if(apb_data_reg[7:0]==ahb_data_reg[31:24])
					$display("DATA MATCH \t \t \t AHB_DATA %h \t APB_DATA %h",ahb_data_reg[31:24],apb_data_reg[7:0], $time);
				else
					
					$display("DATA MISMATCH  \t \t \t ahb_data %h \t apb_data %h",ahb_data_reg[31:24],apb_data_reg[7:0],$time );
				end

			end
									
					
		end
		else
			begin
					
					apb_data_reg=apb_xtn.Irdata;
					apb_addr_reg=apb_xtn.Paddr;
					ahb_data_reg=apb_xtn.Hrdata;
				//	ahb_addr_reg=ahb_xtn.Haddr;
				//	ahb_addr.push_back(ahb_addr_reg);
					ahb_data.push_back(ahb_data_reg);

					ahb_addr_reg=ahb_addr.pop_front();
					ahb_data_reg=ahb_data.pop_front();
					cov_data=ahb_xtn;
					bridge_coverage.sample();
						if(ahb_xtn.Hsize==2)
						begin
							if(apb_addr_reg==ahb_addr_reg)
								begin
								$display("ADDRESS MATCH \t AHB_ADDR %h \t APB_ADDR %h",ahb_addr_reg,apb_addr_reg, $time);
								bridge_coverage.sample();
								end								
							else
								
								$display("ADDRESS MISMATCH \t ahb_addr %h \t apb_addr %h",ahb_addr_reg,apb_addr_reg,$time);
								
							if(apb_data_reg==ahb_data_reg)
								
								$display("DATA MATCH \t \t \t AHB_DATA %h \t APB_DATA %h",ahb_data_reg,apb_data_reg, $time);
								
							else
								
								$display("DATA MISMATCH  \t \t \t ahb_data %h \t apb_data %h",ahb_data_reg,apb_data_reg,$time );
								
						end
						
	else if(ahb_xtn.Hsize==3'b001)
			begin		
						
		if(ahb_addr_reg[1:0]==2'b00)
				begin
				if(apb_addr_reg==ahb_addr_reg) begin
					$display("ADDRESS MATCH \t APB_ADDR %h \t AHB_ADDR %h",apb_addr_reg,ahb_addr_reg, $time);
								bridge_coverage.sample();
								
								end
				else
					$display("ADDRESS MISMATCH \t apb_addr %h \t ahb_addr %h",apb_addr_reg,ahb_addr_reg,$time);
					
							
				if(apb_data_reg[15:0]==ahb_data_reg[15:0])
					$display("DATA MATCH \t \t \t APB_DATA %h \t AHB_DATA %h",apb_data_reg[15:0],ahb_data_reg[15:0], $time);
				else
					
					$display("DATA MISMATCH  \t \t \t apb_data %h \t ahb_data %h",apb_data_reg[15:0],ahb_data_reg[15:0],$time );
				end
		else if(ahb_addr_reg[1:0]==2'b10)
				begin
				if(apb_addr_reg==ahb_addr_reg)
					begin
					$display("ADDRESS MATCH \t APB_ADDR %h \t AHB_ADDR %h",apb_addr_reg,ahb_addr_reg, $time);
								bridge_coverage.sample();
					
					end
					else
					$display("ADDRESS MISMATCH \t apb_addr %h \t ahb_addr %h",apb_addr_reg,ahb_addr_reg,$time);
								
				if(ahb_data_reg[15:0]==apb_data_reg[31:16])	
					$display("DATA MATCH \t \t \t APB_DATA %h \t AHB_DATA %h",apb_data_reg[31:16],ahb_data_reg[15:0], $time);
				else
								
					$display("DATA MISMATCH  \t \t \t apb_data %h \t ahb_data %h",apb_data_reg[31:16],ahb_data_reg[15:0],$time );
								

				end
			end
	
		else if(ahb_xtn.Hsize==3'b000)
			begin		
						
		if(ahb_addr_reg[1:0]==2'b00)
				begin
				if(apb_addr_reg==ahb_addr_reg) begin
					$display("ADDRESS MATCH \t APB_ADDR %h \t AHB_ADDR %h",apb_addr_reg,ahb_addr_reg, $time);
								bridge_coverage.sample();
								end				
					else
					$display("ADDRESS MISMATCH \t apb_addr %h \t ahb_addr %h",apb_addr_reg,ahb_addr_reg,$time);
					
							
				if(apb_data_reg[7:0]==ahb_data_reg[7:0])
					$display("DATA MATCH \t \t \t APB_DATA %h \t AHB_DATA %h",apb_data_reg[7:0],ahb_data_reg[7:0], $time);
				else
					
					$display("DATA MISMATCH  \t \t \t apb_data %h \t ahb_data %h",apb_data_reg[7:0],ahb_data_reg[7:0],$time );
				end
		else if(ahb_addr_reg[1:0]==2'b01)
				begin
				if(apb_addr_reg==ahb_addr_reg)begin
					$display("ADDRESS MATCH \t APB_ADDR %h \t AHB_ADDR %h",apb_addr_reg,ahb_addr_reg, $time);
								bridge_coverage.sample();
								end					
					else
					$display("ADDRESS MISMATCH \t apb_addr %h \t ahb_addr %h",apb_addr_reg,ahb_addr_reg,$time);
								
				if(ahb_data_reg[7:0]==apb_data_reg[15:8])	
					$display("DATA MATCH \t \t \t APB_DATA %h \t AHB_DATA %h",apb_data_reg[15:8],ahb_data_reg[7:0], $time);
				else
								
					$display("DATA MISMATCH  \t \t \t apb_data %h \t ahb_data %h",apb_data_reg[15:8],ahb_data_reg[7:0],$time );
								

				end
		else if(ahb_addr_reg[1:0]==2'b10)
				begin
				if(apb_addr_reg==ahb_addr_reg)
					begin
					$display("ADDRESS MATCH \t APB_ADDR %h \t AHB_ADDR %h",apb_addr_reg,ahb_addr_reg, $time);
								bridge_coverage.sample();
					end				
					else
					$display("ADDRESS MISMATCH \t apb_addr %h \t ahb_addr %h",apb_addr_reg,ahb_addr_reg,$time);
					
							
				if(ahb_data_reg[7:0]==apb_data_reg[23:16])
					$display("DATA MATCH \t \t \t APB_DATA %h \t AHB_DATA %h",apb_data_reg[23:16],ahb_data_reg[7:0], $time);
				else
					
					$display("DATA MISMATCH  \t \t \t apb_data %h \t ahb_data %h",apb_data_reg[23:16],ahb_data_reg[7:0],$time );
				end
		else if(ahb_addr_reg[1:0]==2'b11)
				begin
				if(apb_addr_reg==ahb_addr_reg)
					begin
					$display("ADDRESS MATCH \t APB_ADDR %h \t AHB_ADDR %h",apb_addr_reg,ahb_addr_reg, $time);
								bridge_coverage.sample();
					end
					else
					$display("ADDRESS MISMATCH \t apb_addr %h \t ahb_addr %h",apb_addr_reg,ahb_addr_reg,$time);
					
							
				if(ahb_data_reg[7:0]==apb_data_reg[31:24])
					$display("DATA MATCH \t \t \t APB_DATA %h \t AHB_DATA %h",apb_data_reg[31:24],ahb_data_reg[7:0], $time);
				else
					
					$display("DATA MISMATCH  \t \t \t apb_data %h \t ahb_data %h",apb_data_reg[31:24],ahb_data_reg[7:0],$time );
				end

			end
									
					
		end
	





end
join

end
endtask












