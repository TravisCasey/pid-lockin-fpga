`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module to restrict DAC output to within a certain range
// Author: Travis Casey
//////////////////////////////////////////////////////////////////////////////////


module OutputClamp
    #(
    parameter INPUT_WIDTH = 14 // (14 or higher)
    ) (
    input clk, rstn, ena,
    input signed [INPUT_WIDTH-1:0] in,
    output signed [14-1:0] out,
    input signed [14-1:0] max,
    input signed [14-1:0] min
    );
    
reg signed [14-1:0] data_clamped;
wire signed [INPUT_WIDTH:0] max_test;
wire signed [INPUT_WIDTH:0] min_test;

assign max_test = in - max;
assign min_test = in - min; 

always @ (posedge clk)
begin
    if (~rstn)
        data_clamped <= 14'b0;
    else if (~ena)
        data_clamped <= in;
    else
    begin
        if (max_test[INPUT_WIDTH] == 1'b0)
            data_clamped <= max;
        else if (min_test[INPUT_WIDTH] == 1'b1)
            data_clamped <= min;
        else
            data_clamped <= in;
    end
end

assign out = data_clamped;
        
    
endmodule
