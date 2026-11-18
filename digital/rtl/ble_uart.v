// UART front end for ble_tx: one input pin, no clock.
//
// uart_rx carries standard 8N1 serial: idle high, a low start bit, 8 data bits
// LSB first, a high stop bit. Each bit lasts CLKS_PER_BIT clocks; the default
// of 8 gives 1 Mbaud from the 8 MHz (SPS=8) clock. The pin passes through a
// two-flop synchronizer. After the start bit's falling edge the receiver waits
// half a bit, checks the line is still low (otherwise it was a glitch), then
// samples the middle of each data bit and checks the stop bit is high. A byte
// with a low stop bit is dropped. Each start bit resynchronizes, so the sender's
// baud rate may be off by about 3%.
//
// UART has no chip select, so a quiet line marks frames: once uart_rx has been
// idle for GAP_BITS bit times (20 = 2 byte times by default), the next byte is
// a command. Send each command as one burst, then pause. Commands:
//
//   00aa_aaaa  d0 d1 ...  write PDU bytes from address a (0 = header0,
//                          1 = length, 2.. = payload), address auto-increments
//   01cc_cccc             channel = c (latched by ble_tx at start)
//   1xxx_xxxs             s = 1 pulses start
//
// There is no read path: watch the busy pin to know when a packet has gone out.

`default_nettype none

module ble_uart #(
  parameter integer CLKS_PER_BIT = 8,
  parameter integer GAP_BITS     = 20
) (
  input  wire       clk,
  input  wire       rst_n,
  input  wire       uart_rx,

  // to ble_tx
  output reg        wr_en,
  output reg  [5:0] wr_addr,
  output reg  [7:0] wr_data,
  output reg  [5:0] channel,
  output reg        start
);

  localparam integer GAP_CLKS = GAP_BITS * CLKS_PER_BIT;
  localparam integer CW = $clog2(CLKS_PER_BIT);
  localparam integer GW = $clog2(GAP_CLKS + 1);

  // ------------------------------------------------------- synchronizer
  reg [1:0] rx_s;
  always @(posedge clk or negedge rst_n)
    if (!rst_n) rx_s <= 2'b11;
    else        rx_s <= {rx_s[0], uart_rx};
  wire rx = rx_s[1];

  // ------------------------------------------------------- byte receiver
  localparam [1:0] R_IDLE = 2'd0, R_START = 2'd1, R_DATA = 2'd2, R_STOP = 2'd3;

  reg [1:0]    rstate;
  reg [CW-1:0] cnt;
  reg [2:0]    nbit;
  reg [7:0]    sh;
  reg          byte_valid;     // one-cycle pulse, byte in sh

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      rstate     <= R_IDLE;
      cnt        <= {CW{1'b0}};
      nbit       <= 3'd0;
      sh         <= 8'd0;
      byte_valid <= 1'b0;
    end else begin
      byte_valid <= 1'b0;
      case (rstate)
        R_IDLE:
          if (!rx) begin
            cnt    <= CLKS_PER_BIT / 2 - 1;
            rstate <= R_START;
          end
        R_START:
          if (cnt == 0) begin
            if (!rx) begin
              cnt    <= CLKS_PER_BIT - 1;
              nbit   <= 3'd0;
              rstate <= R_DATA;
            end else
              rstate <= R_IDLE;               // glitch, not a start bit
          end else
            cnt <= cnt - 1'b1;
        R_DATA:
          if (cnt == 0) begin
            sh   <= {rx, sh[7:1]};            // LSB first
            cnt  <= CLKS_PER_BIT - 1;
            nbit <= nbit + 1'b1;
            if (nbit == 3'd7) rstate <= R_STOP;
          end else
            cnt <= cnt - 1'b1;
        R_STOP:
          if (cnt == 0) begin
            byte_valid <= rx;                 // low stop bit: framing error, drop
            rstate     <= R_IDLE;
          end else
            cnt <= cnt - 1'b1;
      endcase
    end
  end

  // ------------------------------------------------------- frame gap
  reg [GW-1:0] gap;
  wire         gap_done = (gap == GAP_CLKS);
  always @(posedge clk or negedge rst_n)
    if (!rst_n)                        gap <= GAP_CLKS;   // first byte is a command
    else if (!rx || rstate != R_IDLE)  gap <= {GW{1'b0}};
    else if (!gap_done)                gap <= gap + 1'b1;

  // ------------------------------------------------------- command decode
  reg       cmd_byte;          // next byte is a command
  reg       pdu_burst;         // data bytes go to the PDU buffer
  reg [5:0] addr;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      cmd_byte  <= 1'b1;
      pdu_burst <= 1'b0;
      addr      <= 6'd0;
      wr_en     <= 1'b0;
      wr_addr   <= 6'd0;
      wr_data   <= 8'd0;
      channel   <= 6'd37;
      start     <= 1'b0;
    end else begin
      wr_en <= 1'b0;
      start <= 1'b0;
      if (gap_done) begin
        cmd_byte  <= 1'b1;
        pdu_burst <= 1'b0;
      end
      if (byte_valid) begin
        cmd_byte <= 1'b0;
        if (cmd_byte) begin
          pdu_burst <= 1'b0;
          case (sh[7:6])
            2'b00:   begin pdu_burst <= 1'b1; addr <= sh[5:0]; end
            2'b01:   channel <= sh[5:0];
            default: start <= sh[0];
          endcase
        end else if (pdu_burst) begin
          wr_en   <= 1'b1;
          wr_addr <= addr;
          wr_data <= sh;
          addr    <= addr + 1'b1;
        end
      end
    end
  end

endmodule

// ble_tx with the UART front end: the chip-level digital block.
module ble_tx_uart #(
  parameter integer SPS          = 8,
  parameter integer CODE_W       = 8,
  parameter integer CLKS_PER_BIT = 8,
  parameter integer GAP_BITS     = 20
) (
  input  wire              clk,
  input  wire              rst_n,
  input  wire              uart_rx,

  output wire              busy,
  output wire signed [CODE_W-1:0] fine_code,
  output wire              code_valid,
  output wire              air_bit,
  output wire              sym_strobe
);

  wire       wr_en, start;
  wire [5:0] wr_addr, channel;
  wire [7:0] wr_data;

  ble_uart #(.CLKS_PER_BIT(CLKS_PER_BIT), .GAP_BITS(GAP_BITS)) u_uart (
    .clk(clk), .rst_n(rst_n), .uart_rx(uart_rx),
    .wr_en(wr_en), .wr_addr(wr_addr), .wr_data(wr_data),
    .channel(channel), .start(start)
  );

  ble_tx #(.SPS(SPS), .CODE_W(CODE_W)) u_tx (
    .clk(clk), .rst_n(rst_n),
    .wr_en(wr_en), .wr_addr(wr_addr), .wr_data(wr_data),
    .channel(channel), .start(start),
    .busy(busy), .fine_code(fine_code), .code_valid(code_valid),
    .air_bit(air_bit), .sym_strobe(sym_strobe)
  );

endmodule

`default_nettype wire
