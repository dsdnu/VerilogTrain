module top(
    input [3:0] input1,
    input [3:0] input2,
    output [7:0] bcdOutput
    );

wire [7:0] fbaToBCD;
wire [3:0] sum;
wire carry;

assign fbaToBCD =  {3'h0,carry,sum};   
    
fourBitAdder fbA(
    .a(input1),
    .b(input2),
    .sum(sum),
    .carryOut(carry)
);    

binaryToBCD bTB(
    .inBinary(fbaToBCD),
    .outBCD(bcdOutput)
);
    
endmodule
