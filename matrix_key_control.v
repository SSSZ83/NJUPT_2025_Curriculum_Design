`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:37:41 11/05/2025 
// Design Name: 
// Module Name:    matrix_key_control 
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
module matrix_key_control(
    input           clk_1k,       // 1kHz扫描时钟
    input           ext_rst_n,    // 外部硬件复位
    input           col0,         // 第一列（key1）
    input           col1,         // 第二列（复位）
	 input           col2,         // 第三列：音量+键
    output reg      row0,         // 第一行 PULL DOWM
    output reg      key1,         // 第一行第一列按键输出
    output reg      sys_rst_n,     // 系统复位信号
	 output reg [2:0] volume_level // 音量档位
);

localparam DEFAULT_VOL = 3'd4;
// --------------------------
// 1. 矩阵键盘扫描逻辑（第一行固定拉低）
// --------------------------
always @(posedge clk_1k or negedge ext_rst_n) begin
    if (!ext_rst_n) begin
        row0 <= 1'b1;  
    end else begin
        row0 <= 1'b0;  // 扫描
    end
end


// --------------------------
// 2. 信号同步）
// --------------------------
reg col0_1, col0_2;  // col0同步信号
reg col1_1, col1_2;  // col1同步信号
reg col2_1, col2_2;  // col2同步信号
always @(posedge clk_1k or negedge ext_rst_n) begin
    if (!ext_rst_n) begin
        {col0_2, col0_1} <= 2'b11;  // 未按键时为高（上拉）
        {col1_2, col1_1} <= 2'b11;
        {col2_2, col2_1} <= 2'b11;  // 新增：col2初始高
    end else begin
        col0_1 <= col0;
        col0_2 <= col0_1;
        col1_1 <= col1;
        col1_2 <= col1_1;
        col2_1 <= col2;  // 新增：col2打拍
        col2_2 <= col2_1;
    end
end
wire col0_sync = col0_2;
wire col1_sync = col1_2;
wire col2_sync = col2_2;  // 新增：同步后col2信号



// --------------------------
// 3. key1消抖逻辑
// --------------------------
localparam DEBOUNCE_CNT = 4'd10;  
reg [3:0] key1_cnt;

always @(posedge clk_1k or negedge ext_rst_n) begin
    if (!ext_rst_n) begin
        key1_cnt <= 4'd0;
        key1 <= 1'b1;  
    end else begin
        if (col0_sync == 1'b0) begin  // 检测到按键按下（列被拉低）
            if (key1_cnt >= DEBOUNCE_CNT) begin
                key1_cnt <= DEBOUNCE_CNT;
                key1 <= 1'b0;  // 稳定按下，输出低
            end else begin
                key1_cnt <= key1_cnt + 1'b1;
                key1 <= 1'b1;  // 未稳定，暂不输出
            end
        end else begin  // 按键释放或抖动
            key1_cnt <= 4'd0;
            key1 <= 1'b1;  // 输出高（未按下）
        end
    end
end


// --------------------------
// 4. 复位按键消抖逻辑
// --------------------------
reg [3:0] rst_cnt;

always @(posedge clk_1k or negedge ext_rst_n) begin
    if (!ext_rst_n) begin
        rst_cnt <= 4'd0;
        sys_rst_n <= 1'b0;  // 外部复位优先
    end else begin
        if (col1_sync == 1'b0) begin  
            if (rst_cnt >= DEBOUNCE_CNT) begin
                rst_cnt <= DEBOUNCE_CNT;
                sys_rst_n <= 1'b0;  // 稳定按下，输出低电平复位
            end else begin
                rst_cnt <= rst_cnt + 1'b1;
                sys_rst_n <= 1'b1;  
            end
        end else begin 
            rst_cnt <= 4'd0;
            sys_rst_n <= 1'b1;  
        end
    end
end

//音量
reg [3:0] vol_cnt;
reg vol_press;  // 音量键稳定按下标志（高有效）
always @(posedge clk_1k or negedge ext_rst_n) begin
    if (!ext_rst_n) begin
        vol_cnt <= 4'd0;
        vol_press <= 1'b0;
    end else begin
        if (col2_sync == 1'b0) begin  // 音量键按下（列被拉低）
            vol_cnt <= (vol_cnt >= DEBOUNCE_CNT) ? DEBOUNCE_CNT : vol_cnt + 1'b1;
            vol_press <= (vol_cnt >= DEBOUNCE_CNT) ? 1'b1 : 1'b0;  // 稳定后输出高
        end else begin  // 释放或抖动
            vol_cnt <= 4'd0;
            vol_press <= 1'b0;
        end
    end
end

// 4.2 音量档位计数（单次按下+1，0~7循环，避免长按连续加）
reg vol_press_prev;  // 存储前一状态，检测上升沿
always @(posedge clk_1k or negedge ext_rst_n) begin
    if (!ext_rst_n) begin
        volume_level <= DEFAULT_VOL;  // 复位后默认中音量
        vol_press_prev <= 1'b0;
    end else begin
        vol_press_prev <= vol_press;  // 打拍存储
        // 检测"按下→释放"的上升沿（单次按下仅触发一次）
        if (vol_press && !vol_press_prev) begin
            volume_level <= (volume_level == 3'd7) ? 3'd0 : volume_level + 3'd1;
        end
    end
end
endmodule