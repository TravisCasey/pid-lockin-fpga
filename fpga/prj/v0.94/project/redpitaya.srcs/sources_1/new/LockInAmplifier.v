`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Lock-in amplifier module for the Red Pitaya
// Author: Travis Casey
//////////////////////////////////////////////////////////////////////////////////


module LockInAmplifier 
    #(
    parameter SCALE_SHIFT = 16
    ) (
    input clk, rstn,
    input  signed [14-1:0] in,
    input  signed [14-1:0] ref,
    input         [ 5-1:0] shift,
    input  signed [20-1:0] scale,
    output signed [14-1:0] out
);


// Mixer
 
wire signed [28-1:0] mult;

assign mult = in * ref;


// 3rd order low pass filter

wire signed [28-1:0] filter_out_1;
wire signed [28-1:0] filter_out_2;
wire signed [28-1:0] filter_out_3;

lowPassFilter #(
    .SIGNAL_WIDTH  (28)
) lia_lpf_inst_1 (
    .clk    (clk         ), 
    .rstn   (rstn        ), 
    .in     (mult        ), 
    .shift  (shift       ), 
    .out    (filter_out_1)
);

lowPassFilter #(
    .SIGNAL_WIDTH  (28)
) lia_lpf_inst_2 (
    .clk    (clk         ), 
    .rstn   (rstn        ), 
    .in     (filter_out_1), 
    .shift  (shift       ), 
    .out    (filter_out_2)
);

lowPassFilter #(
    .SIGNAL_WIDTH  (28)
) lia_lpf_inst_3 (
    .clk    (clk         ), 
    .rstn   (rstn        ), 
    .in     (filter_out_2), 
    .shift  (shift       ), 
    .out    (filter_out_3)
);


// Apply a scaling factor to the filtered data. This allows the user to have optimal
// resolution on the output of the lock-in amplifier.

wire signed [48-1:0] scaled_raw;
wire signed [48-SCALE_SHIFT-1:0] scaled;

assign scaled_raw = scale * filter_out_3;
assign scaled = scaled_raw[47:SCALE_SHIFT];


// Check for saturation

//reg signed [14-1:0] sat_data;

OutputClamp #(.INPUT_WIDTH(48-SCALE_SHIFT)) lia_clamp (.clk(clk), .rstn(rstn), .ena(1'b1), .in(scaled),
 .out(out), .max(14'h1fff), .min(14'h2000));


//always @(posedge clk)
//begin
//    if (~rstn)
//        sat_data = 14'b0;
//    else if (&scaled[47-SCALE_SHIFT:13] || ~|scaled[47-SCALE_SHIFT:13])
//        sat_data = scaled[13:0];
//    else if (scaled[47-SCALE_SHIFT] == 1'b0) // Positive Overflow
//        sat_data = 14'h1fff;
//    else // Negative Overflow
//        sat_data = 14'h2000;
//end


//assign out = sat_data;
    
endmodule
