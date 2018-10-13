module ahb_slave (	Hclk,
		 	Hresetn,
			Hwrite,
			Htrans,
			Hwdata,
			Hrdata,
			Hreadyin,
			Hreadyout,
			Haddr,
			Hresp,
			temp_sel,
			valid,
			Hwritereg,
			Hwdata0,
			Hwdata1,
			Hwdata2,
			Haddr0,
			Haddr1,
			Haddr2,
			Prdata,
			Preadyout);


/////////////////////////////////////////////////////////////////
///////////        Input_port Declaration             ///////////
/////////////////////////////////////////////////////////////////

input 	Hclk,Hresetn,Hwrite,Hreadyin,Preadyout;
input [1:0]Htrans;
	
input [31:0]Hwdata;

input [31:0]Haddr;

input [31:0]Prdata;

///////////////////////////////////////////////////////////////
//////////       Output_port_declaration             //////////
///////////////////////////////////////////////////////////////

output reg [2:0]temp_sel;

output reg 	valid,Hwritereg,Hreadyout;

output reg [31:0]Hwdata0;
output reg [31:0]Hwdata1;
output reg [31:0]Hwdata2;

output reg [31:0]Haddr0;
output reg [31:0]Haddr1;
output reg [31:0]Haddr2;
 
output reg [31:0]Hrdata;

output reg [1:0] Hresp;


///////////////////////////////////////////////////////////////
////////////          RTL_CODE                     ////////////
///////////////////////////////////////////////////////////////


//WRITE SIGNAL
always @(posedge Hclk)
begin
	if(!Hresetn)
		begin
			Hwritereg=1'b0;
		end
	else 
		begin
			Hwritereg=Hwrite;
		end
end

//decoder Pipeline Concept 

always @(*)
begin
	if(!Hresetn)
		begin
			temp_sel=3'b000;
				
		end
	else
		if(Haddr>=32'h8000_0000 && Haddr<=32'h8400_0000)
			begin
				temp_sel=3'b001;
			end
		else if(Haddr >= 32'h8400_0000  && Haddr<= 32'h8800_0000)
			begin
				temp_sel=3'b010;
			end
		else if(Haddr >=32'h8800_0000  && Haddr<= 32'h8C00_0000)
			begin
				temp_sel=3'b100;
			end
		
end	

	
//Received Data
always @(*)
begin
	if(!Hresetn)
		begin
			Hrdata=0;
		end
	else
		begin
			Hrdata=Prdata;
		end
end


always @(*)
begin
	if(!Hresetn)
		begin
			valid=1'b0;
		end
		else if((Haddr>=32'h8000_0000 && Haddr<=32'h8c00_0000 && Hresetn==1) && (Htrans==2'b10 || Htrans==2'b11))
			 	begin
					valid=1'b1;
				end
		else
		begin
			valid=1'b0;	
		end
end

always @(*)
begin
	if(!Hresetn)
		begin
			Hresp=2'b00;
		end
	else	
		begin
			Hresp=2'b01;
		end
end

//Receiving Data ready signal 
always @(*)
begin
	if(!Hresetn)
		begin
			Hreadyout=1'b0;
		end
	else
		begin	
			Hreadyout=Preadyout;
		end
end

//Address signal 
always@(posedge Hclk or negedge Hresetn)
begin
	if(!Hresetn)
		begin
			Haddr0<=0;
			Haddr1<=0;
			Haddr2<=0;
		end
	else
		begin
			Haddr0<=Haddr;
			Haddr1<=Haddr0;
			Haddr2<=Haddr1;
		end
end

//Data pipelining
always @(posedge Hclk or negedge Hresetn)
begin
	if(!Hresetn)
		begin	
			Hwdata0<=0;
			Hwdata1<=0;
			Hwdata2<=0;
		end
	else
		begin
			Hwdata0<=Hwdata;
			Hwdata1<=Hwdata0;
			Hwdata2<=Hwdata1;					
		end
end

endmodule

