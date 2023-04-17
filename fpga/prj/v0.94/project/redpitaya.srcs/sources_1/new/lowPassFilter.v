`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// First Order Low Pass Filter 
// Author: Travis Casey
//////////////////////////////////////////////////////////////////////////////////


module lowPassFilter
    #(
    parameter SIGNAL_WIDTH = 14,
    parameter SHIFT_WIDTH = 5
    ) (
    input clk, rstn,
    input signed [SIGNAL_WIDTH - 1:0] in,
    input [SHIFT_WIDTH - 1:0] shift,
    output signed [SIGNAL_WIDTH - 1:0] out
);


localparam MEM_WIDTH = 48; // test for best values

reg signed [MEM_WIDTH-1:0] memory; 
wire signed [MEM_WIDTH:0] memory_test;
wire signed [MEM_WIDTH-6-1:0] adjustment;

assign memory_test = in - adjustment + memory;
assign adjustment = memory >>> shift;
assign out = adjustment[SIGNAL_WIDTH-1:0];

always @(posedge clk)
begin
    if (~rstn)
    begin
        memory <= {MEM_WIDTH{1'b0}};
    end
    else
    begin
        if (memory_test[MEM_WIDTH:MEM_WIDTH-1] == 2'b01) // Positive Overflow
            memory <= {1'b0, {MEM_WIDTH-1{1'b1}}};
        else if (memory_test[MEM_WIDTH:MEM_WIDTH-1] == 2'b10) // Negative Overflow
            memory <= {1'b1, {MEM_WIDTH-1{1'b0}}};
        else
            memory <= memory_test[MEM_WIDTH-1:0];    
    end
end
    
endmodule
