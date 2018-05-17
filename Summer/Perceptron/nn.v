module neuralNetowrk #(parameter numInput=5,Width=8)(
input   clk,
input  [numInput-1:0] in,
input   [Width*numInput*3-1:0]  wg1,
input   [Width*numInput*4-1:0]  wg2,
input   [Width*numInput-1:0]  wg3,
output out
);

wire [2:0] l1out;
wire [3:0] l2out;

genvar i;
generate 
 for(i=0;i<3;i=i+1)
 begin:layer1
 perceptron #(.Width(8),.numInput(5)) L1(
 .clk(clk),
 .in(in),
 .out(l1out[i]),
 .wg(wg1[i*Width*numInput+:Width*numInput])
);
 end
endgenerate


generate 
 for(i=0;i<4;i=i+1)
 begin:layer2
 perceptron #(.Width(8),.numInput(3)) L2(
 .clk(clk),
 .in(l1out),
 .out(l2out[i]),
 .wg(wg2[i*Width*3+:Width*3])
);
 end
endgenerate


perceptron #(.Width(8),.numInput(4)) L3(
 .clk(clk),
 .in(l2out),
 .out(out),
 .wg(wg3)
);

endmodule
