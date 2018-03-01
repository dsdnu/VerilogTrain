module binaryToBCD(
    input [7:0] inBinary,
    output [7:0] outBCD
);
//MUX
wire [4:0] BCDdig1;
wire [4:0] BCDdig2;

assign outBCD[3:0] = BCDdig1[3:0];
assign outBCD[7:4] = BCDdig2[3:0];
assign BCDdig1 = ((inBinary[3:0] > 9)||inBinary[4])? inBinary[3:0] + 6 : {1'b0,inBinary[3:0]};
assign BCDdig2 = ((inBinary[7:4]+BCDdig1[4]) > 9) ? (inBinary[7:4]+BCDdig1[4]) + 6 : (inBinary[7:4]+BCDdig1[4]);
    
endmodule