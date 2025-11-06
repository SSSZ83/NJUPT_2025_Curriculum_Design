`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:22:20 11/04/2025 
// Design Name: 
// Module Name:    addr_control 
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
// 地址控制模块：基于ROM数据（rom_data）判断曲尾，8Hz驱动地址递增
module addr_control(
    input         clk_8hz,
    input         rst_n,
    input  [9:0]  start_addr,
    input         load_trig,
    input  [7:0]  rom_data,
    output reg [9:0] addr,
    output reg    end_flag
);

localparam END_MARK = 8'hFF;  // 曲尾标志（仅曲尾停止地址递增）

// 地址控制逻辑（休止符不影响递增，仅曲尾生效）
always @(posedge clk_8hz or negedge rst_n) begin
    if (!rst_n) begin
        addr <= 10'd0;
        end_flag <= 1'b0;
    end else if (load_trig == 1'b1) begin  // 上升沿加载
        addr <= start_addr;
        end_flag <= 1'b0;
    end else if (end_flag == 1'b1) begin
	     end_flag <= 1'b0;
	 end else begin
        if (rom_data == END_MARK) begin  // 曲尾：停止递增
            end_flag <= 1'b1;
            addr <= start_addr;
        end else begin  // 有效音符/休止符（8'h0C）：正常递增
            addr <= addr + 10'd1;
            end_flag <= 1'b0;
        end
    end
end

// load_trig边沿检测（不变）
reg load_trig_prev;
always @(posedge clk_8hz or negedge rst_n) begin
    if (!rst_n) load_trig_prev <= 1'b0;
    else load_trig_prev <= load_trig;
end

endmodule