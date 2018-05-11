module fifo #(parameter DataWidth=8,FifoDepth=128)(
input   clk,
input   rst,
input   wrEn,
input   rdEn,
input  [DataWidth-1:0] wrData,
output [DataWidth-1:0] rdData,
output  full,
output  empty
);

/*reg [DataWidth-1:0] myRam [FifoDepth-1:0];
wire [$clog2(FifoDepth)-1:0] count; 
reg [$clog2(FifoDepth)-1:0] wrPntr;
reg [$clog2(FifoDepth)-1:0] rdPntr;


assign count = rdPntr-wrPntr;
assign empty = (count == FifoDepth-1) ? 1'b1 : 1'b0;
assign full = (count == 0) ? 1'b1 : 1'b0;

always @(posedge clk)
begin
    if(rst)
       wrPntr <= {7{1'b0}};//clog2
    else
        if(wrEn & !full)
            wrPntr <= wrPntr + 1;
end

always @(posedge clk)
begin
    if(rst)
       rdPntr <= {7{1'b1}} ;
    else
        if(rdEn & !empty)
            rdPntr <= rdPntr + 1;
end


always @(posedge clk)
begin
    if(wrEn & !full)
        myRam[wrPntr] <= wrData;
end


always @(posedge clk)
begin
    if(rdEn & !empty)
        rdData <= myRam[rdPntr+1];
end*/



myFifo myfifo (
  .clk(clk),      // input wire clk
  .srst(rst),    // input wire srst
  .din(wrData),      // input wire [7 : 0] din
  .wr_en(wrEn),  // input wire wr_en
  .rd_en(rdEn),  // input wire rd_en
  .dout(rdData),    // output wire [7 : 0] dout
  .full(full),    // output wire full
  .empty(empty)  // output wire empty
);



endmodule