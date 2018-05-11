module switch(
input   i_clk,
input   i_rst_n,
//North 
//slave i/f
input   i_north_valid,
output  o_north_ready,
input [7:0] i_north_data,
//master i/f
output reg  o_north_valid,
input  i_north_ready,
output reg [7:0] o_north_data,

//South 
//slave i/f
input   i_south_valid,
output   o_south_ready,
input [7:0] i_south_data,
//master i/f
output  reg  o_south_valid,
input  i_south_ready,
output reg [7:0] o_south_data,

//East 
//slave i/f
input   i_east_valid,
output   o_east_ready,
input [7:0] i_east_data,
//master i/f
output reg  o_east_valid,
input  i_east_ready,
output reg [7:0] o_east_data,

//West 
//slave i/f
input   i_west_valid,
output   o_west_ready,
input [7:0] i_west_data,
//master i/f
output reg  o_west_valid,
input  i_west_ready,
output reg [7:0] o_west_data
);


reg [1:0] currFifo;
reg [1:0] prevFifo;
wire [3:0] FifoValid;
wire [7:0] FifoData [3:0];
reg [3:0] FifoReady;
reg state;
localparam IDLE = 1'b0,
           WaitReady = 1'b1;

always @(posedge i_clk)
begin
    if(!i_rst_n)
    begin
        state <= IDLE;
        currFifo <= 2'b00;
        o_north_valid <= 1'b0;
        o_south_valid <= 1'b0;
        o_east_valid <= 1'b0;
        o_west_valid <= 1'b0;
        FifoReady <= 4'h0;
    end
    else
    begin
        case(state)
            IDLE:begin
               currFifo <= currFifo + 1;
               prevFifo <= currFifo;
               if(FifoValid[currFifo])
               begin
                   if(FifoData[currFifo][7:6] == 2'b00)
                   begin
                       o_north_valid <= 1'b1;
                       o_north_data <= FifoData[currFifo];
                       FifoReady[currFifo] <= 1'b1;
                       state <= WaitReady;
                   end
                   else if(FifoData[currFifo][7:6] == 2'b01)
                   begin
                       o_south_valid <= 1'b1;
                       o_south_data <= FifoData[currFifo];
                       FifoReady[currFifo] <= 1'b1;
                       state <= WaitReady;
                   end
                   else if(FifoData[currFifo][7:6] == 2'b10)
                   begin
                       o_east_valid <= 1'b1;
                       o_east_data <= FifoData[currFifo];
                       FifoReady[currFifo] <= 1'b1;
                       state <= WaitReady;
                   end
                   else if(FifoData[currFifo][7:6] == 2'b11)
                   begin
                       o_west_valid <= 1'b1;
                       o_west_data <= FifoData[currFifo];
                       FifoReady[currFifo] <= 1'b1;
                       state <= WaitReady;
                   end
               end
            end
            WaitReady:begin
                 FifoReady[prevFifo] <= 1'b0;
                 case(FifoData[prevFifo][7:6])
                      2'b00:begin
                          if(i_north_ready)
                          begin
                              o_north_valid <= 1'b0;
                              state <= IDLE;
                          end
                      end
                      2'b01:begin
                          if(i_south_ready)
                          begin
                              o_south_valid <= 1'b0;
                              state <= IDLE;
                          end
                      end
                      2'b10:begin
                          if(i_east_ready)
                          begin
                              o_east_valid <= 1'b0;
                              state <= IDLE;
                          end
                      end
                      2'b11:begin
                          if(i_west_ready)
                          begin
                              o_west_valid <= 1'b0;                      
                              state <= IDLE;
                          end
                      end
                 endcase
            end
        endcase
    end
end





fifo_generator_0 North (
  .wr_rst_busy(),      // output wire wr_rst_busy
  .rd_rst_busy(),      // output wire rd_rst_busy
  .s_aclk(i_clk),                // input wire s_aclk
  .s_aresetn(i_rst_n),          // input wire s_aresetn
  .s_axis_tvalid(i_north_valid),  // input wire s_axis_tvalid
  .s_axis_tready(o_north_ready),  // output wire s_axis_tready
  .s_axis_tdata(i_north_data),    // input wire [7 : 0] s_axis_tdata
  .m_axis_tvalid(FifoValid[0]),  // output wire m_axis_tvalid
  .m_axis_tready(FifoReady[0]),  // input wire m_axis_tready
  .m_axis_tdata(FifoData[0])    // output wire [7 : 0] m_axis_tdata
);

fifo_generator_0 South (
  .wr_rst_busy(),      // output wire wr_rst_busy
  .rd_rst_busy(),      // output wire rd_rst_busy
  .s_aclk(i_clk),                // input wire s_aclk
  .s_aresetn(i_rst_n),          // input wire s_aresetn
  .s_axis_tvalid(i_south_valid),  // input wire s_axis_tvalid
  .s_axis_tready(o_south_ready),  // output wire s_axis_tready
  .s_axis_tdata(i_south_data),    // input wire [7 : 0] s_axis_tdata
  .m_axis_tvalid(FifoValid[1]),  // output wire m_axis_tvalid
  .m_axis_tready(FifoReady[1]),  // input wire m_axis_tready
  .m_axis_tdata(FifoData[1])    // output wire [7 : 0] m_axis_tdata
);

fifo_generator_0 East (
  .wr_rst_busy(),      // output wire wr_rst_busy
  .rd_rst_busy(),      // output wire rd_rst_busy
  .s_aclk(i_clk),                // input wire s_aclk
  .s_aresetn(i_rst_n),          // input wire s_aresetn
  .s_axis_tvalid(i_east_valid),  // input wire s_axis_tvalid
  .s_axis_tready(o_east_ready),  // output wire s_axis_tready
  .s_axis_tdata(i_east_data),    // input wire [7 : 0] s_axis_tdata
  .m_axis_tvalid(FifoValid[2]),  // output wire m_axis_tvalid
  .m_axis_tready(FifoReady[2]),  // input wire m_axis_tready
  .m_axis_tdata(FifoData[2])    // output wire [7 : 0] m_axis_tdata
);

fifo_generator_0 West (
  .wr_rst_busy(),      // output wire wr_rst_busy
  .rd_rst_busy(),      // output wire rd_rst_busy
  .s_aclk(i_clk),                // input wire s_aclk
  .s_aresetn(i_rst_n),          // input wire s_aresetn
  .s_axis_tvalid(i_west_valid),  // input wire s_axis_tvalid
  .s_axis_tready(o_west_ready),  // output wire s_axis_tready
  .s_axis_tdata(i_west_data),    // input wire [7 : 0] s_axis_tdata
  .m_axis_tvalid(FifoValid[3]),  // output wire m_axis_tvalid
  .m_axis_tready(FifoReady[3]),  // input wire m_axis_tready
  .m_axis_tdata(FifoData[3])    // output wire [7 : 0] m_axis_tdata
);

endmodule
