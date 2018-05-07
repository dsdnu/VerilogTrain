module shift4Reg #(parameter Width=4)(
input wire clock,
input wire reset,
input wire load, //if high, load loadValue to register. if low dont load
input wire [Width-1:0] loadValue,
input wire shift, //If high shift right by one bit. else don't shift
output reg [Width-1:0] shiftReg,
input wire shiftIn
);

always @(posedge clock)
begin
    if(reset)
        shiftReg <= {Width{1'b0}};
    else if(load)
        shiftReg <= loadValue;
    else if(shift)
        shiftReg <= {shiftIn,shiftReg[Width-1:1]};
    //else
    //    shiftReg <= shiftReg
end

endmodule
