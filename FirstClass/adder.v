`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Vipin K
// 
// Create Date: 02/19/2018 05:11:19 PM
// Design Name: 
// Module Name: adder
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

module adder(
    input a,
    input b,
    input Cin,
    output Sum,
    output Cout
    );
    assign {Cout,Sum} = a+b+Cin;
endmodule
