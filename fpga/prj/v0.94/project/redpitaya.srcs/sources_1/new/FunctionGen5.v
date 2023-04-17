`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Function Generator 5 Module generates sine waves with customizable period, 
// phase and amplitude. Maximum frequency is 250 kHz.
// Author: Travis Casey
//////////////////////////////////////////////////////////////////////////////////


module FunctionGen5 #(
    parameter AMP_SHIFT = 12
    ) (
    input clk, rstn,
    input [16-1:0] period, 
    input [9-1:0] phase, // (0-499)
    input signed [AMP_SHIFT:0] amplitude, 
    output signed [14-1:0] sin_out
);

// Initialize sine wave data. The file contains one fourth period of a sine wave;
// The rest can be constructed from that.

reg signed [14-1:0] sin_dat_5 [125-1:0];
initial
begin
    $readmemb("sin_5.mem", sin_dat_5);
end


// Determine entry of memory (through x) and the corresponding
// quadrant to generate the entire wave.

// The counts and tick define a frequency divider. Delays a number of clock cycles
// defined by period input.

reg [7-1:0] x; // x value (0 - 124)
reg [2-1:0] quadrant;
reg [2-1:0] quadrant2;
reg [16-1:0] count;
wire [16-1:0] count_next;
wire tick;

always @(posedge clk)
begin
    if (~rstn)
    begin
        count <= 16'b0;
        x <= 7'b0;
        quadrant <= 2'b00;
        quadrant2 <= 2'b00; 
    end
    else
    begin
        count <= count_next;
        quadrant2 <= quadrant; // For timing properly with the phase
        if (tick)
        begin
            if (x == 10'd124)
            begin
                x <= 0;
                quadrant <= quadrant + 1;
            end
            else
            begin
                x <= x + 1;
            end 
        end
    end
end

assign count_next = (count == period) ? 14'b0 : count + 1'b1;
assign tick = (period == 16'b0) ? 1'b1 : (count == period);


// Apply phase to both x and the quadrant value

reg [7-1:0] phase_x;
reg [2-1:0] phase_quadrant;
wire [10-1:0] phase_sum;
wire [2-1:0] final_quadrant;

assign phase_sum = x + phase;

always @(posedge clk) 
begin
    if (~rstn)
    begin
        phase_x <= 7'b0;
        phase_quadrant <= 2'b0;
    end
    else if (phase_sum > 10'd499)
    begin
        phase_x <= phase_sum - 10'd500;
        phase_quadrant <= 2'b00;
    end
    else if (phase_sum > 10'd374)
    begin
        phase_x <= phase_sum - 10'd375; 
        phase_quadrant <= 2'b11;
    end
    else if (phase_sum > 10'd249)
    begin
        phase_x <= phase_sum - 10'd250;
        phase_quadrant <= 2'b10;
    end
    else if (phase_sum > 10'd124)
    begin
        phase_x <= phase_sum - 10'd125;
        phase_quadrant <= 2'b01;
    end
    else
    begin
        phase_x <= phase_sum;
        phase_quadrant <= 2'b00;
    end
end

assign final_quadrant = quadrant2 + phase_quadrant;


// Define the sine wave by applying transformations to the sine memory.

reg signed [14-1:0] y_sin;

always @(posedge clk)
begin
    if (final_quadrant == 2'b00)
        y_sin <= sin_dat_5[phase_x];
    else if (final_quadrant == 2'b01)
        y_sin <= sin_dat_5[7'd124 - phase_x];
    else if (final_quadrant == 2'b10)
        y_sin <= - sin_dat_5[phase_x];
    else
        y_sin <= - sin_dat_5[7'd124 - phase_x];
end


// Apply amplitude. Base sine wave is 2 Vpp. The maximum multiplier is +/- 1V
// which is given by 13'h0fff / 13'h1000 respectively.

wire signed [26-1:0] sin_raw;

assign sin_raw = y_sin * amplitude;
assign sin_out = sin_raw >>> AMP_SHIFT;

endmodule
