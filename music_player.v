`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:56:22 11/04/2025 
// Design Name: 
// Module Name:    music_player 
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
`timescale 1ns/1ps

module music_player(
    input         clk_535k,   // 535808Hz时钟
    input         rst_n,      // 低电平复位
    input  [9:0]  start_addr, // 首地址
    input         load_trig,  // 选曲触发
    output        speaker,    // 喇叭输出（休止符/曲尾时无声）
    output        end_flag    // 曲尾标志
);

// --------------------------
// 核心修改：休止符标志更新为8'h0C（00001100）
// --------------------------
localparam REST_MARK = 8'h0C;  // 休止符（00001100）
localparam END_MARK  = 8'hFF;  // 曲尾标志


// 内部信号定义（不变）
wire [9:0] rom_addr;
wire [7:0] rom_data;
wire [3:0] scale_sel;
wire [1:0] octave_sel;
wire       clk_8hz;
wire       scale_out;
wire       octave_out;


// 子模块实例化（不变）
clk_div_8hz clk_gen_8hz(
    .clk_in(clk_535k),
    .rst_n(rst_n),
    .clk_out(clk_8hz)
);

addr_control addr_ctrl(
    .clk_8hz(clk_8hz),
    .rst_n(rst_n),
    .start_addr(start_addr),
    .load_trig(load_trig),
    .rom_data(rom_data),
    .addr(rom_addr),
    .end_flag(end_flag)
);

music_rom rom(
    .addr(rom_addr),
    .data(rom_data)
);

scale_divider scale_div(
    .clk(clk_535k),
    .rst_n(rst_n),
    .scale_sel(scale_sel),
    .scale_out(scale_out)
);

octave_divider octave_div(
    .clk(scale_out),
    .rst_n(rst_n),
    .octave_sel(octave_sel),
    .octave_out(octave_out)
);


// --------------------------
// speaker输出逻辑（判断8'h0C）
// --------------------------
assign scale_sel = rom_data[7:4];
assign octave_sel = rom_data[1:0];
// 无声条件：曲尾（end_flag=1）或休止符（rom_data=8'h0C）
assign speaker = (end_flag == 1'b1 || rom_data == REST_MARK || rom_data == END_MARK) ? 1'b0 : octave_out;

endmodule