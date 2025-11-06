`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:19:14 11/04/2025 
// Design Name: 
// Module Name:    clk_div_8hz 
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
//////////////////////////////////////////////////////////////////////////////////
// 8Hz时钟生成模块：从535808Hz分频得到8Hz
module clk_div_8hz(
    input         clk_in,    // 输入：535808Hz时钟
    input         rst_n,     // 输入：复位（低电平有效）
    output reg    clk_out    // 输出：8Hz时钟
);
    //535808Hz / 8Hz = 66976（完整周期）→ 半周期=66976/2=33488
    localparam [16:0] DIV_HALF = 17'd33488; 
    reg [16:0] cnt; 

    always @(posedge clk_in or negedge rst_n) begin
        if (!rst_n) begin
            cnt <= 17'd0;
            clk_out <= 1'b0;
        end else if (cnt >= DIV_HALF - 1'b1) begin // 计数到半周期
            cnt <= 17'd0;
            clk_out <= ~clk_out; // 翻转输出（完成半个周期）
        end else begin
            cnt <= cnt + 17'd1;
        end
    end

endmodule
