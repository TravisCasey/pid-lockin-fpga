`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Applies sum, subtract and inversion operations to two inputs and outputs the results.
// Author: Travis Casey
//////////////////////////////////////////////////////////////////////////////////


module Operations(
    input clk,
    // input data
    input signed [14-1:0] in_1,
    input signed [14-1:0] in_2,
    // operation ouputs
    output signed [14-1:0] sum,
    output signed [14-1:0] subtract_12,
    output signed [14-1:0] subtract_21,
    output signed [14-1:0] invert_1,
    output signed [14-1:0] invert_2
);

wire signed [15-1:0] sum_test;
wire signed [15-1:0] subtract_12_test;
wire signed [15-1:0] subtract_21_test;

assign sum_test = in_1 + in_2;
assign subtract_12_test = in_1 - in_2;
assign subtract_21_test = in_2 - in_1;

// Check for saturation

assign sum         = ^sum_test[14:13]         ? {sum_test[14], {13{~sum_test[14]}}}
                                              : sum_test[13:0];
                                              
assign subtract_12 = ^subtract_12_test[14:13] ? {subtract_12_test[14], {13{~subtract_12_test[14]}}}
                                              : subtract_12_test[13:0];
                                              
assign subtract_21 = ^subtract_21_test[14:13] ? {subtract_21_test[14], {13{~subtract_21_test[14]}}}
                                              : subtract_21_test[13:0];


assign invert_1 = ~in_1;
assign invert_2 = ~in_2;

endmodule
