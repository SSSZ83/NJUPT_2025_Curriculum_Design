`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:06:41 11/04/2025 
// Design Name: 
// Module Name:    music_system_top 
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
module music_system_top(
    // 时钟输入
    input           clk_535k,     // 535808Hz外部时钟
    input           clk_1k,       // 1kHz外部时钟（用于按键处理）
    
    // 矩阵键盘接口（第一行的两列）
    input           matrix_col0,  // 第一行第一列（key1）
    input           matrix_col1,  // 第一行第二列（复位）
    output          matrix_row0,  // 第一行驱动
    
    // 系统输出
    output          led1,         // 曲1指示
    output          led2,         // 曲2指示
    output          led3,         // 曲3指示
    output          speaker,      // 喇叭输出
    output          end_flag      // 曲尾标志
);

// 内部信号
wire key1;               // 矩阵键盘处理后的key1
wire sys_rst_n;          // 矩阵键盘处理后的系统复位
wire [9:0] start_addr;   // 首地址
wire       load_trig;    // 选曲触发


// 实例化矩阵键盘控制模块（含key1和复位）
matrix_key_control u_matrix_key(
    .clk_1k      (clk_1k),
    .ext_rst_n   (1'b1),    // 若有外部硬件复位，可连接至此（默认高电平有效）
    .col0        (matrix_col0),
    .col1        (matrix_col1),
    .row0        (matrix_row0),
    .key1        (key1),
    .sys_rst_n   (sys_rst_n)
);


// 实例化选曲模块
song_selector u_song_selector(
    .clk            (clk_1k),
    .rst_n          (sys_rst_n),  // 使用矩阵键盘的复位信号
    .key1           (key1),       // 使用矩阵键盘的key1
    .end_flag       (end_flag),
    .start_addr     (start_addr),
    .load_trig      (load_trig),
    .led1           (led1),
    .led2           (led2),
    .led3           (led3)
);


// 实例化音乐播放模块
music_player u_music_player(
    .clk_535k       (clk_535k),
    .rst_n          (sys_rst_n),  // 统一使用矩阵键盘的复位信号
    .start_addr     (start_addr),
    .load_trig      (load_trig),
    .speaker        (speaker),
    .end_flag       (end_flag)
);

endmodule
