`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/16/2018 11:23:56 AM
// Design Name: 
// Module Name: dff
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


module dff(
input wire clock,
input wire reset,
input wire a,
input wire b,
output reg sum,
output reg carry
);

//positive edge-triggered D flip flop
//sequential circuit --> it has memory
//synchronous circuit --> it has clock
//Verilog for designing sequential we use "always" block

always @(posedge clock or posedge reset)//sensitivity list
begin
    if(reset)
    begin
        sum <= 0;
        carry <= 0;
    end
    else
    begin
        {carry,sum}  <= a+b; 
    end
end

//All left hand operands should be of reg type
//Two types - 1. wire 2. reg
//All left hand operands of assign statement should be wire type
//Input and inout ports can be only wire type
//Output ports can be wire or reg type
endmodule
