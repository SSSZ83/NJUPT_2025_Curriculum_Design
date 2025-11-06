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
    input           clk_1k,       // 1kHz扫描时钟（用于消抖）
    input           ext_rst_n,    // 外部硬件复位（可选，低有效，高电平有效时可悬空）
    input           col0,         // 第一列（key1）
    input           col1,         // 第二列（复位）
    output reg      row0,         // 第一行（固定拉低扫描）
    output reg      key1,         // 第一行第一列按键输出（低有效，已消抖）
    output reg      sys_rst_n     // 系统复位信号（低有效，按键按下时为0）
);

// --------------------------
// 1. 矩阵键盘扫描逻辑（第一行固定拉低）
// --------------------------
always @(posedge clk_1k or negedge ext_rst_n) begin
    if (!ext_rst_n) begin
        row0 <= 1'b1;  // 外部复位时不拉低行
    end else begin
        row0 <= 1'b0;  // 正常工作时，固定拉低第一行，扫描col0和col1
    end
end


// --------------------------
// 2. 信号同步（避免亚稳态，打两拍）
// --------------------------
reg col0_1, col0_2, col1_1, col1_2;
always @(posedge clk_1k or negedge ext_rst_n) begin
    if (!ext_rst_n) begin
        {col0_2, col0_1} <= 2'b11;  // 未按键时为高（上拉）
        {col1_2, col1_1} <= 2'b11;
    end else begin
        // 第一列同步
        col0_1 <= col0;
        col0_2 <= col0_1;
        // 第二列同步
        col1_1 <= col1;
        col1_2 <= col1_1;
    end
end
wire col0_sync = col0_2;  // 同步后第一列信号
wire col1_sync = col1_2;  // 同步后第二列信号


// --------------------------
// 3. key1消抖逻辑（第一行第一列）
// --------------------------
localparam DEBOUNCE_CNT = 4'd10;  // 10ms消抖（1kHz×10）
reg [3:0] key1_cnt;

always @(posedge clk_1k or negedge ext_rst_n) begin
    if (!ext_rst_n) begin
        key1_cnt <= 4'd0;
        key1 <= 1'b1;  // 初始未按下（高电平）
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
// 4. 复位按键消抖逻辑（第一行第二列）
// --------------------------
reg [3:0] rst_cnt;

always @(posedge clk_1k or negedge ext_rst_n) begin
    if (!ext_rst_n) begin
        rst_cnt <= 4'd0;
        sys_rst_n <= 1'b0;  // 外部复位优先
    end else begin
        if (col1_sync == 1'b0) begin  // 复位按键按下（列被拉低）
            if (rst_cnt >= DEBOUNCE_CNT) begin
                rst_cnt <= DEBOUNCE_CNT;
                sys_rst_n <= 1'b0;  // 稳定按下，输出低电平复位
            end else begin
                rst_cnt <= rst_cnt + 1'b1;
                sys_rst_n <= 1'b1;  // 未稳定，暂不复位
            end
        end else begin  // 复位按键释放或抖动
            rst_cnt <= 4'd0;
            sys_rst_n <= 1'b1;  // 释放，复位信号无效（高电平）
        end
    end
end

endmodule