`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:26:38 11/04/2025
// Design Name:   clk_divider_precise
// Module Name:   C:/projects/B23020317/clk_divider_precise_tb.v
// Project Name:  B23020317
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: clk_divider_precise
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module clk_divider_precise_tb;

// 测试信号
reg         clk_2m;       // 2MHz输入时钟（周期500ns）
reg         rst_n;        // 低电平复位
wire        clk_535k;     // 输出535808Hz时钟
wire        clk_1k;       // 输出1kHz时钟

// 监控信号
reg [31:0]  cnt_535k_total;  // 统计535k时钟脉冲数
reg [31:0]  cnt_1k_total;    // 统计1k时钟脉冲数
reg         clk_535k_prev;   // 边沿检测用
reg         clk_1k_prev;
reg [63:0]  test_duration;   // 测试时长（ns）


// 实例化32位分频模块
clk_divider_precise u_divider(
    .clk_2m      (clk_2m),
    .rst_n       (rst_n),
    .clk_535k    (clk_535k),
    .clk_1k      (clk_1k)
);


// 生成2MHz输入时钟（500ns周期）
initial begin
    clk_2m = 1'b0;
    forever #250 clk_2m = ~clk_2m;  // 2MHz = 1/(2×250ns)
end


// 测试激励
initial begin
    // 初始化
    rst_n = 1'b0;
    cnt_535k_total = 32'd0;
    cnt_1k_total = 32'd0;
    clk_535k_prev = 1'b0;
    clk_1k_prev = 1'b0;
    test_duration = 64'd1000000000;  // 测试1秒（足够统计高精度）
    #1000;  // 复位1us
    
    // 释放复位，开始测试
    rst_n = 1'b1;
    #test_duration;  // 运行1秒
    
    // 计算实际频率
    $display("\n=== 32位分频模块精度测试（1秒统计） ===");
    $display("clk_535k理论频率：535808 Hz");
    $display("clk_535k实际脉冲数：%d → 实际频率：%d Hz", 
             cnt_535k_total, cnt_535k_total);
    $display("clk_1k理论频率：1000 Hz");
    $display("clk_1k实际脉冲数：%d → 实际频率：%d Hz", 
             cnt_1k_total, cnt_1k_total);
    
    // 验证精度（535k误差≤0.1%，1k误差0）
    if (cnt_535k_total >= 535272 && cnt_535k_total <= 536344) begin  // 535808±0.1%
        $display("clk_535k精度验证成功");
    end else begin
        $display("clk_535k精度验证失败");
    end
    
    if (cnt_1k_total == 1000) begin  // 1秒内精确1000个脉冲
        $display("clk_1k精度验证成功（精确1kHz）");
    end else begin
        $display("clk_1k精度验证失败");
    end
    
    $finish;
end


// 统计时钟脉冲数（上升沿计数）
always @(posedge clk_2m) begin
    // 统计535k脉冲
    clk_535k_prev <= clk_535k;
    if (clk_535k && !clk_535k_prev && rst_n) begin
        cnt_535k_total <= cnt_535k_total + 1'b1;
    end
    
    // 统计1k脉冲
    clk_1k_prev <= clk_1k;
    if (clk_1k && !clk_1k_prev && rst_n) begin
        cnt_1k_total <= cnt_1k_total + 1'b1;
    end
end

endmodule

