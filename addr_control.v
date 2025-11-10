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
// 地址控制模块
module addr_control(
    input         clk_8hz,
    input         rst_n,
    input  [9:0]  start_addr,
    input         load_trig,
    input  [7:0]  rom_data,
	 input         music_on,
    output reg [9:0] addr,
    output reg    end_flag
);

localparam END_MARK = 8'hFF;  // 曲尾标志

// 地址控制逻辑
always @(posedge clk_8hz or negedge rst_n) begin
    if (!rst_n) begin
        addr <= 10'd0;
        end_flag <= 1'b0;
    end else if (load_trig == 1'b1) begin  
        addr <= start_addr;
        end_flag <= 1'b0;
    end else if (end_flag == 1'b1) begin
	     end_flag <= 1'b0;
	 end else begin
        if (rom_data == END_MARK) begin  
            end_flag <= 1'b1;
            addr <= start_addr;
        end else if (music_on == 1'b0) begin
		      end_flag <= 1'b0;
		  end else begin  
            addr <= addr + 10'd1;
            end_flag <= 1'b0;
        end
    end
end

endmodule