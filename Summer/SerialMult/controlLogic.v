module controlLogic(
input    wire    clk,
input    wire    Rst,
input    wire    En,
input    wire    qin,
output   reg     done,
output   reg     shift,
output   reg     load
);



reg [2:0] state;
reg [2:0] counter;

localparam Idle = 3'b000,
           Load = 3'b001,
           WaitLoad = 3'b010,
           WaitShift = 3'b100,
           Done = 3'b101;


always @(posedge clk)
begin
    if(Rst)
    begin
        state <= Idle;
	counter <= 0;
        load <= 1'b0;
    end
    else
    begin
	case(state)
            Idle:begin
                 done <= 1'b0;
                 counter <= 0;
                 if(En)
                     state <= Load;
            end
            Load:begin
                state <= WaitLoad;
                if(qin)
                    load <= 1'b1;
            end
            WaitLoad:begin
                load <= 1'b0;
                counter <= counter + 1;
                shift <= 1'b1;
                state <= WaitShift;
            end
	    WaitShift:begin
                shift <= 1'b0;
                if(counter == 4)
                   state <= Done;
                else
                   state <= Load;
            end
            Done:begin
                shift <= 1'b0;
                state <= Idle;
                done <= 1'b1;
            end
	endcase
    end
end


endmodule
