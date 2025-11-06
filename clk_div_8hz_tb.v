`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   09:54:50 11/05/2025
// Design Name:   clk_div_8hz
// Module Name:   C:/projects/B23020317/clk_div_8hz_tb.v
// Project Name:  B23020317
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: clk_div_8hz
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module clk_div_8hz_tb;
    reg clk_in;    // 535808Hz输入
    reg rst_n;     // 复位
    wire clk_out;  // 8Hz输出

    // 实例化模块
    clk_div_8hz uut(
        .clk_in  (clk_in),
        .rst_n   (rst_n),
        .clk_out (clk_out)
    );

    // 生成535808Hz输入时钟（周期≈1.866ns）
    initial begin
        clk_in = 1'b0;
        forever #933 clk_in = ~clk_in;
    end

    // 测试激励
    initial begin
        rst_n = 1'b0;
        #1000;       // 复位1us
        rst_n = 1'b1;
        #125000000;  // 等待125ms（8Hz时钟1秒10个周期，125ms≈1个周期）
        
        // 验证频率（125ms内应观察到1次完整周期）
        $display("8Hz时钟测试完成，可通过波形查看频率是否正确（周期≈125ms）");
        $finish;
    end

endmodule

