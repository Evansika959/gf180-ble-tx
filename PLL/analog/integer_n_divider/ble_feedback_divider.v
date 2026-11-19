`default_nettype none

// Compact controller for a 32/33 dual-modulus prescaler.
// With a 500 kHz reference and a x4 RF multiplier:
//   N = 1184 + cfg_divider; f_VCO = N * 500 kHz; f_RF = N * 2 MHz.
// cfg_divider = 16..56 selects 2400..2480 MHz; BLE uses 17..56.
// Hold configuration constant while running. Assert rst_n before changing it.
module ble_feedback_divider (
    input  wire       clk_prescaled,
    input  wire       rst_n,
    input  wire [5:0] cfg_divider,
    output reg        modulus_33,
    output reg        clk_feedback
);
    // Asynchronous assertion, two-clock synchronous reset release.
    (* async_reg = "true" *) reg reset_meta;
    (* async_reg = "true" *) reg reset_sync;
    always @(posedge clk_prescaled or negedge rst_n) begin
        if (!rst_n)
            begin
                reset_meta <= 1'b0;
                reset_sync <= 1'b0;
            end
        else begin
            reset_meta <= 1'b1;
            reset_sync <= reset_meta;
        end
    end

    reg [5:0] cycles_left;
    // P = 37 or 38; S = cfg_divider[4:0]; N = 32*P + S.
    wire [5:0] reload_count = {5'b10010, cfg_divider[5]}; // P - 1
    wire [5:0] half_count   = {5'b01001, cfg_divider[5]}; // floor(P/2)
    wire [5:0] swallow_count = {1'b0, cfg_divider[4:0]};

    always @(posedge clk_prescaled or negedge reset_sync) begin
        if (!reset_sync) begin
            cycles_left  <= 6'd0;
            modulus_33   <= 1'b0;
            clk_feedback <= 1'b0;
        end else if (cycles_left == 6'd0) begin
            cycles_left  <= reload_count;
            modulus_33   <= 1'b0;
            clk_feedback <= 1'b0;
        end else begin
            cycles_left <= cycles_left - 6'd1;
            // The last S prescaler periods use divide-by-33.
            if (cycles_left == swallow_count)
                modulus_33 <= 1'b1;
            // Registered feedback has one rising edge per P prescaler cycles.
            if (cycles_left == half_count)
                clk_feedback <= 1'b1;
        end
    end
endmodule

`default_nettype wire
