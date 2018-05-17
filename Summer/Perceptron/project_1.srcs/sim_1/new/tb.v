`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/15/2018 06:04:32 PM
// Design Name: 
// Module Name: tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb(

    );

reg clk;
reg in1;
reg in2;
reg in3;
reg [7:0] wg1;
reg [7:0] wg2;
reg [7:0] wg3;
wire outperp;

initial
begin
   clk = 0;
end

always
begin
    clk = ~clk;
    #5;
end    


initial
begin
   in1 = 0;
   in2 = 0;
   in3 = 0;
   wg1 = 0;
   wg2 = 0;
   wg3 = 0;
   #20;
   @(posedge clk);
   in1 = 1;
   wg1 = 51;
   @(posedge clk);
   @(posedge clk);
   @(posedge clk);
   @(posedge clk);
   in2 = 1;
   wg2 = 60;
   @(posedge clk);
   @(posedge clk);
   @(posedge clk);
   @(posedge clk);
   in3 = 1;
   wg3 = 0;
   @(posedge clk);
   @(posedge clk);
   @(posedge clk);
   @(posedge clk);
   in1 = 0;
   in2 = 0;
   in3 = 0;
end

initial
begin
    $monitor($time,,,,,"Output value is %d.......",outperp);
end

perceptron #(.Width(8),.numInput(3))p1(
.clk(clk),
.in({in3,in2,in1}),
.out(outperp),
.wg({wg3,wg2,wg1})
);


endmodule
