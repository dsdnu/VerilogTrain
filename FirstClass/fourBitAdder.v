module fourBitAdder(
// Git changes
input [3:0] a,
input [3:0] b,
output [3:0] sum,
output carryOut
);

wire [2:0] carry;

//Instantiation --> Using one module with in another

adder A1(    //A1 is an instance of module adder
    .a(a[0]),
    .b(b[0]),
    .Cin(0),
    .Sum(sum[0]),
    .Cout(carry[0])
);

adder A2(    //A1 is an instance of module adder
    .a(a[1]),
    .b(b[1]),
    .Cin(carry[0]),
    .Sum(sum[1]),
    .Cout(carry[1])
);

adder A3(    //A1 is an instance of module adder
    .a(a[2]),
    .b(b[2]),
    .Cin(carry[1]),
    .Sum(sum[2]),
    .Cout(carry[2])
);

adder A4(    //A1 is an instance of module adder
    .a(a[3]),
    .b(b[3]),
    .Cin(carry[2]),
    .Sum(sum[3]),
    .Cout(carryOut)
);

endmodule