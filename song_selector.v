`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:07:25 11/04/2025 
// Design Name: 
// Module Name:    song_selector 
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
module song_selector(
    input           clk,            // 50MHz时钟（仅用于状态切换边沿检测）
    input           rst_n,          // 低电平复位
    input           key1,           // 选曲按键（低电平有效，已消抖）
    input           end_flag,       // 曲尾反馈（高有效）
    output reg [9:0] start_addr,    // 首地址（随选曲状态更新）
    output reg      load_trig,      // 触发信号（按键按下时持续高）
    output reg      led1, led2, led3// 选曲指示
);

// --------------------------
// 1. 参数定义
// --------------------------
localparam SONG1_ADDR = 10'd1;    // 曲1首地址
localparam SONG2_ADDR = 10'd267;   // 曲2首地址
localparam SONG3_ADDR = 10'd50;   // 曲3首地址

reg [1:0] song_state;            // 选曲状态
localparam IDLE  = 2'd0;
localparam SONG1 = 2'd1;
localparam SONG2 = 2'd2;
localparam SONG3 = 2'd3;


// --------------------------
// 2. 仅保留按键下降沿检测（用于状态切换，防长按）
// --------------------------
reg key1_prev;                   // 仅用于状态切换的边沿检测（非触发信号）
wire key1_fall = (key1_prev == 1'b1) && (key1 == 1'b0);  // 按键下降沿

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) key1_prev <= 1'b1;  // 复位时默认按键释放
    else key1_prev <= key1;
end


// --------------------------
// 3. load_trig持续高逻辑（按键按下时=1，释放时=0）
// --------------------------
always @(*) begin
    if (!rst_n) begin
        load_trig = 1'b0;  // 复位或曲尾时，触发信号无效
    end else begin
        load_trig = ~key1;  // 按键低电平（按下）→ 触发信号高（持续）
    end
end


// --------------------------
// 4. 选曲状态切换（仅在下降沿更新，防长按跳变）
// --------------------------
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        song_state <= IDLE;
        start_addr <= 10'd0;
        {led1, led2, led3} <= 3'b000;
    end else if (key1_fall) begin
        // 仅在按键下降沿切换状态，避免长按导致连续切换
        case (song_state)
            IDLE: begin
                song_state <= SONG1;
                start_addr <= SONG1_ADDR;
                {led1, led2, led3} <= 3'b100;
            end
            SONG1: begin
                song_state <= SONG2;
                start_addr <= SONG2_ADDR;
                {led1, led2, led3} <= 3'b010;
            end
            SONG2: begin
                song_state <= SONG3;
                start_addr <= SONG3_ADDR;
                {led1, led2, led3} <= 3'b001;
            end
            SONG3: begin
                song_state <= SONG1;
                start_addr <= SONG1_ADDR;
                {led1, led2, led3} <= 3'b100;
            end
        endcase
    end
end

endmodule