`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/15/2018 05:17:00 PM
// Design Name: 
// Module Name: perceptron
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
`define threshold 100

module perceptron #(parameter Width = 8,numInput=3)(
input    clk,
input   [numInput-1:0] in,
output  reg         out,
input   [Width*numInput-1:0]  wg
);

reg [Width+1:0] result=0;
integer i;

reg [31:0] mem [99:0];
reg founddata;
reg [7:0] i;
//assign result = $signed(in1*wg1 + in2*wg2 + in3*wg3);

always @(*)
begin
    for(i=0;i<numInput;i=i+1)
        result = $signed(result) +  $signed(in[i]*wg[i*Width+:Width]);
end
 
always @(posedge clk)
begin
    if($signed(result) > `threshold)
        out <= 1;
    else
        out <= 0;
end


endmodule
