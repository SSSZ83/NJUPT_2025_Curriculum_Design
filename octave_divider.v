`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:26:03 11/04/2025 
// Design Name: 
// Module Name:    octave_divider 
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
// 八度分频模块：对音阶方波进行2^n分频，调整八度
module octave_divider(
    input         clk,        // 输入：音阶分频后的方波
    input         rst_n,      // 输入：复位（低电平有效）
    input  [1:0]  octave_sel, // 输入：八度选择（0-3）
    output reg    octave_out  // 输出：八度分频方波（驱动喇叭）
);
    reg [4:0] cnt;         // 分频计数器
    reg [4:0] div_val;     // 当前八度分频系数

    // 选择八度分频系数（对应题目要求的第六~第三八度）
    always @(*) begin
        case(octave_sel)
            2'd0: div_val = 6'd16;  // 第三个八度（16分频）
            2'd1: div_val = 6'd8; // 第四个八度（8分频）
            2'd2: div_val = 6'd4; // 第五个八度（4分频）
            2'd3: div_val = 6'd2; // 第六个八度（2分频）
            default: div_val = 6'd4;
        endcase
    end

    // 生成50%占空比的八度方波
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            cnt <= 5'd0;
            octave_out <= 5'b0;
        end else begin
            if (cnt >= (div_val / 2 - 1'b1)) begin
                cnt <= 5'd0;
                octave_out <= ~octave_out;
            end else begin
                cnt <= cnt + 5'd1;
            end
        end
    end

endmodule
