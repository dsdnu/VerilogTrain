module serialMultiplier(
input    wire    clk,
input    wire    reset,
input    wire       Enable, //if Enable is high, start multiplication operands are in multiplicant and multiplier
input    wire [3:0] multiplicant,
input    wire [3:0] multiplier,
output        [7:0] product,
output              done //If done is high, mutiplication is finished. Result in is product
);

reg [3:0] MultiplicantReg;
wire [3:0] loadValAreg;
wire [3:0] OutputAreg;
wire [3:0] OutputMultreg;
wire carryOut;

assign product = {OutputAreg,OutputMultreg};

always @(posedge clk)
begin
    if(Enable)
	MultiplicantReg <= multiplicant;
end

shift4Reg #(.Width(4)) AReg(
.clock(clk),
.reset(reset),
.load(), //if high, load loadValue to register. if low dont load
.loadValue(loadValAreg),
.shift(), //If high shift right by one bit. else don't shift
.shiftReg(OutputAreg),
.shiftIn(carryOut)////////////////////////////
);


shift4Reg #(.Width(4)) Multiplier(
.clock(clk),
.reset(reset),
.load(Enable), //if high, load loadValue to register. if low dont load
.loadValue(multiplier),
.shift(), //If high shift right by one bit. else don't shift
.shiftReg(OutputMultreg),
.shiftIn(OutputAreg[0])
);


adder adder(
  .a(MultiplicantReg),
  .b(OutputAreg),
  .sum(loadValAreg),
  .carry(carryOut)
);

endmodule
