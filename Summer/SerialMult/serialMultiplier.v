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
reg carry;
wire carryOut;
wire shift;
wire load;

assign product = {OutputAreg,OutputMultreg};

always @(posedge clk)
begin
    if(reset)
        MultiplicantReg <= 0;
    else if(Enable)
	MultiplicantReg <= multiplicant;
end

always @(posedge clk)
begin
     if(reset)
         carry <= 0;
     else if(load)
         carry <= carryOut;
     else
         carry <= 0;
end

shift4Reg #(.Width(4)) AReg(
.clock(clk),
.reset(reset),
.load(load), //if high, load loadValue to register. if low dont load
.loadValue(loadValAreg),
.shift(shift), //If high shift right by one bit. else don't shift
.shiftReg(OutputAreg),
.shiftIn(carry)
);


shift4Reg #(.Width(4)) Multiplier(
.clock(clk),
.reset(reset),
.load(Enable), //if high, load loadValue to register. if low dont load
.loadValue(multiplier),
.shift(shift), //If high shift right by one bit. else don't shift
.shiftReg(OutputMultreg),
.shiftIn(OutputAreg[0])
);


adder adder(
  .a(MultiplicantReg),
  .b(OutputAreg),
  .sum(loadValAreg),
  .carry(carryOut)
);


controlLogic cl(
.clk(clk),
.Rst(reset),
.En(Enable),
.qin(OutputMultreg[0]),
.done(done),
.shift(shift),
.load(load)
);

endmodule
