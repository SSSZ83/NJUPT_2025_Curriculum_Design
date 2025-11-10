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
    input           clk_2m,       
    input           clk_1k,       
    
    // 矩阵键盘接口 
    input           matrix_col0,  // 第一行第一列（key1）
    input           matrix_col1,  // 第一行第二列（复位）
	 input           matrix_col2, 
    output          matrix_row0,  // 第一行驱动
    input           music_on,
    
    output          led1,         // 曲1指示
    output          led2,         // 曲2指示
    output          led3,         // 曲3指示
    output          speaker,      // 喇叭输出
    output          end_flag      // 曲尾标志
);

wire key1;               
wire sys_rst_n;          
wire [9:0] start_addr;   
wire       load_trig;    
wire       clk_535k;     
wire [2:0] volume_level;

clk_gen u_clk_gen(
    .rstn      (sys_rst_n),  
    .clk       (clk_2m),     
    .clk_frac  (clk_535k)    
);

matrix_key_control u_matrix_key(
    .clk_1k      (clk_1k),
    .ext_rst_n   (1'b1),    // 外部硬件复位未使用，接高
    .col0        (matrix_col0),
    .col1        (matrix_col1),
	 .col2        (matrix_col2),
    .row0        (matrix_row0),
    .key1        (key1),
    .sys_rst_n   (sys_rst_n),
	 .volume_level(volume_level)
);

// --------------------------
song_selector u_song_selector(
    .clk            (clk_1k),
    .rst_n          (sys_rst_n),
    .key1           (key1),
    .end_flag       (end_flag),
    .start_addr     (start_addr),
    .load_trig      (load_trig),
    .led1           (led1),
    .led2           (led2),
    .led3           (led3)
);


// --------------------------
music_player u_music_player(
    .clk_535k       (clk_535k),  
    .rst_n          (sys_rst_n),
    .start_addr     (start_addr),
    .load_trig      (load_trig),
	 .music_on       (music_on),
	 .volume_level   (volume_level), 
    .speaker        (speaker),
    .end_flag       (end_flag)
);

endmodule
