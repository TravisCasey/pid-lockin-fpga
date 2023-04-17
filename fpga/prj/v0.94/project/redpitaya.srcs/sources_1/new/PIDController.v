`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// PID Controller 
// Author: Travis Casey
//////////////////////////////////////////////////////////////////////////////////


module PIDController
    #(
    parameter GAIN_LENGTH = 20, // Length of (signed) gains
    parameter PSHIFT = 8, // Shift of gains to account for accuracy less than 1
    parameter ISHIFT = 39,
    parameter DSHIFT = 0
    )
    (
    input clk,
    input rstn,
    input signed [14-1:0] in,
    output signed [14-1:0] out,
    output signed [14-1:0] error,
    input signed [14-1:0] set_point,
    input signed [GAIN_LENGTH-1:0] p_gain,
    input signed [GAIN_LENGTH-1:0] i_gain,
    input signed [GAIN_LENGTH-1:0] d_gain,
    input signed [14-1:0] output_max,
    input signed [14-1:0] output_min
);
    
// Calculate Error

wire signed [15-1:0] error_test;

assign error_test = set_point - in;

// Check for saturation 

assign error = ^error_test[14:13] ? {error_test[14], {13{~error_test[14]}}}
                                  : error_test[13:0];
    
    
// Proportional Block

wire signed [14+GAIN_LENGTH:0] p_raw;
wire signed [14+GAIN_LENGTH-PSHIFT:0] p_response;

assign p_raw = error * p_gain;
assign p_response = p_raw[14+GAIN_LENGTH:PSHIFT];

    
// Integral Block

wire signed [14+GAIN_LENGTH:0] i_raw;
reg signed [13+ISHIFT:0] i_mem; 
wire signed [13+ISHIFT+1:0] i_sum; // 1 extra bit to test for overflow
wire signed [13:0] i_response;
wire signed [13+ISHIFT:0] i_max;
wire signed [13+ISHIFT:0] i_min;
wire signed [13+ISHIFT+2:0] i_max_test;
wire signed [13+ISHIFT+2:0] i_min_test;

assign i_raw = error * i_gain;
assign i_sum = i_raw + i_mem;

// The max and min tests cap the integrator memory at the amount corresponding
// to the minimum and maximum outputs of the PID. These are from the clamp values
// on the corresponding outputs.

assign i_max = {output_max, {ISHIFT{1'b0}}};
assign i_min = {output_min, {ISHIFT{1'b1}}};
assign i_max_test = i_sum - i_max;
assign i_min_test = i_sum - i_min;

always @ (posedge clk)
begin
    if (~rstn)
    begin
        i_mem <= {{13+ISHIFT}{1'b0}};
    end
    else if (i_max_test[13+ISHIFT+2] == 1'b0)
    begin
        i_mem <= i_max;
    end
    else if (i_min_test[13+ISHIFT+2] == 1'b1)
    begin
        i_mem <= i_min;
    end
    else
    begin
        i_mem <= i_sum[13+ISHIFT:0];
    end
end

assign i_response = i_mem[13+ISHIFT:ISHIFT];



// Derivative Block

wire signed [14+GAIN_LENGTH:0] d_raw;
reg signed [14+GAIN_LENGTH-DSHIFT:0] d_mem;
reg signed [14+GAIN_LENGTH-DSHIFT:0] d_mem_2;
reg signed [14+GAIN_LENGTH-DSHIFT+1:0] d_response; // Extra bit accounts for possible sum overflow

assign d_raw = error * d_gain;

always @ (posedge clk)
begin
    if (~rstn) 
    begin
        d_mem <= {(14+GAIN_LENGTH-DSHIFT+1){1'b0}};
        d_mem_2 <= {(14+GAIN_LENGTH-DSHIFT+1){1'b0}};
        d_response <= {(14+GAIN_LENGTH-DSHIFT+2){1'b0}};
    end
    else
    begin
        d_mem <= d_raw[14+GAIN_LENGTH:DSHIFT];
        d_mem_2 <= d_mem;
        d_response <= d_mem - d_mem_2;
    end
end


// Sum Block

wire signed [19+GAIN_LENGTH-1:0] total_sum; // Maximum possible width

reg signed [14-1:0] data_out;

assign total_sum = p_response + i_response + d_response;

OutputClamp #(.INPUT_WIDTH(19+GAIN_LENGTH)) pid_clamp (.clk(clk), .rstn(rstn), .ena(1'b1),
.in(total_sum), .out(out), .max(output_max), .min(output_min));


endmodule
