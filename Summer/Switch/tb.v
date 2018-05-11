`timescale 1ns/1ps

`define Period 10
`define PacketLimit 100

module tb();


reg clk;
reg rst;
reg pktValid;
reg [7:0] pktData;
wire pktReady;
wire [7:0] southData;

initial
begin
    clk = 0;
    forever
    begin
        clk = ~clk;
        #(`Period/2);
    end
end


initial
begin
    rst = 0;
    pktValid = 0;
    #100;
    rst = 1;
    $display("Sending a packet from North to South");
    @(posedge clk);
    #2;
    pktValid <= 'b1;
    pktData <= {2'b01,6'h35};
    wait(pktReady);
    @(posedge clk);
    pktValid <= 'b0;
end


always @(posedge clk)
begin
   if(southPktValid)
       $display("Packet received from south: %h",southData);
end

reg [1:0] northDest;
integer northSendPacketCounter;
integer northRecvPacketCounter;

//North inject
always @(posedge clk)
begin
   if(!rst)
   begin
      o_northValid <= 0;
      northPacketCounter = 0;
   end
   else
   begin
      if(northSendPacketCounter < PacketLimit)
      begin
	   o_northValid <= 1;
      	if(northReady)
      	begin
          northDest = $urandom()%4;
          o_northData <= {northDest,6'ha5};
          northSendPacketCounter <= northSendPacketCounter + 1;
      	end
       end
      else
          o_northValid <= 0;
end


always @(posedge clk)
begin
   if(i_north_valid)
          northRecvPacketCounter   <= northRecvPacketCounter + 1;


always @(posedge clk)
begin
    totalPacketCounter <= northRecvPacketCounter + southRecvPacketCounter + eastRecvPacketCounter + westRecvPacketCounter;
    if(totalPacketCounter == 4*`PacketLimit)
        $stop;
end
      


switch mySwitch(
.i_clk(clk),
.i_rst_n(rst),
//North 
//slave i/f
.i_north_valid(pktValid),
.o_north_ready(pktReady),
.i_north_data(pktData),
//master i/f
.o_north_valid(),
.i_north_ready(1'b1),
.o_north_data(),

//South 
//slave i/f
.i_south_valid(),
.o_south_ready(),
.i_south_data(),
//master i/f
.o_south_valid(southPktValid),
.i_south_ready(1'b1),
.o_south_data(southData),

//East 
//slave i/f
.i_east_valid(),
.o_east_ready(),
.i_east_data(),
//master i/f
.o_east_valid(),
.i_east_ready(1'b1),
.o_east_data(),

//West 
//slave i/f
.i_west_valid(),
.o_west_ready(),
.i_west_data(),
//master i/f
.o_west_valid(),
.i_west_ready(1'b1),
.o_west_data()
);

endmodule
