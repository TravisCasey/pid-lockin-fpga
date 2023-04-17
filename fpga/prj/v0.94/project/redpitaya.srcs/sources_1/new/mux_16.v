`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 16-input multiplexer
// Author: Travis Casey
//////////////////////////////////////////////////////////////////////////////////


module mux_16
    #(
    parameter LENGTH = 14
    )
    (
    input         [     4-1:0] switch , // Number 0-15 that decides which input to assign to output
    input  signed [LENGTH-1:0] in_0   ,
    input  signed [LENGTH-1:0] in_1   ,
    input  signed [LENGTH-1:0] in_2   ,
    input  signed [LENGTH-1:0] in_3   ,
    input  signed [LENGTH-1:0] in_4   ,
    input  signed [LENGTH-1:0] in_5   ,
    input  signed [LENGTH-1:0] in_6   ,
    input  signed [LENGTH-1:0] in_7   ,
    input  signed [LENGTH-1:0] in_8   ,
    input  signed [LENGTH-1:0] in_9   ,
    input  signed [LENGTH-1:0] in_10  ,
    input  signed [LENGTH-1:0] in_11  ,
    input  signed [LENGTH-1:0] in_12  ,
    input  signed [LENGTH-1:0] in_13  ,
    input  signed [LENGTH-1:0] in_14  ,
    input  signed [LENGTH-1:0] in_15  ,
    output signed [LENGTH-1:0] out
    );
    
    // wire definitions
    wire   signed [LENGTH-1:0] wire_0 ;
    wire   signed [LENGTH-1:0] wire_1 ;
    wire   signed [LENGTH-1:0] wire_2 ;
    wire   signed [LENGTH-1:0] wire_3 ;
    wire   signed [LENGTH-1:0] wire_4 ;
    wire   signed [LENGTH-1:0] wire_5 ;
    wire   signed [LENGTH-1:0] wire_6 ;
    wire   signed [LENGTH-1:0] wire_7 ;
    wire   signed [LENGTH-1:0] wire_8 ;
    wire   signed [LENGTH-1:0] wire_9 ;
    wire   signed [LENGTH-1:0] wire_10;
    wire   signed [LENGTH-1:0] wire_11;
    wire   signed [LENGTH-1:0] wire_12;
    wire   signed [LENGTH-1:0] wire_13;
    wire   signed [LENGTH-1:0] wire_14;
    wire   signed [LENGTH-1:0] wire_15;
    
    // the wire corresponding to the switch number has the value of the same input
    // the other wires are 0
    assign wire_0  = {LENGTH{(switch == 4'b0000)}} & in_0 ;
    assign wire_1  = {LENGTH{(switch == 4'b0001)}} & in_1 ;
    assign wire_2  = {LENGTH{(switch == 4'b0010)}} & in_2 ;
    assign wire_3  = {LENGTH{(switch == 4'b0011)}} & in_3 ;
    assign wire_4  = {LENGTH{(switch == 4'b0100)}} & in_4 ;
    assign wire_5  = {LENGTH{(switch == 4'b0101)}} & in_5 ;
    assign wire_6  = {LENGTH{(switch == 4'b0110)}} & in_6 ;
    assign wire_7  = {LENGTH{(switch == 4'b0111)}} & in_7 ;
    assign wire_8  = {LENGTH{(switch == 4'b1000)}} & in_8 ;
    assign wire_9  = {LENGTH{(switch == 4'b1001)}} & in_9 ;
    assign wire_10 = {LENGTH{(switch == 4'b1010)}} & in_10;
    assign wire_11 = {LENGTH{(switch == 4'b1011)}} & in_11;
    assign wire_12 = {LENGTH{(switch == 4'b1100)}} & in_12;
    assign wire_13 = {LENGTH{(switch == 4'b1101)}} & in_13;
    assign wire_14 = {LENGTH{(switch == 4'b1110)}} & in_14;
    assign wire_15 = {LENGTH{(switch == 4'b1111)}} & in_15;
    
    // output has just the input corresponding to the switch number
    assign out = wire_0  | wire_1  | wire_2  | wire_3  |
                 wire_4  | wire_5  | wire_6  | wire_7  |
                 wire_8  | wire_9  | wire_10 | wire_11 |
                 wire_12 | wire_13 | wire_14 | wire_15 ;    
    
endmodule
