`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:51:45 11/07/2025 
// Design Name: 
// Module Name:    clk_gen 
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
module clk_gen(
   input               rstn,
   input               clk,
   output              clk_frac
);
   //7分频参数、8分频参数、次数差值
	localparam            SOURCE_NUM = 373; //cycles in source clock
   localparam            DEST_NUM   = 100; //cycles in destination clock

   parameter    SOURCE_DIV = SOURCE_NUM/DEST_NUM ;
   parameter    DEST_DIV   = SOURCE_DIV + 1;
   parameter    DIFF_ACC   = SOURCE_NUM - SOURCE_DIV*DEST_NUM ;

   reg [3:0]            cnt_end_r ;  //可变分频周期
   reg [3:0]            main_cnt ;   //主计数器
   reg                  clk_frac_r ; //时钟输出，高电平周期数为1
   always @(posedge clk or negedge rstn) begin
      if (!rstn) begin
         main_cnt    <= 'b0 ;
         clk_frac_r  <= 1'b0 ;
      end
      else if (main_cnt == cnt_end_r) begin
         main_cnt    <= 'b0 ;
         clk_frac_r  <= 1'b1 ;
      end
      else begin
         main_cnt    <= main_cnt + 1'b1 ;
         clk_frac_r  <= 1'b0 ;
      end
   end
   //输出时钟
   assign       clk_frac        = clk_frac_r ;
   //差值累加器使能控制
   wire         diff_cnt_en     = main_cnt == cnt_end_r ;

   //差值累加器逻辑
   reg [7:0]            diff_cnt_r ;
   wire [7:0]           diff_cnt = diff_cnt_r >= DEST_NUM ?
                                   diff_cnt_r -DEST_NUM + DIFF_ACC :
                                   diff_cnt_r + DIFF_ACC ;                                
   always @(posedge clk or negedge rstn) begin
      if (!rstn) begin
         diff_cnt_r <= 0 ;
      end
      else if (diff_cnt_en) begin
         diff_cnt_r <= diff_cnt ;
      end
   end

   //分频周期变量的控制逻辑
   always @(posedge clk or negedge rstn) begin
      if (!rstn) begin
         cnt_end_r      <= SOURCE_DIV-1 ;
      end
      //差值累加器溢出时，修改分频周期
      else if (diff_cnt >= DEST_NUM) begin
         cnt_end_r      <= DEST_DIV-1 ;
      end
      else begin
         cnt_end_r      <= SOURCE_DIV-1 ;
      end
   end

endmodule
