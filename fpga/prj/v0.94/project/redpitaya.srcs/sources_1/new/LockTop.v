`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Top-level module for the lock project
// Author: Travis Casey
//////////////////////////////////////////////////////////////////////////////////


module LockTop(
    input clk,
    // Inputs from ADC
    input  signed [14-1:0] adc_1,
    input  signed [14-1:0] adc_2,
    // Outputs to DAC
    output signed [14-1:0] dac_1,
    output signed [14-1:0] dac_2, 
    // Bus signals
    input         [32-1:0] sys_addr,
    input         [32-1:0] sys_wdata,
    input                  sys_wen,
    input                  sys_ren,
    output reg    [32-1:0] sys_rdata,
    output reg             sys_err,
    output reg             sys_ack
); 
    
// Parameter Definitions
    
localparam PID_GAIN_LENGTH = 20;
    
    
// Signal Definitions

reg rstn;
wire signed [14-1:0] out_1;
wire signed [14-1:0] out_2;

reg calib_in_1_ena;
reg signed [14-1:0] calib_in_1_offset;
reg signed [16-1:0] calib_in_1_gain;
wire signed [14-1:0] calib_in_1_data;

reg calib_in_2_ena;
reg signed [14-1:0] calib_in_2_offset;
reg signed [16-1:0] calib_in_2_gain;
wire signed [14-1:0] calib_in_2_data;

reg calib_out_1_ena;
reg signed [14-1:0] calib_out_1_offset;
reg signed [16-1:0] calib_out_1_gain;
wire signed [14-1:0] calib_out_1_data;

reg calib_out_2_ena;
reg signed [14-1:0] calib_out_2_offset;
reg signed [16-1:0] calib_out_2_gain;
wire signed [14-1:0] calib_out_2_data;

wire signed [14-1:0] in_sum;
wire signed [14-1:0] in_subtract_12;
wire signed [14-1:0] in_subtract_21;
wire signed [14-1:0] in_invert_1;
wire signed [14-1:0] in_invert_2;

reg signed [16-1:0] period_lo_1;
reg signed [12-1:0] phase_lo_1;
reg signed [13-1:0] amplitude_lo_1;
wire signed [14-1:0] sin_lo_1;

reg signed [16-1:0] period_lo_2;
reg signed [12-1:0] phase_lo_2;
reg signed [13-1:0] amplitude_lo_2;
wire signed [14-1:0] sin_lo_2;

reg signed [16-1:0] period_hi_1;
reg signed [7-1:0] phase_hi_1;
reg signed [13-1:0] amplitude_hi_1;
wire signed [14-1:0] sin_hi_1;

reg signed [16-1:0] period_hi_2;
reg signed [7-1:0] phase_hi_2;
reg signed [13-1:0] amplitude_hi_2;
wire signed [14-1:0] sin_hi_2;

reg signed [16-1:0] period_ramp;
reg signed [13-1:0] amplitude_ramp;
wire signed [14-1:0] ramp_out;

wire signed [14-1:0] lia_in;
wire signed [14-1:0] lia_ref;
reg [5-1:0] lia_shift;
reg signed [20-1:0] lia_scale;
wire signed [14-1:0] lia_out;

wire signed [14-1:0] pid_in;
wire signed [14-1:0] pid_out;
wire signed [14-1:0] pid_error;
wire signed [14-1:0] pid_set_point;
reg signed [PID_GAIN_LENGTH-1:0] pid_p_gain;
reg signed [PID_GAIN_LENGTH-1:0] pid_i_gain;
reg signed [PID_GAIN_LENGTH-1:0] pid_d_gain;
reg signed [14-1:0] pid_output_max;
reg signed [14-1:0] pid_output_min;

wire signed [14-1:0] op1_in_1;
wire signed [14-1:0] op1_in_2;
wire signed [14-1:0] op1_sum;
wire signed [14-1:0] op1_subtract_12;
wire signed [14-1:0] op1_subtract_21;
wire signed [14-1:0] op1_invert_1;
wire signed [14-1:0] op1_invert_2;
wire signed [14-1:0] op1_out;

wire signed [14-1:0] op2_in_1;
wire signed [14-1:0] op2_in_2;
wire signed [14-1:0] op2_sum;
wire signed [14-1:0] op2_subtract_12;
wire signed [14-1:0] op2_subtract_21;
wire signed [14-1:0] op2_invert_1;
wire signed [14-1:0] op2_invert_2;
wire signed [14-1:0] op2_out;

reg clamp_ena_1;
reg signed [14-1:0] clamp_max_1;
reg signed [14-1:0] clamp_min_1;

reg clamp_ena_2;
reg signed [14-1:0] clamp_max_2;
reg signed [14-1:0] clamp_min_2;

reg [4-1:0] switch_lia_in;
reg [4-1:0] switch_lia_ref;
reg [4-1:0] switch_pid_in;
reg [4-1:0] switch_pid_set_point;
reg [4-1:0] switch_op1_in_1;
reg [4-1:0] switch_op1_in_2;
reg [4-1:0] switch_op2_in_1;
reg [4-1:0] switch_op2_in_2;
reg [4-1:0] switch_op1_out;
reg [4-1:0] switch_op2_out;
reg [5-1:0] switch_out_1;
reg [5-1:0] switch_out_2;

reg signed [14-1:0] bus_pid_set_point;
reg signed [14-1:0] bus_out_1;
reg signed [14-1:0] bus_out_2;


// System Bus Signals

always @(posedge clk)
begin
    if (sys_wen) begin
        if (sys_addr[19:0] == 20'h00000)    rstn <= sys_wdata[0];
        if (sys_addr[19:0] == 20'h00004)    calib_in_1_ena <= sys_wdata[0];
        if (sys_addr[19:0] == 20'h00008)    calib_in_1_offset <= sys_wdata[14-1:0];
        if (sys_addr[19:0] == 20'h0000C)    calib_in_1_gain <= sys_wdata[16-1:0];
        if (sys_addr[19:0] == 20'h00010)    calib_in_2_ena <= sys_wdata[0];
        if (sys_addr[19:0] == 20'h00014)    calib_in_2_offset <= sys_wdata[14-1:0];
        if (sys_addr[19:0] == 20'h00018)    calib_in_2_gain <= sys_wdata[16-1:0];
        if (sys_addr[19:0] == 20'h0001C)    calib_out_1_ena <= sys_wdata[0];
        if (sys_addr[19:0] == 20'h00020)    calib_out_1_offset <= sys_wdata[14-1:0];
        if (sys_addr[19:0] == 20'h00024)    calib_out_1_gain <= sys_wdata[16-1:0];
        if (sys_addr[19:0] == 20'h00028)    calib_out_2_ena <= sys_wdata[0];
        if (sys_addr[19:0] == 20'h0002C)    calib_out_2_offset <= sys_wdata[14-1:0];
        if (sys_addr[19:0] == 20'h00030)    calib_out_2_gain <= sys_wdata[16-1:0];
        if (sys_addr[19:0] == 20'h00034)    period_lo_1 <= sys_wdata[16-1:0];
        if (sys_addr[19:0] == 20'h00038)    phase_lo_1 <= sys_wdata[12-1:0];
        if (sys_addr[19:0] == 20'h0003C)    amplitude_lo_1 <= sys_wdata[13-1:0];
        if (sys_addr[19:0] == 20'h00040)    period_lo_2 <= sys_wdata[16-1:0];
        if (sys_addr[19:0] == 20'h00044)    phase_lo_2 <= sys_wdata[12-1:0];
        if (sys_addr[19:0] == 20'h00048)    amplitude_lo_2 <= sys_wdata[13-1:0];
        if (sys_addr[19:0] == 20'h0004C)    period_hi_1 <= sys_wdata[16-1:0];
        if (sys_addr[19:0] == 20'h00050)    phase_hi_1 <= sys_wdata[7-1:0];
        if (sys_addr[19:0] == 20'h00054)    amplitude_hi_1 <= sys_wdata[13-1:0];
        if (sys_addr[19:0] == 20'h00058)    period_hi_2 <= sys_wdata[16-1:0];
        if (sys_addr[19:0] == 20'h0005C)    phase_hi_2 <= sys_wdata[7-1:0];
        if (sys_addr[19:0] == 20'h00060)    amplitude_hi_2 <= sys_wdata[13-1:0];
        if (sys_addr[19:0] == 20'h00064)    period_ramp <= sys_wdata[16-1:0];
        if (sys_addr[19:0] == 20'h00068)    amplitude_ramp <= sys_wdata[13-1:0];
        if (sys_addr[19:0] == 20'h0006C)    lia_shift <= sys_wdata[5-1:0];
        if (sys_addr[19:0] == 20'h00070)    lia_scale <= sys_wdata[20-1:0];
        if (sys_addr[19:0] == 20'h00074)    pid_p_gain <= sys_wdata[PID_GAIN_LENGTH-1:0];
        if (sys_addr[19:0] == 20'h00078)    pid_i_gain <= sys_wdata[PID_GAIN_LENGTH-1:0];
        if (sys_addr[19:0] == 20'h0007C)    pid_d_gain <= sys_wdata[PID_GAIN_LENGTH-1:0];
        if (sys_addr[19:0] == 20'h00080)    pid_output_max <= sys_wdata[14-1:0];
        if (sys_addr[19:0] == 20'h00084)    pid_output_min <= sys_wdata[14-1:0];
        if (sys_addr[19:0] == 20'h00088)    clamp_ena_1 <= sys_wdata[0];
        if (sys_addr[19:0] == 20'h0008C)    clamp_max_1 <= sys_wdata[14-1:0];
        if (sys_addr[19:0] == 20'h00090)    clamp_min_1 <= sys_wdata[14-1:0];
        if (sys_addr[19:0] == 20'h00094)    clamp_ena_2 <= sys_wdata[0];
        if (sys_addr[19:0] == 20'h00098)    clamp_max_2 <= sys_wdata[14-1:0];
        if (sys_addr[19:0] == 20'h0009C)    clamp_min_2 <= sys_wdata[14-1:0];
        if (sys_addr[19:0] == 20'h000A0)    switch_lia_in <= sys_wdata[4-1:0];
        if (sys_addr[19:0] == 20'h000A4)    switch_lia_ref <= sys_wdata[4-1:0];
        if (sys_addr[19:0] == 20'h000A8)    switch_pid_in <= sys_wdata[4-1:0];
        if (sys_addr[19:0] == 20'h000AC)    switch_pid_set_point <= sys_wdata[4-1:0];
        if (sys_addr[19:0] == 20'h000B0)    switch_op1_in_1 <= sys_wdata[4-1:0];
        if (sys_addr[19:0] == 20'h000B4)    switch_op1_in_2 <= sys_wdata[4-1:0];
        if (sys_addr[19:0] == 20'h000B8)    switch_op2_in_1 <= sys_wdata[4-1:0];
        if (sys_addr[19:0] == 20'h000BC)    switch_op2_in_2 <= sys_wdata[4-1:0];
        if (sys_addr[19:0] == 20'h000C0)    switch_op1_out <= sys_wdata[4-1:0];
        if (sys_addr[19:0] == 20'h000C4)    switch_op2_out <= sys_wdata[4-1:0];
        if (sys_addr[19:0] == 20'h000C8)    switch_out_1 <= sys_wdata[5-1:0];
        if (sys_addr[19:0] == 20'h000CC)    switch_out_2 <= sys_wdata[5-1:0];
        if (sys_addr[19:0] == 20'h000D0)    bus_pid_set_point <= sys_wdata[14-1:0];
        if (sys_addr[19:0] == 20'h000D4)    bus_out_1 <= sys_wdata[14-1:0];
        if (sys_addr[19:0] == 20'h000D8)    bus_out_2 <= sys_wdata[14-1:0];        
    end
end    
        
wire sys_en;
assign sys_en = sys_wen | sys_ren;

always @(posedge clk)
begin
    sys_err = 1'b0; 
    casez (sys_addr[19:0])
        20'h00000 : begin sys_ack <= sys_en;  sys_rdata <= {{32-1               {1'b0}},                rstn}; end
        20'h00004 : begin sys_ack <= sys_en;  sys_rdata <= {{32-1               {1'b0}},      calib_in_1_ena}; end
        20'h00008 : begin sys_ack <= sys_en;  sys_rdata <= {{32-14              {1'b0}},   calib_in_1_offset}; end
        20'h0000C : begin sys_ack <= sys_en;  sys_rdata <= {{32-16              {1'b0}},     calib_in_1_gain}; end
        20'h00010 : begin sys_ack <= sys_en;  sys_rdata <= {{32-1               {1'b0}},      calib_in_2_ena}; end
        20'h00014 : begin sys_ack <= sys_en;  sys_rdata <= {{32-14              {1'b0}},   calib_in_2_offset}; end
        20'h00018 : begin sys_ack <= sys_en;  sys_rdata <= {{32-16              {1'b0}},     calib_in_2_gain}; end
        20'h0001C : begin sys_ack <= sys_en;  sys_rdata <= {{32-1               {1'b0}},     calib_out_1_ena}; end
        20'h00020 : begin sys_ack <= sys_en;  sys_rdata <= {{32-14              {1'b0}},  calib_out_1_offset}; end
        20'h00024 : begin sys_ack <= sys_en;  sys_rdata <= {{32-16              {1'b0}},    calib_out_1_gain}; end
        20'h00028 : begin sys_ack <= sys_en;  sys_rdata <= {{32-1               {1'b0}},     calib_out_2_ena}; end
        20'h0002C : begin sys_ack <= sys_en;  sys_rdata <= {{32-14              {1'b0}},  calib_out_2_offset}; end
        20'h00030 : begin sys_ack <= sys_en;  sys_rdata <= {{32-16              {1'b0}},    calib_out_2_gain}; end
        20'h00034 : begin sys_ack <= sys_en;  sys_rdata <= {{32-16              {1'b0}},         period_lo_1}; end
        20'h00038 : begin sys_ack <= sys_en;  sys_rdata <= {{32-12              {1'b0}},          phase_lo_1}; end
        20'h0003C : begin sys_ack <= sys_en;  sys_rdata <= {{32-13              {1'b0}},      amplitude_lo_1}; end
        20'h00040 : begin sys_ack <= sys_en;  sys_rdata <= {{32-16              {1'b0}},         period_lo_2}; end
        20'h00044 : begin sys_ack <= sys_en;  sys_rdata <= {{32-12              {1'b0}},          phase_lo_2}; end
        20'h00048 : begin sys_ack <= sys_en;  sys_rdata <= {{32-13              {1'b0}},      amplitude_lo_2}; end
        20'h0004C : begin sys_ack <= sys_en;  sys_rdata <= {{32-16              {1'b0}},         period_hi_1}; end
        20'h00050 : begin sys_ack <= sys_en;  sys_rdata <= {{32-7               {1'b0}},          phase_hi_1}; end
        20'h00054 : begin sys_ack <= sys_en;  sys_rdata <= {{32-13              {1'b0}},      amplitude_hi_1}; end
        20'h00058 : begin sys_ack <= sys_en;  sys_rdata <= {{32-16              {1'b0}},         period_hi_2}; end
        20'h0005C : begin sys_ack <= sys_en;  sys_rdata <= {{32-7               {1'b0}},          phase_hi_2}; end
        20'h00060 : begin sys_ack <= sys_en;  sys_rdata <= {{32-13              {1'b0}},      amplitude_hi_2}; end
        20'h00064 : begin sys_ack <= sys_en;  sys_rdata <= {{32-16              {1'b0}},         period_ramp}; end
        20'h00068 : begin sys_ack <= sys_en;  sys_rdata <= {{32-13              {1'b0}},      amplitude_ramp}; end
        20'h0006C : begin sys_ack <= sys_en;  sys_rdata <= {{32-5               {1'b0}},           lia_shift}; end
        20'h00070 : begin sys_ack <= sys_en;  sys_rdata <= {{32-20              {1'b0}},           lia_scale}; end
        20'h00074 : begin sys_ack <= sys_en;  sys_rdata <= {{32-PID_GAIN_LENGTH {1'b0}},          pid_p_gain}; end
        20'h00078 : begin sys_ack <= sys_en;  sys_rdata <= {{32-PID_GAIN_LENGTH {1'b0}},          pid_i_gain}; end
        20'h0007C : begin sys_ack <= sys_en;  sys_rdata <= {{32-PID_GAIN_LENGTH {1'b0}},          pid_d_gain}; end
        20'h00080 : begin sys_ack <= sys_en;  sys_rdata <= {{32-14              {1'b0}},      pid_output_max}; end
        20'h00084 : begin sys_ack <= sys_en;  sys_rdata <= {{32-14              {1'b0}},      pid_output_min}; end
        20'h00088 : begin sys_ack <= sys_en;  sys_rdata <= {{32-1               {1'b0}},         clamp_ena_1}; end
        20'h0008C : begin sys_ack <= sys_en;  sys_rdata <= {{32-14              {1'b0}},         clamp_max_1}; end
        20'h00090 : begin sys_ack <= sys_en;  sys_rdata <= {{32-14              {1'b0}},         clamp_min_1}; end
        20'h00094 : begin sys_ack <= sys_en;  sys_rdata <= {{32-1               {1'b0}},         clamp_ena_2}; end
        20'h00098 : begin sys_ack <= sys_en;  sys_rdata <= {{32-14              {1'b0}},         clamp_max_2}; end
        20'h0009C : begin sys_ack <= sys_en;  sys_rdata <= {{32-14              {1'b0}},         clamp_min_2}; end
        20'h000A0 : begin sys_ack <= sys_en;  sys_rdata <= {{32-4               {1'b0}},       switch_lia_in}; end
        20'h000A4 : begin sys_ack <= sys_en;  sys_rdata <= {{32-4               {1'b0}},      switch_lia_ref}; end
        20'h000A8 : begin sys_ack <= sys_en;  sys_rdata <= {{32-4               {1'b0}},       switch_pid_in}; end
        20'h000AC : begin sys_ack <= sys_en;  sys_rdata <= {{32-4               {1'b0}},switch_pid_set_point}; end
        20'h000B0 : begin sys_ack <= sys_en;  sys_rdata <= {{32-4               {1'b0}},     switch_op1_in_1}; end
        20'h000B4 : begin sys_ack <= sys_en;  sys_rdata <= {{32-4               {1'b0}},     switch_op1_in_2}; end
        20'h000B8 : begin sys_ack <= sys_en;  sys_rdata <= {{32-4               {1'b0}},     switch_op2_in_1}; end
        20'h000BC : begin sys_ack <= sys_en;  sys_rdata <= {{32-4               {1'b0}},     switch_op2_in_2}; end
        20'h000C0 : begin sys_ack <= sys_en;  sys_rdata <= {{32-4               {1'b0}},      switch_op1_out}; end
        20'h000C4 : begin sys_ack <= sys_en;  sys_rdata <= {{32-4               {1'b0}},      switch_op1_out}; end
        20'h000C8 : begin sys_ack <= sys_en;  sys_rdata <= {{32-5               {1'b0}},        switch_out_1}; end
        20'h000CC : begin sys_ack <= sys_en;  sys_rdata <= {{32-5               {1'b0}},        switch_out_2}; end
        20'h000D0 : begin sys_ack <= sys_en;  sys_rdata <= {{32-14              {1'b0}},   bus_pid_set_point}; end
        20'h000D4 : begin sys_ack <= sys_en;  sys_rdata <= {{32-14              {1'b0}},           bus_out_1}; end
        20'h000D8 : begin sys_ack <= sys_en;  sys_rdata <= {{32-14              {1'b0}},           bus_out_2}; end
        20'h000DC : begin sys_ack <= sys_en;  sys_rdata <= {{32-14              {1'b0}},               out_1}; end
        20'h000E0 : begin sys_ack <= sys_en;  sys_rdata <= {{32-14              {1'b0}},               out_2}; end
        20'h000E4 : begin sys_ack <= sys_en;  sys_rdata <= {{32-14              {1'b0}},     calib_in_1_data}; end
        20'h000E8 : begin sys_ack <= sys_en;  sys_rdata <= {{32-14              {1'b0}},     calib_in_2_data}; end
        20'h000EC : begin sys_ack <= sys_en;  sys_rdata <= {{32-14              {1'b0}},           pid_error}; end
    endcase
end  


// Input Calibration

Calibration calib_in_1 (
    .clk     (clk              ),
    .rstn    (rstn             ),
    .ena     (calib_in_1_ena   ),
    .in      (adc_1            ),
    .offset  (calib_in_1_offset),
    .gain    (calib_in_1_gain  ),
    .out     (calib_in_1_data  )
);

Calibration calib_in_2 (
    .clk     (clk              ),
    .rstn    (rstn             ),
    .ena     (calib_in_2_ena   ),
    .in      (adc_2            ),
    .offset  (calib_in_2_offset),
    .gain    (calib_in_2_gain  ),
    .out     (calib_in_2_data  )
);


// Input Operations

Operations op_inst_in (
    .clk          (clk            ),
    .in_1         (calib_in_1_data),
    .in_2         (calib_in_2_data),
    .sum          (in_sum         ),
    .subtract_12  (in_subtract_12 ),
    .subtract_21  (in_subtract_21 ),
    .invert_1     (in_invert_1    ),
    .invert_2     (in_invert_2    )
);


// Sine Generators

FunctionGen1 gen_lo_inst_1 (
    .clk        (clk           ),
    .rstn       (rstn          ),
    .period     (period_lo_1   ),
    .phase      (phase_lo_1    ),
    .amplitude  (amplitude_lo_1),
    .sin_out    (sin_lo_1      )
);

FunctionGen1 gen_lo_inst_2 (
    .clk        (clk           ),
    .rstn       (rstn          ),
    .period     (period_lo_2   ),
    .phase      (phase_lo_2    ),
    .amplitude  (amplitude_lo_2),
    .sin_out    (sin_lo_2      )
);

FunctionGen20 gen_hi_inst_1 (
    .clk        (clk           ),
    .rstn       (rstn          ),
    .period     (period_hi_1   ),
    .phase      (phase_hi_1    ),
    .amplitude  (amplitude_hi_1),
    .sin_out    (sin_hi_1      )
);

FunctionGen20 gen_hi_inst_2 (
    .clk        (clk           ),
    .rstn       (rstn          ),
    .period     (period_hi_2   ),
    .phase      (phase_hi_2    ),
    .amplitude  (amplitude_hi_2),
    .sin_out    (sin_hi_2      )
);

Ramp ramp_inst_1 (
    .clk        (clk           ),
    .rstn       (rstn          ),
    .period     (period_ramp   ),
    .phase      (12'b0         ),
    .amplitude  (amplitude_ramp),
    .lin_out    (ramp_out      )
);


// Lock-in Amplifier

LockInAmplifier lia_inst_1 (
    .clk    (clk      ),
    .rstn   (rstn     ),
    .in     (lia_in   ),
    .ref    (lia_ref  ),
    .shift  (lia_shift),
    .scale  (lia_scale),
    .out    (lia_out  )
);


// PID Controller

PIDController #(
    .GAIN_LENGTH(PID_GAIN_LENGTH)
) pid_inst_1 (
    .clk         (clk           ),
    .rstn        (rstn          ),
    .in          (pid_in        ),
    .out         (pid_out       ),
    .error       (pid_error     ),
    .set_point   (pid_set_point ),
    .p_gain      (pid_p_gain    ),
    .i_gain      (pid_i_gain    ),
    .d_gain      (pid_d_gain    ),
    .output_max  (pid_output_max), 
    .output_min  (pid_output_min)
);


// Output Calibration

Calibration calib_out_1 (
    .clk     (clk               ),
    .rstn    (rstn              ),
    .ena     (calib_out_1_ena   ),
    .in      (out_1             ),
    .offset  (calib_out_1_offset),
    .gain    (calib_out_1_gain  ),
    .out     (calib_out_1_data  )
);

Calibration calib_out_2 (
    .clk     (clk               ),
    .rstn    (rstn              ),
    .ena     (calib_out_2_ena   ),
    .in      (out_2             ),
    .offset  (calib_out_2_offset),
    .gain    (calib_out_2_gain  ),
    .out     (calib_out_2_data  )
);


// Output Clamping

OutputClamp clamp_out_1 (
    .clk   (clk             ),
    .rstn  (rstn            ),
    .ena   (clamp_ena_1     ),
    .in    (calib_out_1_data),
    .out   (dac_1           ),
    .max   (clamp_max_1     ),
    .min   (clamp_min_1     )
);

OutputClamp clamp_out_2 (
    .clk   (clk             ),
    .rstn  (rstn            ),
    .ena   (clamp_ena_2     ),
    .in    (calib_out_2_data),
    .out   (dac_2           ),
    .max   (clamp_max_2     ),
    .min   (clamp_min_2     )
);

// Output Operations

Operations op_inst_1 (
    .clk          (clk            ),
    .in_1         (op1_in_1       ),
    .in_2         (op1_in_2       ),
    .sum          (op1_sum        ),
    .subtract_12  (op1_subtract_12),
    .subtract_21  (op1_subtract_21),
    .invert_1     (op1_invert_1   ),
    .invert_2     (op1_invert_2   )
);

Operations op_inst_2 (
    .clk          (clk            ),
    .in_1         (op2_in_1       ),
    .in_2         (op2_in_2       ),
    .sum          (op2_sum        ),
    .subtract_12  (op2_subtract_12),
    .subtract_21  (op2_subtract_21),
    .invert_1     (op2_invert_1   ),
    .invert_2     (op2_invert_2   )
);

// Multiplexers

mux_16 mux_lia_in (
    .switch   (switch_lia_in  ),
    .in_0     (14'b0          ),
    .in_1     (calib_in_1_data),
    .in_2     (calib_in_2_data),
    .in_3     (in_sum         ),
    .in_4     (in_subtract_12 ),
    .in_5     (in_subtract_21 ),
    .in_6     (in_invert_1    ),
    .in_7     (in_invert_2    ),
    .in_8     (sin_lo_1       ),
    .in_9     (sin_lo_2       ),
    .in_10    (sin_hi_1       ),
    .in_11    (sin_hi_2       ),
    .in_12    (ramp_out       ),
    .in_13    (14'b0          ),
    .in_14    (14'b0          ),
    .in_15    (14'b0          ),
    .out      (lia_in         )
);

mux_16 mux_lia_ref (
    .switch   (switch_lia_ref ),
    .in_0     (14'b0          ),
    .in_1     (calib_in_1_data),
    .in_2     (calib_in_2_data),
    .in_3     (in_sum         ),
    .in_4     (in_subtract_12 ),
    .in_5     (in_subtract_21 ),
    .in_6     (in_invert_1    ),
    .in_7     (in_invert_2    ),
    .in_8     (sin_lo_1       ),
    .in_9     (sin_lo_2       ),
    .in_10    (sin_hi_1       ),
    .in_11    (sin_hi_2       ),
    .in_12    (ramp_out       ),
    .in_13    (14'b0          ),
    .in_14    (14'b0          ),
    .in_15    (14'b0          ),
    .out      (lia_ref        )
);

mux_16 mux_pid_in (
    .switch   (switch_pid_in  ),
    .in_0     (14'b0          ),
    .in_1     (calib_in_1_data),
    .in_2     (calib_in_2_data),
    .in_3     (in_sum         ),
    .in_4     (in_subtract_12 ),
    .in_5     (in_subtract_21 ),
    .in_6     (in_invert_1    ),
    .in_7     (in_invert_2    ),
    .in_8     (lia_out        ),
    .in_9     (14'b0          ), 
    .in_10    (14'b0          ),
    .in_11    (14'b0          ),
    .in_12    (14'b0          ),
    .in_13    (14'b0          ),
    .in_14    (14'b0          ),
    .in_15    (14'b0          ),
    .out      (pid_in         )
);

mux_16 mux_pid_set_point (
    .switch   (switch_pid_set_point),
    .in_0     (14'b0               ),
    .in_1     (calib_in_1_data     ),
    .in_2     (calib_in_2_data     ),
    .in_3     (in_sum              ),
    .in_4     (in_subtract_12      ),
    .in_5     (in_subtract_21      ),
    .in_6     (in_invert_1         ),
    .in_7     (in_invert_2         ),
    .in_8     (lia_out             ),
    .in_9     (bus_pid_set_point   ), 
    .in_10    (14'b0               ),
    .in_11    (14'b0               ),
    .in_12    (14'b0               ),
    .in_13    (14'b0               ),
    .in_14    (14'b0               ),
    .in_15    (14'b0               ),
    .out      (pid_set_point       )
);

mux_16 mux_op1_in_1 (
    .switch   (switch_op1_in_1),
    .in_0     (14'b0          ),
    .in_1     (calib_in_1_data),
    .in_2     (calib_in_2_data),
    .in_3     (in_sum         ),
    .in_4     (in_subtract_12 ),
    .in_5     (in_subtract_21 ),
    .in_6     (in_invert_1    ),
    .in_7     (in_invert_2    ),
    .in_8     (sin_lo_1       ),
    .in_9     (sin_lo_2       ), 
    .in_10    (sin_hi_1       ),
    .in_11    (sin_hi_2       ),
    .in_12    (ramp_out       ),
    .in_13    (lia_out        ),
    .in_14    (pid_out        ),
    .in_15    (pid_error      ),
    .out      (op1_in_1       )
);

mux_16 mux_op1_in_2 (
    .switch   (switch_op1_in_2),
    .in_0     (14'b0          ),
    .in_1     (calib_in_1_data),
    .in_2     (calib_in_2_data),
    .in_3     (in_sum         ),
    .in_4     (in_subtract_12 ),
    .in_5     (in_subtract_21 ),
    .in_6     (in_invert_1    ),
    .in_7     (in_invert_2    ),
    .in_8     (sin_lo_1       ),
    .in_9     (sin_lo_2       ), 
    .in_10    (sin_hi_1       ),
    .in_11    (sin_hi_2       ),
    .in_12    (ramp_out       ),
    .in_13    (lia_out        ),
    .in_14    (pid_out        ),
    .in_15    (pid_error      ),
    .out      (op1_in_2       )
);

mux_16 mux_op2_in_1 (
    .switch   (switch_op2_in_1),
    .in_0     (14'b0          ),
    .in_1     (calib_in_1_data),
    .in_2     (calib_in_2_data),
    .in_3     (in_sum         ),
    .in_4     (in_subtract_12 ),
    .in_5     (in_subtract_21 ),
    .in_6     (in_invert_1    ),
    .in_7     (in_invert_2    ),
    .in_8     (sin_lo_1       ),
    .in_9     (sin_lo_2       ), 
    .in_10    (sin_hi_1       ),
    .in_11    (sin_hi_2       ),
    .in_12    (ramp_out       ),
    .in_13    (lia_out        ),
    .in_14    (pid_out        ),
    .in_15    (pid_error      ),
    .out      (op2_in_1       )
);

mux_16 mux_op2_in_2 (
    .switch   (switch_op2_in_2),
    .in_0     (14'b0          ),
    .in_1     (calib_in_1_data),
    .in_2     (calib_in_2_data),
    .in_3     (in_sum         ),
    .in_4     (in_subtract_12 ),
    .in_5     (in_subtract_21 ),
    .in_6     (in_invert_1    ),
    .in_7     (in_invert_2    ),
    .in_8     (sin_lo_1       ),
    .in_9     (sin_lo_2       ), 
    .in_10    (sin_hi_1       ),
    .in_11    (sin_hi_2       ),
    .in_12    (ramp_out       ),
    .in_13    (lia_out        ),
    .in_14    (pid_out        ),
    .in_15    (pid_error      ),
    .out      (op2_in_2       )
);

mux_16 mux_op1_out (
    .switch   (switch_op1_out ),
    .in_0     (14'b0          ),
    .in_1     (op1_sum        ),
    .in_2     (op1_subtract_12),
    .in_3     (op1_subtract_21),
    .in_4     (op1_invert_1   ),
    .in_5     (op1_invert_2   ),
    .in_6     (14'b0          ), 
    .in_7     (14'b0          ), 
    .in_8     (14'b0          ), 
    .in_9     (14'b0          ), 
    .in_10    (14'b0          ),
    .in_11    (14'b0          ),
    .in_12    (14'b0          ),
    .in_13    (14'b0          ),
    .in_14    (14'b0          ),
    .in_15    (14'b0          ),
    .out      (op1_out        )
);

mux_16 mux_op2_out (
    .switch   (switch_op2_out ),
    .in_0     (14'b0          ),
    .in_1     (op2_sum        ),
    .in_2     (op2_subtract_12),
    .in_3     (op2_subtract_21),
    .in_4     (op2_invert_1   ),
    .in_5     (op2_invert_2   ),
    .in_6     (14'b0          ), 
    .in_7     (14'b0          ), 
    .in_8     (14'b0          ), 
    .in_9     (14'b0          ), 
    .in_10    (14'b0          ),
    .in_11    (14'b0          ),
    .in_12    (14'b0          ),
    .in_13    (14'b0          ),
    .in_14    (14'b0          ),
    .in_15    (14'b0          ),
    .out      (op2_out        )
);

mux_32 mux_out_1 (
    .switch   (switch_out_1   ),
    .in_0     (14'b0          ),
    .in_1     (calib_in_1_data),
    .in_2     (calib_in_2_data),
    .in_3     (in_sum         ),
    .in_4     (in_subtract_12 ),
    .in_5     (in_subtract_21 ),
    .in_6     (in_invert_1    ),
    .in_7     (in_invert_2    ),
    .in_8     (sin_lo_1       ),
    .in_9     (sin_lo_2       ), 
    .in_10    (sin_hi_1       ),
    .in_11    (sin_hi_2       ),
    .in_12    (ramp_out       ),
    .in_13    (lia_out        ),
    .in_14    (pid_out        ),
    .in_15    (pid_error      ),
    .in_16    (bus_out_1      ),
    .in_17    (op1_out        ),
    .in_18    (op2_out        ),
    .in_19    (14'b0          ),
    .in_20    (14'b0          ),
    .in_21    (14'b0          ),
    .in_22    (14'b0          ),
    .in_23    (14'b0          ),
    .in_24    (14'b0          ),
    .in_25    (14'b0          ),
    .in_26    (14'b0          ),
    .in_27    (14'b0          ),
    .in_28    (14'b0          ),
    .in_29    (14'b0          ),
    .in_30    (14'b0          ),
    .in_31    (14'b0          ),
    .out      (out_1          )
);

mux_32 mux_out_2 (
    .switch   (switch_out_2   ),
    .in_0     (14'b0          ),
    .in_1     (calib_in_1_data),
    .in_2     (calib_in_2_data),
    .in_3     (in_sum         ),
    .in_4     (in_subtract_12 ),
    .in_5     (in_subtract_21 ),
    .in_6     (in_invert_1    ),
    .in_7     (in_invert_2    ),
    .in_8     (sin_lo_1       ),
    .in_9     (sin_lo_2       ), 
    .in_10    (sin_hi_1       ),
    .in_11    (sin_hi_2       ),
    .in_12    (ramp_out       ),
    .in_13    (lia_out        ),
    .in_14    (pid_out        ),
    .in_15    (pid_error      ),
    .in_16    (bus_out_2      ),
    .in_17    (op1_out        ),
    .in_18    (op2_out        ),
    .in_19    (14'b0          ),
    .in_20    (14'b0          ),
    .in_21    (14'b0          ),
    .in_22    (14'b0          ),
    .in_23    (14'b0          ),
    .in_24    (14'b0          ),
    .in_25    (14'b0          ),
    .in_26    (14'b0          ),
    .in_27    (14'b0          ),
    .in_28    (14'b0          ),
    .in_29    (14'b0          ),
    .in_30    (14'b0          ),
    .in_31    (14'b0          ),
    .out      (out_2          )
);



endmodule
