`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:12:24 11/04/2025
// Design Name:   music_player
// Module Name:   C:/projects/B23020317/music_player_tb.v
// Project Name:  B23020317
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: music_player
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module music_player_tb;

// --------------------------
// 1. 测试信号定义（对应模块接口）
// --------------------------
reg         clk_535k;     // 输入：535808Hz标准时钟
reg         rst_n;        // 输入：复位信号（低电平有效）
reg  [7:0]  start_addr;   // 输入：选曲首地址（来自选曲模块）
reg         load_addr;    // 输入：加载首地址使能（高电平有效）
wire        speaker;      // 输出：喇叭驱动信号
wire        end_flag;     // 输出：歌曲结束标志（高电平有效）

// --------------------------
// 2. 层次化引用内部关键信号（用于调试观察）
// --------------------------
wire        clk_8hz;      // 内部：8Hz地址控制时钟
wire [7:0]  rom_addr;     // 内部：ROM地址
wire [7:0]  rom_data;     // 内部：ROM输出数据（音阶+八度）
wire [3:0]  scale_sel;    // 内部：12音阶选择（0-11）
wire [1:0]  octave_sel;   // 内部：八度选择（0-3）
wire        scale_out;    // 内部：12音阶分频输出
wire        octave_out;   // 内部：八度分频输出


// --------------------------
// 3. 实例化被测试模块（music_player）
// --------------------------
music_player uut (
    .clk_535k   (clk_535k),
    .rst_n      (rst_n),
    .start_addr (start_addr),
    .load_addr  (load_addr),
    .speaker    (speaker),
    .end_flag   (end_flag)
);

// 层次化引用内部信号（需与被测试模块内部信号名一致）
assign clk_8hz    = uut.clk_8hz;
assign rom_addr   = uut.rom_addr;
assign rom_data   = uut.rom_data;
assign scale_sel  = uut.scale_sel;
assign octave_sel = uut.octave_sel;
assign scale_out  = uut.scale_out;
assign octave_out = uut.octave_out;


// --------------------------
// 4. 生成535808Hz输入时钟（周期≈1.866ns）
// --------------------------
initial begin
    clk_535k = 1'b0;
    // 535808Hz = 1/1.866ns，半周期≈0.933ns，生成50%占空比方波
    forever #933 clk_535k = ~clk_535k;
end


// --------------------------
// 5. 测试激励序列（覆盖全功能场景）
// --------------------------
initial begin
    // 初始化所有输入信号
    rst_n      = 1'b0;    // 先拉低复位
    start_addr = 8'd0;    // 初始首地址设为0（曲1首地址）
    load_addr  = 1'b0;    // 初始不加载地址

    // 复位阶段：保持复位100ns（约53个clk_535k周期，确保模块完全复位）
    #500000000;
    rst_n = 1'b1;         // 释放复位，模块进入初始状态

    // 场景1：加载首地址（触发地址控制模块从start_addr=0开始）
    #2000000;                  // 等待复位释放稳定
    load_addr = 1'b1;     // 拉高加载使能
    #3732000;               // 保持2个clk_535k周期（2×1.866ns≈3.732ns）
    load_addr = 1'b0;     // 拉低加载使能，完成首地址加载

    // 场景2：等待地址按8Hz递增（8Hz周期=125ms，需等待足够长时间观察地址变化）
    // 预期：rom_addr从0→1→2→...→8（共9个地址，耗时≈8×125ms=1000ms）
    #1000000000;          // 等待1秒（覆盖8个地址递增周期）

    // 场景3：验证曲尾检测（rom_addr=8时，ROM输出8'hFF，end_flag应置高）
    #1000000000;                 // 等待曲尾信号稳定
    if (end_flag == 1'b1 && rom_addr == 8'd8) begin
        $display("[Time: %0t] 曲尾检测成功！end_flag=%b, rom_addr=%h", $time, end_flag, rom_addr);
    end else begin
        $display("[Time: %0t] 曲尾检测失败！end_flag=%b, rom_addr=%h", $time, end_flag, rom_addr);
    end

    // 场景4：重新加载首地址（模拟选曲切换，验证模块可重启）
    #500000000;           // 等待0.5秒（曲尾状态保持一段时间）
    load_addr  = 1'b1;    // 重新设置首地址为0
	 #1000
    start_addr = 8'd2;    // 拉高加载使能
    #373200000;               // 保持2个clk_535k周期
    load_addr  = 1'b0;    // 拉低加载使能

    // 场景5：验证重新加载后地址是否回到0并继续递增
    #250000000;           // 等待0.25秒（2个8Hz周期，地址应从0→1→2）
    if (rom_addr >= 8'd2 && end_flag == 1'b0) begin
        $display("[Time: %0t] 重新加载首地址成功！rom_addr=%h, end_flag=%b", $time, rom_addr, end_flag);
    end else begin
        $display("[Time: %0t] 重新加载首地址失败！rom_addr=%h, end_flag=%b", $time, rom_addr, end_flag);
    end

    // 测试结束：等待足够长时间观察最后状态，然后终止仿真
    #500000000;           // 再等待0.5秒
    $display("[Time: %0t] 所有测试场景完成！", $time);
    $finish;              // 终止仿真
end


// --------------------------
// 6. 波形查看与信号监控（调试用）
// --------------------------
initial begin
    // 实时打印关键信号状态（控制台输出，快速定位问题）
    $monitor(
        "Time: %0t | clk_8hz=%b, rom_addr=%h, rom_data=%h, scale_sel=%d, octave_sel=%d, end_flag=%b, speaker=%b",
        $time, clk_8hz, rom_addr, rom_data, scale_sel, octave_sel, end_flag, speaker
    );
end

endmodule
