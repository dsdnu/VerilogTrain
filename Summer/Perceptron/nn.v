module neuralNetowrk #(parameter [0:8] sizeLayer, numInput=5, Width=8)
(input clk, input [numInput-1:0] in, input [Width*numInput*3-1:0] wg1, input [Width*numInput*4-1:0] wg2,input [Width*numInput-1:0] wg3,output [sizeLayer[6:8]-1:0] out);
wire [sizeLayer[0:2]-1:0] l1out;
wire [sizeLayer[3:5]-1:0] l2out;

genvar i;
generate 
 for(i=0;i<sizeLayer[0:2];i=i+1)
 begin:layer1
 perceptron #(.Width(Width),.numInput(numInput)) L1(.clk(clk),.in(in),.out(l1out[i]),.wg(wg1[i*Width*numInput+:Width*numInput]));
 end
endgenerate


generate 
 for(i=0;i<sizeLayer[3:5];i=i+1)
 begin:layer2
 perceptron #(.Width(8),.numInput(sizeLayer[0:2])) L2(.clk(clk),.in(l1out),.out(l2out[i]),.wg(wg2[i*Width*sizeLayer[0:2]+:Width*sizeLayer[0:2]]));
 end
endgenerate

generate 
 for(i=0;i<sizeLayer[6:8];i=i+1)
 begin:layer3
 perceptron #(.Width(8),.numInput(sizeLayer[3:5])) L3(.clk(clk),.in(l2out),.out(out[i]),.wg(wg3[i*Width*sizeLayer[3:5]]+:Width*sizeLayer[3:5]));
 end
endgenerate

endmodule
