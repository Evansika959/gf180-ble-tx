`default_nettype none

// The prescaler clock and MC port cross the digital/analog boundary.
// The signed Gaussian output remains a digital interface to the future DAC.
module A01_digital (
    input  wire              clk_8m,
    input  wire              rst_n,
    input  wire              uart_rx,
    input  wire              clk_prescaled,
    input  wire        [5:0] cfg_divider,
    output wire              modulus_33,
    output wire              clk_feedback,
    output wire signed [7:0] fine_code,
    output wire              code_valid,
    output wire              air_bit,
    output wire              sym_strobe
);
    ble_tx_uart transmitter (
        .clk(clk_8m), .rst_n(rst_n), .uart_rx(uart_rx),
        .fine_code(fine_code), .code_valid(code_valid),
        .air_bit(air_bit), .sym_strobe(sym_strobe)
    );
    ble_feedback_divider feedback_divider (
        .clk_prescaled(clk_prescaled), .rst_n(rst_n), .cfg_divider(cfg_divider),
        .modulus_33(modulus_33), .clk_feedback(clk_feedback)
    );
endmodule

`default_nettype wire
