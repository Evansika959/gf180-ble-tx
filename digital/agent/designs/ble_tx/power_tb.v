// Activity for power scoring (pd/activity.py): load the demo advertising PDU
// (power_pdu.hex, from model/ble_adv.py), send one packet on channel 37 at 8 MHz,
// and dump the block's switching only while the packet is on air.
//
// Read by the agent flow, not by the cocotb tests. Defines from pd/activity.py:
//   VCD_OUT   where to write the VCD
//   STIM_DIR  this folder
//   HAS_PORT_<name> for each input port of the netlist under test
`timescale 1ns / 1ps
`default_nettype none
module power_tb;
  reg clk = 1'b0, rst_n = 1'b0, wr_en = 1'b0, start = 1'b0;
  reg [5:0] wr_addr = 6'd0, channel = 6'd37;
  reg [7:0] wr_data = 8'd0;
  wire busy, code_valid, air_bit, sym_strobe;
  wire [7:0] fine_code;
  reg [7:0] pdu [0:38];
  integer i;

  always #62.5 clk = ~clk;   // 8 MHz, one 8 MS/s DAC code per clock

  ble_tx dut (
    .clk(clk), .rst_n(rst_n), .wr_en(wr_en), .wr_addr(wr_addr), .wr_data(wr_data),
    .channel(channel), .start(start),
    .busy(busy), .fine_code(fine_code), .code_valid(code_valid),
    .air_bit(air_bit), .sym_strobe(sym_strobe));

  initial begin
    $readmemh({`STIM_DIR, "/power_pdu.hex"}, pdu);
    repeat (3) @(negedge clk);
    rst_n = 1'b1;
    for (i = 0; i < pdu[1] + 2; i = i + 1) begin    // header, length, payload
      @(negedge clk); wr_en = 1'b1; wr_addr = i; wr_data = pdu[i];
    end
    @(negedge clk); wr_en = 1'b0;
    @(negedge clk); start = 1'b1;
    @(negedge clk); start = 1'b0;
    $dumpfile(`VCD_OUT);
    $dumpvars(0, power_tb.dut);
    wait (!busy);
    $dumpoff;
    $finish;
  end

  initial begin
    #2_000_000;               // 2 ms: a packet takes about 0.25 ms
    $display("power_tb: the packet never finished");
    $fatal(1);
  end
endmodule

`default_nettype wire
