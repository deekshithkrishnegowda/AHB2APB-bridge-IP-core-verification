
module apb_controller(	Hclk,
			Hwrite,
			Hresetn,
			temp_sel,
			valid,
			Hwritereg,
			Hwdata0,
			Hwdata1,
			Hwdata2,
			Hsize,
			Haddr0,
			Haddr1,
			Haddr2,
			Preadyout,       //Apb controller output signal
			Prdata,          //Apb controller Output data
			Penable,
			Pwrite,
			Pwdata,
			Paddr,
			Pselx,
			Irdata          //Apb Interface Data
			);


input	Hclk,Hwrite,Hresetn,valid,Hwritereg;
input [2:0]temp_sel;
input [31:0]Hwdata0;
input [31:0]Hwdata1;
input [31:0]Hwdata2;

input [31:0]Haddr0;
input [31:0]Haddr1;
input [31:0]Haddr2;

input [31:0]Irdata;

input [2:0]Hsize;

output  reg [31:0]Prdata;

output reg Penable,Pwrite;

output reg [31:0]Pwdata;

output reg [31:0]Paddr;

output  reg [2:0]Pselx;

output reg Preadyout;

reg [31:0]j;
///////////     FSM_STATE_DECLARATION     ///////////

parameter ST_IDLE=8'b0000_0001;
parameter ST_WWAIT=8'b0000_0010;
parameter ST_WRITEP=8'b0000_0100;
parameter ST_WR_RD = 8'b0000_0101;
parameter ST_RD_RD = 8'b0000_0110;
parameter ST_WENABLEP=8'b0000_1000;
parameter ST_WRITE=8'b0001_0000;
parameter ST_WENABLE=8'b0010_0000;
parameter ST_READ=8'b0100_0000;
parameter ST_RENABLE=8'b1000_0000;

//**************    Size        **********//
parameter BYTE=3'b000;
parameter HALFWORD=3'b001;
parameter WORD=3'b010;

reg [7:0]state,next_state;

reg flag;

/////////        RTL_DESIGN           ////////////

always @(posedge Hclk)
begin
	if(!Hresetn)
		begin
			state<=ST_IDLE;
		end
	else
		begin
			state<=next_state;
		end
end


always@(*)
begin
	case(state)
		ST_IDLE:if(valid==0)
				begin
					next_state=ST_IDLE;
				end
			else if(valid==1 && Hwrite==1)
				begin
					next_state=ST_WWAIT;
				end 
			else if(valid==1 && Hwrite==0)
				begin
					next_state=ST_READ;
				end
		ST_WWAIT:if(valid==0)
				begin
					next_state=ST_WRITE;
				end
			 else if(valid==1)
				begin
					next_state=ST_WRITEP;
					flag = 1'b1;
				end
		ST_WRITE:if(valid==0)
				begin
					next_state=ST_WENABLE;
				end
			else if(valid==1)
				begin
					next_state=ST_WENABLEP;
				end	

		ST_WRITEP:if(Hwritereg)
						next_state=ST_WENABLEP;
					else
						next_state = ST_WR_RD;
		
		ST_WR_RD: next_state = ST_RD_RD;

		ST_RD_RD: next_state = ST_RENABLE;	

		ST_WENABLEP:begin
				flag = 1'b0;
				if(valid==0 && Hwritereg==1)
				begin
					next_state=ST_WRITE;
				end
			    else if(valid==1 && Hwritereg==1)
				begin
					next_state=ST_WRITEP;
				end
		            else if(Hwritereg==0)
				begin
					next_state=ST_READ;
				end
				end
		ST_WENABLE:if(valid==0)
				begin
					next_state=ST_IDLE;
				end
			   else if(valid==1 && Hwrite==1)
				begin
					next_state=ST_WWAIT;	
				end
			  else if(valid==1 && Hwrite==0)
				begin
					next_state=ST_READ;
				end
		
		ST_READ:next_state=ST_RENABLE;
		
		ST_RENABLE:if(valid==1 && Hwrite==0)
				begin
					next_state=ST_READ;
				end
			   else if(valid==1 && Hwrite==1)
				begin	
					next_state=ST_WWAIT;
				end
			   else if(valid==0)
				begin
					next_state=ST_IDLE;
				end
		endcase
end	


always@(*)
begin
	if(!Hresetn)
		begin
			Penable=1'b0;
			Pwrite=1'b0;
			Pwdata=32'b0;
			Paddr=32'b0;
			Pselx=3'b000;
	 		Preadyout=1'b0;
		end
	else
	begin	
	case(state)
	ST_IDLE:begin
			Paddr = Paddr;
			Pwdata = Pwdata;
			//Pwrite=Hwritereg;
			Penable=0;
			Pselx=0;
			Preadyout=1'b1;
		end
	ST_READ:begin
			Paddr=Haddr0;
			//Pwdata=Hwdata1;
			Pselx=temp_sel;
			//Prdata=Irdata;
			Pwrite=1'b0;
			Preadyout=1'b0;
			Penable=0;
		end

	ST_WRITE:begin
			
		 	Paddr=Haddr2;
			j=Hwdata0;
			lilend(j,Paddr);
		 	Pwrite=1'b1;
			Pselx=temp_sel;
			Preadyout=1'b1;
			Penable=0;
		 end

	ST_WRITEP:begin
			if(flag)
				begin
					Paddr=Haddr1;	
				end
			else 
				begin
					Paddr=Haddr2;		
				end
			
			j=Hwdata0;
			lilend(j,Paddr);
			Pwrite=1'b1;
		  	Pselx=temp_sel;
			Preadyout=1'b0;
			Penable=1'b0;
		  end
		  
	ST_WR_RD:	begin
					Penable=1'b1;
					Pwrite=1'b1;
					end
					
	ST_RD_RD:	begin
					Penable=1'b0;
					Pwrite=1'b0;
					Paddr=Haddr2;
					end
					
	ST_RENABLE,ST_WENABLE:	begin
					Penable=1'b1;
					Preadyout=1'b1;
					//Pselx=Pselx;
				/*	Paddr=Haddr1;
					Pwdata=Hwdata1;
					Pwrite=Hwrite;	*/
					end
	ST_WENABLEP: begin
			Penable=1'b1;
			Preadyout=1'b1;
			//Pselx=temp_sel;
		     end
	ST_WWAIT:begin
			//Pwrite = 1'b0;
			Preadyout=1'b1;
			Penable=0;
			Pselx = 'd0;
		 end
	endcase		
end
end

always@(*)
	begin
	case(Hsize)
		BYTE:	begin
					if(Paddr[1:0]==2'b00)
						Prdata=Irdata[7:0];
					else if(Paddr[1:0]==2'b01)
						Prdata=Irdata[15:8];
					else if(Paddr[1:0]==2'b10)
						Prdata=Irdata[23:16];
					else if(Paddr[1:0]==2'b11)
						Prdata=Irdata[31:24];
				end
		HALFWORD: begin
						if(Paddr[1:0]==2'b00)
							Prdata=Irdata[15:0];
							
						else if(Paddr[1:0]==2'b10)
							Prdata=Irdata[31:16];
							
					end
		WORD:	begin
				Prdata=Irdata;
				end
		endcase
	
	end
	
task lilend(input  reg [31:0]j,input reg [31:0]Paddr);
	begin
	//$display("%b",j);
	//$display("Hsize=%d, Paddr[1:0]=%b",Hsize,Paddr[1:0]);
	case(Hsize)
		BYTE:	begin
					if(Paddr[1:0]==2'b00)
						Pwdata = Hwdata0[7:0];
					else if(Paddr[1:0]==2'b01)
						Pwdata = Hwdata0[15:8];
					else if(Paddr[1:0]==2'b10)
						Pwdata = Hwdata0[23:16];
					else if(Paddr[1:0]==2'b11)
						Pwdata = Hwdata0[31:24];
				end
		HALFWORD: begin
						if(Paddr[1:0]==2'b00)
							Pwdata = Hwdata0[15:0];
							
						else if(Paddr[1:0]==2'b10)
							Pwdata = Hwdata0[31:16];	
					end
		WORD:	begin
				Pwdata = j[31:0];
				end
		endcase		
	end
endtask
	
endmodule
