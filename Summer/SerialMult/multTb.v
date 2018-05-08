`timescale 1ns/1ps

`define period 5
`define Width 4

module multTb();

reg clk;
reg rst;
reg En;
reg [3:0] multiplicant;
reg [3:0] multiplier;
reg [7:0] myproduct;
wire [7:0] product;
wire done;

initial
begin
    clk = 0;
end

always
    #`period clk = ~clk;


initial
begin
     repeat(50)
     begin
        rst <= 1;
        En <= 0;
        multiplicant = $urandom()%16;
     	multiplier = $urandom()%16;
        myproduct = multiplicant*multiplier;
     	#100;
     	rst <= 0;
     	#100;
     	@(posedge clk);
     	En <= 1;
     	@(posedge clk);
     	En <= 0;
     	wait(done);
     	if(product == multiplicant*multiplier)
        	$display("Simulation passed Multiplicant: %d, Multiplier: %d,Expected value %d and received value %d",multiplicant,multiplier,myproduct,product);
     	else
        	 $display($time,,,"Simulation failed. Multiplicant: %d, Multiplier: %d,Expected value %d and received value %d",multiplicant,multiplier,myproduct,product);
      end
     $stop;
end


//instantiation
serialMultiplier sm(
.clk(clk),
.reset(rst),
.Enable(En), //if Enable is high, start multiplication operands are in multiplicant and multiplier
.multiplicant(multiplicant),
.multiplier(multiplier),
.product(product),
.done(done) //If done is high, mutiplication is finished. Result in is product
);



endmodule

