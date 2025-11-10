`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:36:34 11/07/2025
// Design Name:   clk_gen
// Module Name:   C:/projects/B23020317/clk_gen_tb.v
// Project Name:  B23020317
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: clk_gen
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_clk_gen;


   // 输入信号
   reg        rstn;
   reg        clk;
   
   // 输出信号
   wire       clk_frac;
   
   // 测试参数
   parameter CLK_PERIOD = 10;  // 100MHz时钟，周期10ns
   parameter SIM_TIME = 100000; // 仿真时间100us
   
   // 监测信号
   real clk_frac_period = 0;
   real last_frac_edge = 0;
   real frac_freq = 0;
   integer frac_cycle_count = 0;
   integer total_cycles = 0;
   
   // 实数变量用于计算
   real measured_ratio;
   real error_percent;
   
   // 时钟生成
   initial begin
      clk = 0;
      forever #(CLK_PERIOD/2) clk = ~clk;
   end
   
   // 实例化被测模块
   clk_gen uut (
      .rstn      (rstn),
      .clk       (clk),
      .clk_frac  (clk_frac)
   );
   
   // 复位和测试序列
   initial begin
      // 初始化
      rstn = 0;
      frac_cycle_count = 0;
      total_cycles = 0;
      
      // 应用复位
      #100;
      rstn = 1;
      #100;
      
      $display("=== 3.73分频测试开始 ===");
      $display("开始时间: %t", $time);
      
      // 运行仿真
      #(SIM_TIME);
      
      // 计算并显示结果
      measured_ratio = 1.0 * total_cycles / frac_cycle_count;
      error_percent = (measured_ratio - 3.73) / 3.73 * 100;
      
      $display("\n=== 测试结果 ===");
      $display("总输入时钟周期数: %0d", total_cycles);
      $display("输出时钟周期数: %0d", frac_cycle_count);
      $display("实测分频比: %.3f", measured_ratio);
      $display("理论分频比: 3.730");
      $display("误差: %.3f%%", error_percent);
      
      $display("\n测试完成!");
      $finish;
   end
   
   // 输入时钟周期计数
   always @(posedge clk) begin
      if (rstn) begin
         total_cycles <= total_cycles + 1;
      end
   end
   
   // 输出时钟监测
   reg clk_frac_prev = 0;
   
   always @(posedge clk) begin
      clk_frac_prev <= clk_frac;
   end
   
   // 检测输出时钟上升沿
   always @(posedge clk) begin
      if (rstn && !clk_frac_prev && clk_frac) begin
         frac_cycle_count <= frac_cycle_count + 1;
         
         // 计算输出时钟周期
         if (last_frac_edge > 0) begin
            clk_frac_period = ($time - last_frac_edge) / 1000.0; // 转换为ns
            frac_freq = 1000.0 / clk_frac_period; // MHz
         end
         last_frac_edge = $time;
         
         // 定期打印信息
         if (frac_cycle_count % 50 == 0) begin
            $display("时间: %t, 输出时钟周期: %0d, 当前周期: %.3fns, 频率: %.3fMHz", 
                     $time, frac_cycle_count, clk_frac_period, frac_freq);
         end
      end
   end
   
   // 波形转储
   initial begin
      $dumpfile("tb_clk_gen.vcd");
      $dumpvars(0, tb_clk_gen);
   end
   
   // 超时保护
   initial begin
      #(SIM_TIME + 10000);
      $display("仿真超时!");
      $finish;
   end

endmodule

