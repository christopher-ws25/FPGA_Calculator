//Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2014.4 (win64) Build 1071353 Tue Nov 18 18:29:27 MST 2014
//Date        : Sat Aug 08 17:14:45 2015
//Host        : ENG-4933 running 64-bit Service Pack 1  (build 7601)
//Command     : generate_target mb_system_wrapper.bd
//Design      : mb_system_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module mb_system_wrapper
   (clk_in,
    ext_reset_in,
    led_out_tri_o,
    p_btn_d_tri_i,
    p_btn_l_tri_i,
    p_btn_r_tri_i,
    p_btn_u_tri_i,
    s_switches_tri_i,
    seg7_hex_out_tri_o,
    seg7_sel_out_tri_o,
    uart_rxd,
    uart_txd,
    vga_colour_out_tri_o,
    vga_hs_tri_o,
    vga_region_tri_o,
    vga_vs_tri_o);
  input clk_in;
  input ext_reset_in;
  output [15:0]led_out_tri_o;
  input [0:0]p_btn_d_tri_i;
  input [0:0]p_btn_l_tri_i;
  input [0:0]p_btn_r_tri_i;
  input [0:0]p_btn_u_tri_i;
  input [15:0]s_switches_tri_i;
  output [7:0]seg7_hex_out_tri_o;
  output [3:0]seg7_sel_out_tri_o;
  input uart_rxd;
  output uart_txd;
  output [7:0]vga_colour_out_tri_o;
  output [0:0]vga_hs_tri_o;
  output [7:0]vga_region_tri_o;
  output [0:0]vga_vs_tri_o;

  wire clk_in;
  wire ext_reset_in;
  wire [15:0]led_out_tri_o;
  wire [0:0]p_btn_d_tri_i;
  wire [0:0]p_btn_l_tri_i;
  wire [0:0]p_btn_r_tri_i;
  wire [0:0]p_btn_u_tri_i;
  wire [15:0]s_switches_tri_i;
  wire [7:0]seg7_hex_out_tri_o;
  wire [3:0]seg7_sel_out_tri_o;
  wire uart_rxd;
  wire uart_txd;
  wire [7:0]vga_colour_out_tri_o;
  wire [0:0]vga_hs_tri_o;
  wire [7:0]vga_region_tri_o;
  wire [0:0]vga_vs_tri_o;

mb_system mb_system_i
       (.LED_OUT_tri_o(led_out_tri_o),
        .P_BTN_D_tri_i(p_btn_d_tri_i),
        .P_BTN_L_tri_i(p_btn_l_tri_i),
        .P_BTN_R_tri_i(p_btn_r_tri_i),
        .P_BTN_U_tri_i(p_btn_u_tri_i),
        .SEG7_HEX_OUT_tri_o(seg7_hex_out_tri_o),
        .SEG7_SEL_OUT_tri_o(seg7_sel_out_tri_o),
        .S_SWITCHES_tri_i(s_switches_tri_i),
        .VGA_COLOUR_OUT_tri_o(vga_colour_out_tri_o),
        .VGA_HS_tri_o(vga_hs_tri_o),
        .VGA_REGION_tri_o(vga_region_tri_o),
        .VGA_VS_tri_o(vga_vs_tri_o),
        .clk_in(clk_in),
        .ext_reset_in(ext_reset_in),
        .uart_rxd(uart_rxd),
        .uart_txd(uart_txd));
endmodule
