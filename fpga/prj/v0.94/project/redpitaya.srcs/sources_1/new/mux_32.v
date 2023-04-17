`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Author: Travis Casey
// 32-input Multiplexer
//////////////////////////////////////////////////////////////////////////////////


module mux_32
    #(
    parameter LENGTH = 14
    )
    (
    input         [     5-1:0] switch , // Number 0-15 that decides which input to assign to output
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
    input  signed [LENGTH-1:0] in_16   ,
    input  signed [LENGTH-1:0] in_17   ,
    input  signed [LENGTH-1:0] in_18   ,
    input  signed [LENGTH-1:0] in_19   ,
    input  signed [LENGTH-1:0] in_20   ,
    input  signed [LENGTH-1:0] in_21   ,
    input  signed [LENGTH-1:0] in_22   ,
    input  signed [LENGTH-1:0] in_23   ,
    input  signed [LENGTH-1:0] in_24   ,
    input  signed [LENGTH-1:0] in_25   ,
    input  signed [LENGTH-1:0] in_26  ,
    input  signed [LENGTH-1:0] in_27  ,
    input  signed [LENGTH-1:0] in_28  ,
    input  signed [LENGTH-1:0] in_29  ,
    input  signed [LENGTH-1:0] in_30  ,
    input  signed [LENGTH-1:0] in_31  ,
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
    wire   signed [LENGTH-1:0] wire_16 ;
    wire   signed [LENGTH-1:0] wire_17 ;
    wire   signed [LENGTH-1:0] wire_18 ;
    wire   signed [LENGTH-1:0] wire_19 ;
    wire   signed [LENGTH-1:0] wire_20 ;
    wire   signed [LENGTH-1:0] wire_21 ;
    wire   signed [LENGTH-1:0] wire_22 ;
    wire   signed [LENGTH-1:0] wire_23 ;
    wire   signed [LENGTH-1:0] wire_24 ;
    wire   signed [LENGTH-1:0] wire_25 ;
    wire   signed [LENGTH-1:0] wire_26;
    wire   signed [LENGTH-1:0] wire_27;
    wire   signed [LENGTH-1:0] wire_28;
    wire   signed [LENGTH-1:0] wire_29;
    wire   signed [LENGTH-1:0] wire_30;
    wire   signed [LENGTH-1:0] wire_31;
    
    // the wire corresponding to the switch number has the value of the same input
    // the other wires are 0
    assign wire_0  = {LENGTH{(switch == 5'b00000)}} & in_0 ;
    assign wire_1  = {LENGTH{(switch == 5'b00001)}} & in_1 ;
    assign wire_2  = {LENGTH{(switch == 5'b00010)}} & in_2 ;
    assign wire_3  = {LENGTH{(switch == 5'b00011)}} & in_3 ;
    assign wire_4  = {LENGTH{(switch == 5'b00100)}} & in_4 ;
    assign wire_5  = {LENGTH{(switch == 5'b00101)}} & in_5 ;
    assign wire_6  = {LENGTH{(switch == 5'b00110)}} & in_6 ;
    assign wire_7  = {LENGTH{(switch == 5'b00111)}} & in_7 ;
    assign wire_8  = {LENGTH{(switch == 5'b01000)}} & in_8 ;
    assign wire_9  = {LENGTH{(switch == 5'b01001)}} & in_9 ;
    assign wire_10 = {LENGTH{(switch == 5'b01010)}} & in_10;
    assign wire_11 = {LENGTH{(switch == 5'b01011)}} & in_11;
    assign wire_12 = {LENGTH{(switch == 5'b01100)}} & in_12;
    assign wire_13 = {LENGTH{(switch == 5'b01101)}} & in_13;
    assign wire_14 = {LENGTH{(switch == 5'b01110)}} & in_14;
    assign wire_15 = {LENGTH{(switch == 5'b01111)}} & in_15;
    assign wire_16  = {LENGTH{(switch == 5'b10000)}} & in_16 ;
    assign wire_17  = {LENGTH{(switch == 5'b10001)}} & in_17 ;
    assign wire_18  = {LENGTH{(switch == 5'b10010)}} & in_18 ;
    assign wire_19  = {LENGTH{(switch == 5'b10011)}} & in_19 ;
    assign wire_20  = {LENGTH{(switch == 5'b10100)}} & in_20 ;
    assign wire_21  = {LENGTH{(switch == 5'b10101)}} & in_21 ;
    assign wire_22  = {LENGTH{(switch == 5'b10110)}} & in_22 ;
    assign wire_23  = {LENGTH{(switch == 5'b10111)}} & in_23 ;
    assign wire_24  = {LENGTH{(switch == 5'b11000)}} & in_24 ;
    assign wire_25  = {LENGTH{(switch == 5'b11001)}} & in_25 ;
    assign wire_26 = {LENGTH{(switch == 5'b11010)}} & in_26;
    assign wire_27 = {LENGTH{(switch == 5'b11011)}} & in_27;
    assign wire_28 = {LENGTH{(switch == 5'b11100)}} & in_28;
    assign wire_29 = {LENGTH{(switch == 5'b11101)}} & in_29;
    assign wire_30 = {LENGTH{(switch == 5'b11110)}} & in_30;
    assign wire_31 = {LENGTH{(switch == 5'b11111)}} & in_31;
    
    // output has just the input corresponding to the switch number
    assign out = wire_0  | wire_1  | wire_2  | wire_3  |
                 wire_4  | wire_5  | wire_6  | wire_7  |
                 wire_8  | wire_9  | wire_10 | wire_11 |
                 wire_12 | wire_13 | wire_14 | wire_15 |
                 wire_16  | wire_17  | wire_18  | wire_19  |
                 wire_20  | wire_21  | wire_22  | wire_23  |
                 wire_24  | wire_25  | wire_26 | wire_27 |
                 wire_28 | wire_29 | wire_30 | wire_31 ; ;    
    
endmodule