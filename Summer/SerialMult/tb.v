`timescale 1ns/1ps

`define period 5
`define Width 4

module tb();

reg clk;
reg rst;
reg load;
reg [`Width-1:0] loadValue;
reg shift;
reg shiftIn;
wire [`Width-1:0] shiftRegOut;

initial
begin
    clk = 0;
end

always
    #`period clk = ~clk;


initial
begin
     rst <= 1;	
     load <= 0;
     shiftIn <= 1;
     loadValue <= 0;
     shift <= 0;
     #20;
     @(posedge clk);
     rst <= 0;
     @(posedge clk);
     @(posedge clk);



     repeat(10)
     begin
        @(posedge clk);
        load <= 1;
        loadValue <= $urandom()%16;
     	@(posedge clk);
     	load <= 0;
     	@(posedge clk);
     	@(posedge clk);
     	@(posedge clk);
     	shift <= 1;
     	@(posedge clk);
    	 shift <= 0;
     	@(posedge clk);
     	if(shiftRegOut == {shiftIn,loadValue[3:1]})
		$display($time,,"Simulation passed...\n");
     	else
		$display($time,,"Simulation failed...Expected value %b and received value %b",{shiftIn,loadValue[3:1]},shiftRegOut);
     end
     $stop;
end


//instantiation

shift4Reg #(.Width(4))sr(
 .clock(clk),
 .reset(rst),
 .load(load), //if high, load loadValue to register. if low dont load
 .loadValue(loadValue),
 .shift(shift), //If high shift right by one bit. else don't shift
 .shiftReg(shiftRegOut),
 .shiftIn(shiftIn)
);



endmodule
