--Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2014.4 (win64) Build 1071353 Tue Nov 18 18:29:27 MST 2014
--Date        : Wed Jun 03 23:52:32 2015
--Host        : ENG-4933 running 64-bit Service Pack 1  (build 7601)
--Command     : generate_target mb_system_wrapper.bd
--Design      : mb_system_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity mb_system_wrapper is
  port (
    clk_in : in STD_LOGIC;
    ext_reset_in : in STD_LOGIC;
    led_out_tri_o : out STD_LOGIC_VECTOR ( 15 downto 0 );
    p_buttons_tri_i : in STD_LOGIC_VECTOR ( 4 downto 0 );
    s_switches_tri_i : in STD_LOGIC_VECTOR ( 15 downto 0 );
    seg7_hex_out_tri_o : out STD_LOGIC_VECTOR ( 7 downto 0 );
    seg7_sel_out_tri_o : out STD_LOGIC_VECTOR ( 3 downto 0 );
    vga_colour_out_tri_o : out STD_LOGIC_VECTOR ( 7 downto 0 );
    vga_hs_tri_o : out STD_LOGIC_VECTOR ( 0 to 0 );
    vga_vs_tri_o : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
end mb_system_wrapper;

architecture STRUCTURE of mb_system_wrapper is
  component mb_system is
  port (
    ext_reset_in : in STD_LOGIC;
    LED_OUT_tri_o : out STD_LOGIC_VECTOR ( 15 downto 0 );
    S_SWITCHES_tri_i : in STD_LOGIC_VECTOR ( 15 downto 0 );
    P_BUTTONS_tri_i : in STD_LOGIC_VECTOR ( 4 downto 0 );
    clk_in : in STD_LOGIC;
    SEG7_HEX_OUT_tri_o : out STD_LOGIC_VECTOR ( 7 downto 0 );
    SEG7_SEL_OUT_tri_o : out STD_LOGIC_VECTOR ( 3 downto 0 );
    VGA_VS_tri_o : out STD_LOGIC_VECTOR ( 0 to 0 );
    VGA_HS_tri_o : out STD_LOGIC_VECTOR ( 0 to 0 );
    VGA_COLOUR_OUT_tri_o : out STD_LOGIC_VECTOR ( 7 downto 0 )
  );
  end component mb_system;
begin
mb_system_i: component mb_system
    port map (
      LED_OUT_tri_o(15 downto 0) => led_out_tri_o(15 downto 0),
      P_BUTTONS_tri_i(4 downto 0) => p_buttons_tri_i(4 downto 0),
      SEG7_HEX_OUT_tri_o(7 downto 0) => seg7_hex_out_tri_o(7 downto 0),
      SEG7_SEL_OUT_tri_o(3 downto 0) => seg7_sel_out_tri_o(3 downto 0),
      S_SWITCHES_tri_i(15 downto 0) => s_switches_tri_i(15 downto 0),
      VGA_COLOUR_OUT_tri_o(7 downto 0) => vga_colour_out_tri_o(7 downto 0),
      VGA_HS_tri_o(0) => vga_hs_tri_o(0),
      VGA_VS_tri_o(0) => vga_vs_tri_o(0),
      clk_in => clk_in,
      ext_reset_in => ext_reset_in
    );
end STRUCTURE;
