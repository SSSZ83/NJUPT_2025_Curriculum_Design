`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:30:07 11/04/2025
// Design Name:   song_selector
// Module Name:   C:/projects/B23020317/song_selector_tb.v
// Project Name:  B23020317
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: song_selector
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module song_selector_tb;

// --------------------------
// 测试信号定义（对应模块接口）
// --------------------------
reg         clk;            // 系统时钟（50MHz）
reg         rst_n;          // 复位信号（低电平有效）
reg         key1;           // 选曲按键（低电平有效，已消抖）
reg         song_end;       // 歌曲结束信号（高电平有效）
wire        led1;           // 曲1指示LED
wire        led2;           // 曲2指示LED
wire        led3;           // 曲3指示LED
wire [1:0]  song_out;       // 选曲结果输出
wire [7:0]  song_addr;      // 歌曲首地址输出


// --------------------------
// 实例化被测试模块
// --------------------------
song_selector uut (
    .clk        (clk),
    .rst_n      (rst_n),
    .key1       (key1),
    .song_end   (song_end),
    .led1       (led1),
    .led2       (led2),
    .led3       (led3),
    .song_out   (song_out),
    .song_addr  (song_addr)
);


// --------------------------
// 生成时钟信号（50MHz，周期20ns）
// --------------------------
initial begin
    clk = 1'b0;
    forever #10 clk = ~clk;  // 每10ns翻转一次，周期20ns
end


// --------------------------
// 测试激励序列 + 仿真执行命令
// --------------------------
initial begin
    // 初始化输入信号
    rst_n = 1'b0;    // 先复位
    key1 = 1'b1;     // 按键默认释放（高电平）
    song_end = 1'b0; // 初始无结束信号

    // 复位过程（持续100ns，5个时钟周期）
    #100;
    rst_n = 1'b1;    // 释放复位

    // 测试场景1：初始状态验证
    #20;  

    // 测试场景2：第一次按key1（等待→曲1）
    key1 = 1'b0;
    #40;  
    key1 = 1'b1;
    #20;  

    // 测试场景3：第二次按key1（曲1→曲2）
    key1 = 1'b0;
    #40;  
    key1 = 1'b1;
    #20;  

    // 测试场景4：第三次按key1（曲2→曲3）
    key1 = 1'b0;
    #40;  
    key1 = 1'b1;
    #20;  

    // 测试场景5：第四次按key1（曲3→曲1）
    key1 = 1'b0;
    #40;  
    key1 = 1'b1;
    #20;  

    // 测试场景6：触发歌曲结束信号
    song_end = 1'b1;  
    #20;              
    song_end = 1'b0;  
    #20;  

    // 测试场景7：结束后再次按key1
    key1 = 1'b0;
    #40;  
    key1 = 1'b1;
    #20;  

    // 执行仿真（持续足够时间覆盖所有场景）
    #100;
    $display("Test completed!");
    $finish;  
end

// --------------------------
// 信号监控（打印关键信息）
// --------------------------
initial begin
    $monitor(
        "Time: %0t, rst_n=%b, key1=%b, song_end=%b, song_out=%d, led1=%b, led2=%b, led3=%b, song_addr=%h",
        $time, rst_n, key1, song_end, song_out, led1, led2, led3, song_addr
    );
end

endmodule

