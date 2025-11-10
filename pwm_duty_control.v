`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:59:25 11/10/2025 
// Design Name: 
// Module Name:    pwm_duty_control 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module pwm_duty_control(
    input           clk,            // 系统时钟：535808Hz（保证占空比精度）
    input           rst_n,          // 低电平复位
    input           pwm_raw,        // 输入：音阶/八度分频后的原始PWM（固定频率）
    input [2:0]     volume_level,   // 音量档位（0~7档，0=静音）
    output reg      pwm_out         // 输出：调整占空比后的PWM（驱动蜂鸣器）
);

// --------------------------
// 1. 占空比参数定义（无除法，工具兼容）
// 占空比=高电平时间/原始PWM周期，范围0%~50%（蜂鸣器最佳响应区间）
// 用移位和常量定义，避免除法，XST可直接综合
// --------------------------
localparam DUTY_0 = 4'd0;   // 0% 静音
localparam DUTY_1 = 4'd1;   // 12.5% 最小音量
localparam DUTY_2 = 4'd2;   // 25% 小音量
localparam DUTY_3 = 4'd3;   // 37.5% 中低音量
localparam DUTY_4 = 4'd4;   // 50% 中音量（原始PWM占空比）
localparam DUTY_5 = 4'd5;   // 62.5% 中高音量
localparam DUTY_6 = 4'd6;   // 75% 大音量
localparam DUTY_7 = 4'd7;   // 87.5% 最大音量（避免100%失真）

// 2. 按档位选择占空比（无除法，直接映射）
reg [3:0] duty_cnt_max;  // 高电平计数阈值（对应占空比）
always @(*) begin
    case(volume_level)
        3'd0: duty_cnt_max = DUTY_0;
        3'd1: duty_cnt_max = DUTY_1;
        3'd2: duty_cnt_max = DUTY_2;
        3'd3: duty_cnt_max = DUTY_3;
        3'd4: duty_cnt_max = DUTY_4;
        3'd5: duty_cnt_max = DUTY_5;
        3'd6: duty_cnt_max = DUTY_6;
        3'd7: duty_cnt_max = DUTY_7;
        default: duty_cnt_max = DUTY_4;  // 默认中音量
    endcase
end

// --------------------------
// 3. 同步原始PWM周期，生成对应占空比的PWM
// --------------------------
reg pwm_raw_prev;         // 原始PWM打拍，检测上升沿（周期起始）
reg [3:0] duty_cnt;       // 占空比计数器（0~duty_cnt_max）
wire pwm_cycle_start = (pwm_raw == 1'b1) && (pwm_raw_prev == 1'b0);  // 原始PWM上升沿（周期开始）

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        pwm_raw_prev <= 1'b0;
        duty_cnt <= 4'd0;
        pwm_out <= 1'b0;
    end else begin
        // 1. 原始PWM打拍同步
        pwm_raw_prev <= pwm_raw;

        // 2. 每个原始PWM周期开始，重置计数器
        if (pwm_cycle_start) begin
            duty_cnt <= 4'd0;
            pwm_out <= (duty_cnt_max > 4'd0) ? 1'b1 : 1'b0;  // 占空比0则直接输出低
        end else begin
            // 3. 计数器未到阈值，保持高电平；超过则拉低
            if (duty_cnt < duty_cnt_max) begin
                duty_cnt <= duty_cnt + 4'd1;
                pwm_out <= 1'b1;
            end else begin
                pwm_out <= 1'b0;
            end
        end
    end
end

endmodule
