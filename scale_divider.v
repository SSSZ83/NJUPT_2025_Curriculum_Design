`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:25:00 11/04/2025 
// Design Name: 
// Module Name:    scale_divider 
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
// 12音阶分频模块：对535808Hz按指定系数分频，生成对应音阶频率
module scale_divider(
    input         clk,        // 输入：535808Hz时钟
    input         rst_n,      // 输入：复位（低电平有效）
    input  [3:0]  scale_sel,  // 输入：音阶选择（0-11）
    output reg    scale_out   // 输出：音阶分频方波
);
    reg [15:0] div_table[0:11]; // 12音阶分频系数表
    reg [15:0] div_val;         // 当前选中的分频系数
    reg [15:0] cnt;             // 分频计数器

    // 初始化12音阶分频系数（256,242,...137）
    initial begin
        div_table[0]  = 16'd256;
        div_table[1]  = 16'd242;
        div_table[2]  = 16'd228;
        div_table[3]  = 16'd215;
        div_table[4]  = 16'd203;
        div_table[5]  = 16'd196;
        div_table[6]  = 16'd181;
        div_table[7]  = 16'd171;
        div_table[8]  = 16'd161;
        div_table[9]  = 16'd152;
        div_table[10] = 16'd144;
        div_table[11] = 16'd137;
    end

    // 选择当前音阶的分频系数
	always @(scale_sel) begin  
		 if (scale_sel >= 4'd0 && scale_sel <= 4'd11) begin
			  div_val = div_table[scale_sel];
		 end else begin
			  div_val = 16'd256; // 无效选择默认256分频
		 end
	end

    // 生成50%占空比的音阶方波
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            cnt <= 16'd0;
            scale_out <= 1'b0;
        end else begin
            if (cnt >= (div_val / 2 - 1'b1)) begin
                cnt <= 16'd0;
                scale_out <= ~scale_out;
            end else begin
                cnt <= cnt + 16'd1;
            end
        end
    end

endmodule
