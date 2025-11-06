`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   08:43:41 11/05/2025
// Design Name:   matrix_key_control
// Module Name:   C:/projects/B23020317/matrix_key_control_tb.v
// Project Name:  B23020317
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: matrix_key_control
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_matrix_key_control();

// 测试信号
reg           clk_1k;       // 1kHz测试时钟
reg           ext_rst_n;    // 外部复位（模拟硬件复位）
reg           col0;         // 模拟第一行第一列按键
reg           col1;         // 模拟第一行第二列按键
wire          row0;         // 矩阵键盘第一行输出
wire          key1;         // 输出的key1信号
wire          sys_rst_n;    // 输出的系统复位信号

// 内部监控信号（通过层次化引用观察模块内部状态）
wire [3:0]    key1_cnt;     // key1消抖计数器
wire [3:0]    rst_cnt;      // 复位消抖计数器
wire          col0_sync;    // 同步后的col0信号
wire          col1_sync;    // 同步后的col1信号


// 实例化矩阵键盘控制模块
matrix_key_control uut (
    .clk_1k      (clk_1k),
    .ext_rst_n   (ext_rst_n),
    .col0        (col0),
    .col1        (col1),
    .row0        (row0),
    .key1        (key1),
    .sys_rst_n   (sys_rst_n)
);

// 层次化引用内部信号（方便调试）
assign key1_cnt = uut.key1_cnt;
assign rst_cnt = uut.rst_cnt;
assign col0_sync = uut.col0_sync;
assign col1_sync = uut.col1_sync;


// 生成1kHz时钟（周期1ms）
initial begin
    clk_1k = 1'b0;
    forever #500000 clk_1k = ~clk_1k;  // 1ms周期（1kHz）
end


// 测试激励序列
initial begin
    // 初始化
    ext_rst_n = 1'b0;    // 先触发外部复位
    col0 = 1'b1;         // 未按键时，列信号为高（模拟上拉）
    col1 = 1'b1;
    #2000000;            // 等待2ms（外部复位稳定）
    
    // 释放外部复位，进入正常工作状态
    ext_rst_n = 1'b1;
    #1000000;            // 等待1ms
    $display("=== 初始状态验证：row0应拉低，key1和sys_rst_n应为高 ===");
    if (row0 == 1'b0 && key1 == 1'b1 && sys_rst_n == 1'b1) begin
        $display("[初始状态] 验证成功\n");
    end else begin
        $display("[初始状态] 验证失败：row0=%b, key1=%b, sys_rst_n=%b\n", row0, key1, sys_rst_n);
    end


    // 场景1：单独按下key1（第一行第一列），含抖动
    $display("=== 场景1：按下key1（含抖动） ===");
    // 模拟按键抖动（3ms内高低交替）
    col0 = 1'b0; #1000000;  // 1ms低
    col0 = 1'b1; #1000000;  // 1ms高
    col0 = 1'b0; #1000000;  // 1ms低
    // 稳定按下（持续15ms，超过10ms消抖时间）
    col0 = 1'b0; #15000000;
    $display("场景1：稳定按下后，key1应变为低，计数器=10");
    if (key1 == 1'b0 && key1_cnt == 4'd10) begin
        $display("[场景1-按下] 验证成功");
    end else begin
        $display("[场景1-按下] 验证失败：key1=%b, key1_cnt=%d", key1, key1_cnt);
    end
    
    // 释放key1
    col0 = 1'b1; #5000000;  // 5ms高
    $display("场景1：释放后，key1应恢复高，计数器=0");
    if (key1 == 1'b1 && key1_cnt == 4'd0) begin
        $display("[场景1-释放] 验证成功\n");
    end else begin
        $display("[场景1-释放] 验证失败：key1=%b, key1_cnt=%d\n", key1, key1_cnt);
    end


    // 场景2：单独按下复位键（第一行第二列），含抖动
    $display("=== 场景2：按下复位键（含抖动） ===");
    // 模拟按键抖动（2ms内高低交替）
    col1 = 1'b0; #1000000;  // 1ms低
    col1 = 1'b1; #1000000;  // 1ms高
    // 稳定按下（持续12ms，超过10ms消抖时间）
    col1 = 1'b0; #12000000;
    $display("场景2：稳定按下后，sys_rst_n应变为低，计数器=10");
    if (sys_rst_n == 1'b0 && rst_cnt == 4'd10) begin
        $display("[场景2-按下] 验证成功");
    end else begin
        $display("[场景2-按下] 验证失败：sys_rst_n=%b, rst_cnt=%d", sys_rst_n, rst_cnt);
    end
    
    // 释放复位键
    col1 = 1'b1; #5000000;  // 5ms高
    $display("场景2：释放后，sys_rst_n应恢复高，计数器=0");
    if (sys_rst_n == 1'b1 && rst_cnt == 4'd0) begin
        $display("[场景2-释放] 验证成功\n");
    end else begin
        $display("[场景2-释放] 验证失败：sys_rst_n=%b, rst_cnt=%d\n", sys_rst_n, rst_cnt);
    end


    // 场景3：同时按下key1和复位键（验证独立性）
    $display("=== 场景3：同时按下key1和复位键 ===");
    col0 = 1'b0;  // 按下key1
    col1 = 1'b0;  // 按下复位键
    #15000000;    // 持续15ms（均超过消抖时间）
    $display("场景3：同时按下后，key1=低，sys_rst_n=低");
    if (key1 == 1'b0 && sys_rst_n == 1'b0) begin
        $display("[场景3-同时按下] 验证成功");
    end else begin
        $display("[场景3-同时按下] 验证失败：key1=%b, sys_rst_n=%b", key1, sys_rst_n);
    end
    
    // 同时释放
    col0 = 1'b1;
    col1 = 1'b1;
    #5000000;     // 5ms高
    $display("场景3：同时释放后，key1=高，sys_rst_n=高");
    if (key1 == 1'b1 && sys_rst_n == 1'b1) begin
        $display("[场景3-同时释放] 验证成功\n");
    end else begin
        $display("[场景3-同时释放] 验证失败：key1=%b, sys_rst_n=%b\n", key1, sys_rst_n);
    end


    // 场景4：外部复位优先级测试
    $display("=== 场景4：外部复位优先级验证 ===");
    ext_rst_n = 1'b0;  // 触发外部复位
    #2000000;          // 2ms
    $display("场景4：外部复位时，sys_rst_n应强制为低，row0=高");
    if (sys_rst_n == 1'b0 && row0 == 1'b1) begin
        $display("[场景4-外部复位] 验证成功");
    end else begin
        $display("[场景4-外部复位] 验证失败：sys_rst_n=%b, row0=%b", sys_rst_n, row0);
    end
    
    // 释放外部复位
    ext_rst_n = 1'b1;
    #2000000;
    $display("场景4：释放外部复位后，系统恢复正常");
    if (sys_rst_n == 1'b1 && row0 == 1'b0) begin
        $display("[场景4-恢复] 验证成功\n");
    end else begin
        $display("[场景4-恢复] 验证失败：sys_rst_n=%b, row0=%b\n", sys_rst_n, row0);
    end


    // 测试结束
    $display("所有测试场景完成！");
    $finish;
end

endmodule

