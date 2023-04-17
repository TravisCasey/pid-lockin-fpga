`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Calibration Module
// Author: Travis Casey
//////////////////////////////////////////////////////////////////////////////////

// The module applies the given offset to the input then applies the gain. After,
// it checks for saturation. If ena is 0 then the output is set to the input.

module Calibration 
    #(
    parameter GAIN_SHIFT = 12
    ) (
    input clk, rstn, ena,
    input  signed [14-1:0] in,
    input  signed [14-1:0] offset,
    input  signed [16-1:0] gain,
    output signed [14-1:0] out
);

wire signed [15-1:0] sum;
wire signed [27-1:0] mult_raw;
wire signed [27-GAIN_SHIFT-1:0] mult;
reg  signed [14-1:0] calib;

assign sum = in - offset;
assign mult_raw = sum * gain;
assign mult = mult_raw[26:GAIN_SHIFT];

always @ (posedge clk)
begin
    if (~rstn)
    begin
        calib <= 14'b0;
    end
    else if (~ena)
    begin
        calib <= in;
    end
    else
    begin
        calib <= ^mult[26-GAIN_SHIFT:13] ? {mult[26-GAIN_SHIFT], {13{~mult[26-GAIN_SHIFT]}}} 
                                         : mult[13:0]; // Checks for saturation
    end
end

assign out = calib;    


endmodule
