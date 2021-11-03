`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.06.2015 00:15:58
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module top(
    input clk_in,
    input reset_in,
    output [15:0] led_out,
    input p_btn_U_in,
    input p_btn_L_in,
    input p_btn_R_in,
    input p_btn_D_in,
    input  [15:0] s_switches_in,
    output [7:0] seg7_hex_out,
    output [3:0] seg7_sel_out,
    input uart_rxd,
    output uart_txd
    );
    
    mb_system_wrapper mb_sys_inst (
        .clk_in(clk_in),
        .ext_reset_in(~reset_in),
        .led_out_tri_o(led_out),
        .p_btn_d_tri_i(p_btn_D_in),
        .p_btn_l_tri_i(p_btn_L_in),
        .p_btn_r_tri_i(p_btn_R_in),
        .p_btn_u_tri_i(p_btn_U_in),
        .s_switches_tri_i(s_switches_in),
        .seg7_hex_out_tri_o(seg7_hex_out),
        .seg7_sel_out_tri_o(seg7_sel_out),
        .uart_rxd(uart_rxd),
        .uart_txd(uart_txd)
    );

endmodule
