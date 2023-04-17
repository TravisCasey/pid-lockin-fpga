`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Author: Travis Casey
// Ramp Generating Module
//////////////////////////////////////////////////////////////////////////////////


module Ramp #(
    parameter AMP_SHIFT = 12
    ) (
    input clk, rstn,
    input [16-1:0] period, 
    input [12-1:0] phase, // Always set to 0
    input signed [AMP_SHIFT:0] amplitude, 
    output signed [14-1:0] lin_out
);

// Note this module is simply a modification of FunctionGen1 with linear data instead
// of sinusoidal.

// Initialize linear data. The file contains one fourth period of a triangle wave;
// The rest can be constructed from that.

reg signed [14-1:0] lin_dat_1 [625-1:0];
initial
begin
    $readmemb("lin.mem", lin_dat_1);
end


// Determine entry of memory (through x) and the corresponding
// quadrant to generate the entire wave.

// The counts and tick define a frequency divider. Delays a number of clock cycles
// defined by period input.

reg [10-1:0] x; // x value (0 - 624)
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
        x <= 10'b0;
        quadrant <= 2'b00;
        quadrant2 <= 2'b00; 
    end
    else
    begin
        count <= count_next;
        quadrant2 <= quadrant; // For timing properly with the phase
        if (tick)
        begin
            if (x == 10'd624)
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

reg [10-1:0] phase_x;
reg [2-1:0] phase_quadrant;
wire [12-1:0] phase_sum;
wire [2-1:0] final_quadrant;

assign phase_sum = x + phase;

always @(posedge clk) 
begin
    if (~rstn)
    begin
        phase_x <= 10'b0;
        phase_quadrant <= 2'b0;
    end
    else if (phase_sum > 12'd2499)
    begin
        phase_x <= phase_sum - 12'd2500;
        phase_quadrant <= 2'b00;
    end
    else if (phase_sum > 12'd1874)
    begin
        phase_x <= phase_sum - 12'd1875; 
        phase_quadrant <= 2'b11;
    end
    else if (phase_sum > 12'd1249)
    begin
        phase_x <= phase_sum - 12'd1250;
        phase_quadrant <= 2'b10;
    end
    else if (phase_sum > 12'd624)
    begin
        phase_x <= phase_sum - 12'd625;
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

reg signed [14-1:0] y_lin;

always @(posedge clk)
begin
    if (final_quadrant == 2'b00)
        y_lin <= lin_dat_1[phase_x];
    else if (final_quadrant == 2'b01)
        y_lin <= lin_dat_1[10'd624 - phase_x];
    else if (final_quadrant == 2'b10)
        y_lin <= - lin_dat_1[phase_x];
    else
        y_lin <= - lin_dat_1[10'd624 - phase_x];
end


// Apply amplitude. Base triangle wave is 2 Vpp. The maximum multiplier is +/- 1V
// which is given by 13'h0fff / 13'h1000 respectively.

wire signed [AMP_SHIFT+14-1:0] lin_raw;

assign lin_raw = y_lin * amplitude;
assign lin_out = lin_raw >>> AMP_SHIFT;

endmodule
