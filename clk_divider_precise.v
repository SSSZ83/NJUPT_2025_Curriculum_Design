`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:24:20 11/04/2025 
// Design Name: 
// Module Name:    clk_divider_precise 
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
module clk_divider_precise(
    input           clk_2m,       // 2MHz输入时钟（周期500ns）
    input           rst_n,        // 低电平复位
    output reg      clk_535k,     // 535808Hz输出时钟
    output reg      clk_1k        // 1kHz输出时钟
);

// --------------------------
// 535K时钟生成（直接频率控制）
// 目标：2,000,000 / 535,808 ≈ 每3.732个周期输出一个完整时钟
// --------------------------
reg [19:0] phase_acc;  // 相位累加器
localparam PHASE_INC = 20'd535808;  // 每次累加的量

always @(posedge clk_2m or negedge rst_n) begin
    if (!rst_n) begin
        phase_acc <= 20'd0;
        clk_535k <= 1'b0;
    end else begin
        phase_acc <= phase_acc + PHASE_INC;
        
        // 当相位累加器溢出时翻转时钟
        if (phase_acc >= 20'd2000000) begin
            phase_acc <= phase_acc - 20'd2000000;
            clk_535k <= ~clk_535k;
        end
    end
end

// --------------------------
// 3. 1kHz时钟生成（精确无误差）
// --------------------------
reg [10:0] cnt_1k;

always @(posedge clk_2m or negedge rst_n) begin
    if (!rst_n) begin
        cnt_1k <= 11'd0;
        clk_1k <= 1'b0;
    end else begin
        // 2MHz / 1000 = 2000 → 每1000个输入周期翻转一次（占空比50%）
        if (cnt_1k >= 11'd999) begin
            cnt_1k <= 11'd0;
            clk_1k <= ~clk_1k;
        end else begin
            cnt_1k <= cnt_1k + 1'b1;
        end
    end
end

endmodule