`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:09:22 11/04/2025
// Design Name:   music_system_top
// Module Name:   C:/projects/B23020317/music_system_top_tb.v
// Project Name:  B23020317
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: music_system_top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_music_system();
// --------------------------
// 模块级变量声明（兼容所有Verilog版本）
// --------------------------
// 时钟与复位信号
reg           clk_535k;     // 535808Hz时钟（周期≈1.866ns）
reg           clk_1k;       // 1kHz时钟（周期1ms）
reg           matrix_col0;  // 矩阵键盘第一行第一列（key1）
reg           matrix_col1;  // 矩阵键盘第一行第二列（复位）
wire          matrix_row0;  // 矩阵键盘第一行驱动

// 系统输出信号
wire          led1, led2, led3;
wire          speaker;
wire          end_flag;

// 内部信号监控（层次化引用）
wire [7:0]    start_addr;   // 选曲首地址
wire          load_trig;    // 选曲触发
wire [7:0]    rom_addr;     // ROM当前地址
wire [7:0]    rom_data;     // ROM当前数据
wire          key1;         // 矩阵键盘输出的key1
wire          sys_rst_n;    // 系统复位信号

// 场景3专用变量（移至模块级声明，解决旧版Verilog兼容问题）
reg [7:0]     initial_addr;  // 记录初始地址
reg           speaker_prev;  // 记录speaker前值


// 实例化顶层系统
music_system_top uut (
    .clk_535k      (clk_535k),
    .clk_1k        (clk_1k),
    .matrix_col0   (matrix_col0),
    .matrix_col1   (matrix_col1),
    .matrix_row0   (matrix_row0),
    .led1          (led1),
    .led2          (led2),
    .led3          (led3),
    .speaker       (speaker),
    .end_flag      (end_flag)
);

// 层次化引用内部信号（调试用）
assign start_addr = uut.start_addr;
assign load_trig  = uut.load_trig;
assign rom_addr   = uut.u_music_player.rom_addr;
assign rom_data   = uut.u_music_player.rom_data;
assign key1       = uut.u_matrix_key.key1;
assign sys_rst_n  = uut.u_matrix_key.sys_rst_n;


// 生成时钟
initial begin
    clk_535k = 1'b0;
    forever #933 clk_535k = ~clk_535k;  // 535808Hz
end

initial begin
    clk_1k = 1'b0;
    forever #500000 clk_1k = ~clk_1k;  // 1kHz
end


// 测试激励序列（无块内变量声明，兼容所有版本）
initial begin
    // 初始化变量和输入
    matrix_col0 = 1'b1;
    matrix_col1 = 1'b1;
    initial_addr = 8'd0;    // 初始化场景3变量
    speaker_prev = 1'b0;
    #2000000;  // 等待2ms系统稳定


    // 场景1：初始状态验证
    $display("\n=== 场景1：初始状态验证 ===");
    if (led1==0 && led2==0 && led3==0 && end_flag==0 && speaker==0) begin
        $display("[场景1] 初始状态正确");
    end else begin
        $display("[场景1] 错误：LED=%b%b%b, end_flag=%b, speaker=%b", 
                 led1, led2, led3, end_flag, speaker);
    end


    // 场景2：key1选曲验证
    $display("\n=== 场景2：key1选曲验证 ===");
    matrix_col0 = 1'b0;  // 按下key1
    #10000000;           // 10ms消抖
    if (load_trig && (led1 || led2 || led3) && rom_addr == start_addr) begin
        $display("[场景2] 成功（首地址=0x%h）", start_addr);
    end else begin
        $display("[场景2] 错误：load_trig=%b, start_addr=0x%h, LED=%b%b%b", 
                 load_trig, start_addr, led1, led2, led3);
    end
    matrix_col0 = 1'b1;  // 释放key1
    #1000000;


    // 场景3：播放流程验证
    $display("\n=== 场景3：播放流程验证 ===");
    initial_addr = rom_addr;  // 记录当前地址
    speaker_prev = speaker;   // 记录当前speaker状态
    #125000000;  // 等待1个地址周期（125ms）
    if (rom_addr == initial_addr + 1'b1) begin
        $display("[场景3-地址] 成功（0x%h→0x%h）", initial_addr, rom_addr);
    end else begin
        $display("[场景3-地址] 错误（当前0x%h，预期0x%h）", rom_addr, initial_addr+1);
    end
    
    // 验证speaker电平变化
    #250000000;  // 再等2个周期（250ms）
    if (speaker != speaker_prev) begin
        $display("[场景3-发声] 成功（电平变化）");
    end else begin
        $display("[场景3-发声] 警告：电平未变（检查ROM数据）");
    end


    // 场景4：曲尾逻辑验证
    $display("\n=== 场景4：曲尾逻辑验证 ===");
    #1000000000;  // 等待1秒（覆盖播放时长）
    if (end_flag && (led1==0 && led2==0 && led3==0) && speaker==0) begin
        $display("[场景4] 成功（end_flag=1，系统复位）");
    end else begin
        $display("[场景4] 错误：end_flag=%b, LED=%b%b%b, speaker=%b", 
                 end_flag, led1, led2, led3, speaker);
    end


    // 场景5：复位键功能验证
    $display("\n=== 场景5：复位键功能验证 ===");
    // 重新选曲
    matrix_col0 = 1'b0;
    #10000000;
    matrix_col0 = 1'b1;
    #1000000;
    
    // 按下复位键
    matrix_col1 = 1'b0;
    #10000000;
    if (!sys_rst_n && (led1==0 && led2==0 && led3==0) && speaker==0) begin
        $display("[场景5-复位中] 成功");
    end else begin
        $display("[场景5-复位中] 错误：sys_rst_n=%b, LED=%b%b%b", 
                 sys_rst_n, led1, led2, led3);
    end
    
    // 释放复位键
    matrix_col1 = 1'b1;
    #2000000;
    if (sys_rst_n && (led1==0 && led2==0 && led3==0)) begin
        $display("[场景5-复位后] 成功");
    end else begin
        $display("[场景5-复位后] 错误：sys_rst_n=%b, LED=%b%b%b", 
                 sys_rst_n, led1, led2, led3);
    end


    $display("\n所有测试完成！");
    $finish;
end

endmodule