
################################################################
# This is a generated script based on design: mb_system
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2015.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   puts "ERROR: This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source mb_system_script.tcl

# If you do not already have a project created,
# you can create a project using the following command:
#    create_project project_1 myproj -part xc7a35tcpg236-1

# CHECKING IF PROJECT EXISTS
if { [get_projects -quiet] eq "" } {
   puts "ERROR: Please open or create a project!"
   return 1
}



# CHANGE DESIGN NAME HERE
set design_name mb_system

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "ERROR: Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      puts "INFO: Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   puts "INFO: Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   puts "INFO: Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   puts "INFO: Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

puts "INFO: Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   puts $errMsg
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: microblaze_0_local_memory
proc create_hier_cell_microblaze_0_local_memory { parentCell nameHier } {

  if { $parentCell eq "" || $nameHier eq "" } {
     puts "ERROR: create_hier_cell_microblaze_0_local_memory() - Empty argument(s)!"
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     puts "ERROR: Unable to find parent cell <$parentCell>!"
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     puts "ERROR: Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode MirroredMaster -vlnv xilinx.com:interface:lmb_rtl:1.0 DLMB
  create_bd_intf_pin -mode MirroredMaster -vlnv xilinx.com:interface:lmb_rtl:1.0 ILMB

  # Create pins
  create_bd_pin -dir I -type clk LMB_Clk
  create_bd_pin -dir I -from 0 -to 0 -type rst LMB_Rst

  # Create instance: dlmb_bram_if_cntlr, and set properties
  set dlmb_bram_if_cntlr [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 dlmb_bram_if_cntlr ]
  set_property -dict [ list CONFIG.C_ECC {0}  ] $dlmb_bram_if_cntlr

  # Create instance: dlmb_v10, and set properties
  set dlmb_v10 [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 dlmb_v10 ]

  # Create instance: ilmb_bram_if_cntlr, and set properties
  set ilmb_bram_if_cntlr [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 ilmb_bram_if_cntlr ]
  set_property -dict [ list CONFIG.C_ECC {0}  ] $ilmb_bram_if_cntlr

  # Create instance: ilmb_v10, and set properties
  set ilmb_v10 [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 ilmb_v10 ]

  # Create instance: lmb_bram, and set properties
  set lmb_bram [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.2 lmb_bram ]
  set_property -dict [ list CONFIG.Memory_Type {True_Dual_Port_RAM} CONFIG.use_bram_block {BRAM_Controller}  ] $lmb_bram

  # Create interface connections
  connect_bd_intf_net -intf_net microblaze_0_dlmb [get_bd_intf_pins DLMB] [get_bd_intf_pins dlmb_v10/LMB_M]
  connect_bd_intf_net -intf_net microblaze_0_dlmb_bus [get_bd_intf_pins dlmb_bram_if_cntlr/SLMB] [get_bd_intf_pins dlmb_v10/LMB_Sl_0]
  connect_bd_intf_net -intf_net microblaze_0_dlmb_cntlr [get_bd_intf_pins dlmb_bram_if_cntlr/BRAM_PORT] [get_bd_intf_pins lmb_bram/BRAM_PORTA]
  connect_bd_intf_net -intf_net microblaze_0_ilmb [get_bd_intf_pins ILMB] [get_bd_intf_pins ilmb_v10/LMB_M]
  connect_bd_intf_net -intf_net microblaze_0_ilmb_bus [get_bd_intf_pins ilmb_bram_if_cntlr/SLMB] [get_bd_intf_pins ilmb_v10/LMB_Sl_0]
  connect_bd_intf_net -intf_net microblaze_0_ilmb_cntlr [get_bd_intf_pins ilmb_bram_if_cntlr/BRAM_PORT] [get_bd_intf_pins lmb_bram/BRAM_PORTB]

  # Create port connections
  connect_bd_net -net microblaze_0_Clk [get_bd_pins LMB_Clk] [get_bd_pins dlmb_bram_if_cntlr/LMB_Clk] [get_bd_pins dlmb_v10/LMB_Clk] [get_bd_pins ilmb_bram_if_cntlr/LMB_Clk] [get_bd_pins ilmb_v10/LMB_Clk]
  connect_bd_net -net microblaze_0_LMB_Rst [get_bd_pins LMB_Rst] [get_bd_pins dlmb_bram_if_cntlr/LMB_Rst] [get_bd_pins dlmb_v10/SYS_Rst] [get_bd_pins ilmb_bram_if_cntlr/LMB_Rst] [get_bd_pins ilmb_v10/SYS_Rst]
  
  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     puts "ERROR: Unable to find parent cell <$parentCell>!"
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     puts "ERROR: Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set LED_OUT [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 LED_OUT ]
  set P_BTN_D [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 P_BTN_D ]
  set P_BTN_L [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 P_BTN_L ]
  set P_BTN_R [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 P_BTN_R ]
  set P_BTN_U [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 P_BTN_U ]
  set SEG7_HEX_OUT [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 SEG7_HEX_OUT ]
  set SEG7_SEL_OUT [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 SEG7_SEL_OUT ]
  set S_SWITCHES [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 S_SWITCHES ]
  set VGA_COLOUR_OUT [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 VGA_COLOUR_OUT ]
  set VGA_HS [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 VGA_HS ]
  set VGA_REGION [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 VGA_REGION ]
  set VGA_VS [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:gpio_rtl:1.0 VGA_VS ]
  set uart [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 uart ]

  # Create ports
  set clk_in [ create_bd_port -dir I -type clk clk_in ]
  set_property -dict [ list CONFIG.FREQ_HZ {100000000} CONFIG.PHASE {0.000}  ] $clk_in
  set ext_reset_in [ create_bd_port -dir I -type rst ext_reset_in ]

  # Create instance: axi_intc_0, and set properties
  set axi_intc_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 axi_intc_0 ]

  # Create instance: axi_uartlite_0, and set properties
  set axi_uartlite_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 axi_uartlite_0 ]

  # Create instance: fit_timer_0, and set properties
  set fit_timer_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:fit_timer:2.0 fit_timer_0 ]
  set_property -dict [ list CONFIG.C_NO_CLOCKS {400000}  ] $fit_timer_0

  # Create instance: gpio_7seg_hex_out, and set properties
  set gpio_7seg_hex_out [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_7seg_hex_out ]
  set_property -dict [ list CONFIG.C_ALL_OUTPUTS {1} CONFIG.C_GPIO_WIDTH {8}  ] $gpio_7seg_hex_out

  # Create instance: gpio_7seg_sel, and set properties
  set gpio_7seg_sel [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_7seg_sel ]
  set_property -dict [ list CONFIG.C_ALL_OUTPUTS {1} CONFIG.C_DOUT_DEFAULT {0xFFFFFFFF} CONFIG.C_GPIO_WIDTH {4}  ] $gpio_7seg_sel

  # Create instance: gpio_leds, and set properties
  set gpio_leds [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_leds ]
  set_property -dict [ list CONFIG.C_ALL_OUTPUTS {1} CONFIG.C_GPIO_WIDTH {16}  ] $gpio_leds

  # Create instance: gpio_p_btn_d, and set properties
  set gpio_p_btn_d [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_p_btn_d ]
  set_property -dict [ list CONFIG.C_ALL_INPUTS {1} CONFIG.C_GPIO_WIDTH {1} CONFIG.C_INTERRUPT_PRESENT {1}  ] $gpio_p_btn_d

  # Create instance: gpio_p_btn_l, and set properties
  set gpio_p_btn_l [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_p_btn_l ]
  set_property -dict [ list CONFIG.C_ALL_INPUTS {1} CONFIG.C_GPIO_WIDTH {1}  ] $gpio_p_btn_l

  # Create instance: gpio_p_btn_r, and set properties
  set gpio_p_btn_r [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_p_btn_r ]
  set_property -dict [ list CONFIG.C_ALL_INPUTS {1} CONFIG.C_GPIO_WIDTH {1}  ] $gpio_p_btn_r

  # Create instance: gpio_p_btn_u, and set properties
  set gpio_p_btn_u [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_p_btn_u ]
  set_property -dict [ list CONFIG.C_ALL_INPUTS {1} CONFIG.C_GPIO_WIDTH {1}  ] $gpio_p_btn_u

  # Create instance: gpio_s_switches, and set properties
  set gpio_s_switches [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_s_switches ]
  set_property -dict [ list CONFIG.C_ALL_INPUTS {1} CONFIG.C_GPIO_WIDTH {16}  ] $gpio_s_switches

  # Create instance: gpio_vga_colour_out, and set properties
  set gpio_vga_colour_out [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_vga_colour_out ]
  set_property -dict [ list CONFIG.C_ALL_INPUTS {0} CONFIG.C_ALL_OUTPUTS {1} CONFIG.C_GPIO_WIDTH {8}  ] $gpio_vga_colour_out

  # Create instance: gpio_vga_hs, and set properties
  set gpio_vga_hs [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_vga_hs ]
  set_property -dict [ list CONFIG.C_ALL_INPUTS {0} CONFIG.C_ALL_OUTPUTS {1} CONFIG.C_GPIO_WIDTH {1}  ] $gpio_vga_hs

  # Create instance: gpio_vga_region, and set properties
  set gpio_vga_region [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_vga_region ]
  set_property -dict [ list CONFIG.C_ALL_INPUTS {0} CONFIG.C_ALL_OUTPUTS {1} CONFIG.C_GPIO_WIDTH {8}  ] $gpio_vga_region

  # Create instance: gpio_vgs_vs, and set properties
  set gpio_vgs_vs [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 gpio_vgs_vs ]
  set_property -dict [ list CONFIG.C_ALL_INPUTS {0} CONFIG.C_ALL_OUTPUTS {1} CONFIG.C_GPIO_WIDTH {1}  ] $gpio_vgs_vs

  # Create instance: mdm_0, and set properties
  set mdm_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:mdm:3.2 mdm_0 ]

  # Create instance: microblaze_0, and set properties
  set microblaze_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:9.5 microblaze_0 ]
  set_property -dict [ list CONFIG.C_DEBUG_ENABLED {1} CONFIG.C_D_AXI {1} CONFIG.C_D_LMB {1} CONFIG.C_I_LMB {1} CONFIG.C_USE_DCACHE {0} CONFIG.C_USE_ICACHE {0}  ] $microblaze_0

  # Create instance: microblaze_0_axi_periph, and set properties
  set microblaze_0_axi_periph [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 microblaze_0_axi_periph ]
  set_property -dict [ list CONFIG.NUM_MI {14}  ] $microblaze_0_axi_periph

  # Create instance: microblaze_0_local_memory
  create_hier_cell_microblaze_0_local_memory [current_bd_instance .] microblaze_0_local_memory

  # Create instance: rst_clk_wiz_1_100M, and set properties
  set rst_clk_wiz_1_100M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_clk_wiz_1_100M ]

  # Create instance: xlconcat_0, and set properties
  set xlconcat_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net axi_intc_0_interrupt [get_bd_intf_pins axi_intc_0/interrupt] [get_bd_intf_pins microblaze_0/INTERRUPT]
  connect_bd_intf_net -intf_net axi_uartlite_0_UART [get_bd_intf_ports uart] [get_bd_intf_pins axi_uartlite_0/UART]
  connect_bd_intf_net -intf_net gpio_7seg_GPIO [get_bd_intf_ports SEG7_HEX_OUT] [get_bd_intf_pins gpio_7seg_hex_out/GPIO]
  connect_bd_intf_net -intf_net gpio_7seg_sel_GPIO [get_bd_intf_ports SEG7_SEL_OUT] [get_bd_intf_pins gpio_7seg_sel/GPIO]
  connect_bd_intf_net -intf_net gpio_leds_GPIO [get_bd_intf_ports LED_OUT] [get_bd_intf_pins gpio_leds/GPIO]
  connect_bd_intf_net -intf_net gpio_p_btn_d_GPIO [get_bd_intf_ports P_BTN_D] [get_bd_intf_pins gpio_p_btn_d/GPIO]
  connect_bd_intf_net -intf_net gpio_p_btn_l_GPIO [get_bd_intf_ports P_BTN_L] [get_bd_intf_pins gpio_p_btn_l/GPIO]
  connect_bd_intf_net -intf_net gpio_p_btn_r_GPIO [get_bd_intf_ports P_BTN_R] [get_bd_intf_pins gpio_p_btn_r/GPIO]
  connect_bd_intf_net -intf_net gpio_p_buttons_GPIO [get_bd_intf_ports P_BTN_U] [get_bd_intf_pins gpio_p_btn_u/GPIO]
  connect_bd_intf_net -intf_net gpio_s_switches_GPIO [get_bd_intf_ports S_SWITCHES] [get_bd_intf_pins gpio_s_switches/GPIO]
  connect_bd_intf_net -intf_net gpio_vga_colour_out_GPIO [get_bd_intf_ports VGA_COLOUR_OUT] [get_bd_intf_pins gpio_vga_colour_out/GPIO]
  connect_bd_intf_net -intf_net gpio_vga_hs1_GPIO [get_bd_intf_ports VGA_REGION] [get_bd_intf_pins gpio_vga_region/GPIO]
  connect_bd_intf_net -intf_net gpio_vga_hs_GPIO [get_bd_intf_ports VGA_HS] [get_bd_intf_pins gpio_vga_hs/GPIO]
  connect_bd_intf_net -intf_net gpio_vgs_vs_GPIO [get_bd_intf_ports VGA_VS] [get_bd_intf_pins gpio_vgs_vs/GPIO]
  connect_bd_intf_net -intf_net mdm_0_MBDEBUG_0 [get_bd_intf_pins mdm_0/MBDEBUG_0] [get_bd_intf_pins microblaze_0/DEBUG]
  connect_bd_intf_net -intf_net microblaze_0_M_AXI_DP [get_bd_intf_pins microblaze_0/M_AXI_DP] [get_bd_intf_pins microblaze_0_axi_periph/S00_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M00_AXI [get_bd_intf_pins gpio_leds/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M00_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M01_AXI [get_bd_intf_pins gpio_s_switches/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M01_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M02_AXI [get_bd_intf_pins gpio_p_btn_u/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M02_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M03_AXI [get_bd_intf_pins gpio_7seg_hex_out/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M03_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M04_AXI [get_bd_intf_pins gpio_7seg_sel/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M04_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M05_AXI [get_bd_intf_pins gpio_vgs_vs/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M05_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M06_AXI [get_bd_intf_pins gpio_vga_colour_out/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M06_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M07_AXI [get_bd_intf_pins gpio_vga_hs/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M07_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M08_AXI [get_bd_intf_pins gpio_vga_region/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M08_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M09_AXI [get_bd_intf_pins gpio_p_btn_l/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M09_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M10_AXI [get_bd_intf_pins gpio_p_btn_r/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M10_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M11_AXI [get_bd_intf_pins gpio_p_btn_d/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M11_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M12_AXI [get_bd_intf_pins axi_uartlite_0/S_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M12_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M13_AXI [get_bd_intf_pins axi_intc_0/s_axi] [get_bd_intf_pins microblaze_0_axi_periph/M13_AXI]
  connect_bd_intf_net -intf_net microblaze_0_dlmb_1 [get_bd_intf_pins microblaze_0/DLMB] [get_bd_intf_pins microblaze_0_local_memory/DLMB]
  connect_bd_intf_net -intf_net microblaze_0_ilmb_1 [get_bd_intf_pins microblaze_0/ILMB] [get_bd_intf_pins microblaze_0_local_memory/ILMB]

  # Create port connections
  connect_bd_net -net ext_reset_in_1 [get_bd_ports ext_reset_in] [get_bd_pins rst_clk_wiz_1_100M/ext_reset_in]
  connect_bd_net -net fit_timer_0_Interrupt [get_bd_pins fit_timer_0/Interrupt] [get_bd_pins xlconcat_0/In0]
  connect_bd_net -net gpio_p_btn_d_ip2intc_irpt [get_bd_pins gpio_p_btn_d/ip2intc_irpt] [get_bd_pins xlconcat_0/In1]
  connect_bd_net -net mdm_0_Debug_SYS_Rst [get_bd_pins mdm_0/Debug_SYS_Rst] [get_bd_pins rst_clk_wiz_1_100M/mb_debug_sys_rst]
  connect_bd_net -net microblaze_0_Clk [get_bd_ports clk_in] [get_bd_pins axi_intc_0/s_axi_aclk] [get_bd_pins axi_uartlite_0/s_axi_aclk] [get_bd_pins fit_timer_0/Clk] [get_bd_pins gpio_7seg_hex_out/s_axi_aclk] [get_bd_pins gpio_7seg_sel/s_axi_aclk] [get_bd_pins gpio_leds/s_axi_aclk] [get_bd_pins gpio_p_btn_d/s_axi_aclk] [get_bd_pins gpio_p_btn_l/s_axi_aclk] [get_bd_pins gpio_p_btn_r/s_axi_aclk] [get_bd_pins gpio_p_btn_u/s_axi_aclk] [get_bd_pins gpio_s_switches/s_axi_aclk] [get_bd_pins gpio_vga_colour_out/s_axi_aclk] [get_bd_pins gpio_vga_hs/s_axi_aclk] [get_bd_pins gpio_vga_region/s_axi_aclk] [get_bd_pins gpio_vgs_vs/s_axi_aclk] [get_bd_pins microblaze_0/Clk] [get_bd_pins microblaze_0_axi_periph/ACLK] [get_bd_pins microblaze_0_axi_periph/M00_ACLK] [get_bd_pins microblaze_0_axi_periph/M01_ACLK] [get_bd_pins microblaze_0_axi_periph/M02_ACLK] [get_bd_pins microblaze_0_axi_periph/M03_ACLK] [get_bd_pins microblaze_0_axi_periph/M04_ACLK] [get_bd_pins microblaze_0_axi_periph/M05_ACLK] [get_bd_pins microblaze_0_axi_periph/M06_ACLK] [get_bd_pins microblaze_0_axi_periph/M07_ACLK] [get_bd_pins microblaze_0_axi_periph/M08_ACLK] [get_bd_pins microblaze_0_axi_periph/M09_ACLK] [get_bd_pins microblaze_0_axi_periph/M10_ACLK] [get_bd_pins microblaze_0_axi_periph/M11_ACLK] [get_bd_pins microblaze_0_axi_periph/M12_ACLK] [get_bd_pins microblaze_0_axi_periph/M13_ACLK] [get_bd_pins microblaze_0_axi_periph/S00_ACLK] [get_bd_pins microblaze_0_local_memory/LMB_Clk] [get_bd_pins rst_clk_wiz_1_100M/slowest_sync_clk]
  connect_bd_net -net rst_clk_wiz_1_100M_bus_struct_reset [get_bd_pins microblaze_0_local_memory/LMB_Rst] [get_bd_pins rst_clk_wiz_1_100M/bus_struct_reset]
  connect_bd_net -net rst_clk_wiz_1_100M_interconnect_aresetn [get_bd_pins microblaze_0_axi_periph/ARESETN] [get_bd_pins rst_clk_wiz_1_100M/interconnect_aresetn]
  connect_bd_net -net rst_clk_wiz_1_100M_mb_reset [get_bd_pins microblaze_0/Reset] [get_bd_pins rst_clk_wiz_1_100M/mb_reset]
  connect_bd_net -net rst_clk_wiz_1_100M_peripheral_aresetn [get_bd_pins axi_intc_0/s_axi_aresetn] [get_bd_pins axi_uartlite_0/s_axi_aresetn] [get_bd_pins fit_timer_0/Rst] [get_bd_pins gpio_7seg_hex_out/s_axi_aresetn] [get_bd_pins gpio_7seg_sel/s_axi_aresetn] [get_bd_pins gpio_leds/s_axi_aresetn] [get_bd_pins gpio_p_btn_d/s_axi_aresetn] [get_bd_pins gpio_p_btn_l/s_axi_aresetn] [get_bd_pins gpio_p_btn_r/s_axi_aresetn] [get_bd_pins gpio_p_btn_u/s_axi_aresetn] [get_bd_pins gpio_s_switches/s_axi_aresetn] [get_bd_pins gpio_vga_colour_out/s_axi_aresetn] [get_bd_pins gpio_vga_hs/s_axi_aresetn] [get_bd_pins gpio_vga_region/s_axi_aresetn] [get_bd_pins gpio_vgs_vs/s_axi_aresetn] [get_bd_pins microblaze_0_axi_periph/M00_ARESETN] [get_bd_pins microblaze_0_axi_periph/M01_ARESETN] [get_bd_pins microblaze_0_axi_periph/M02_ARESETN] [get_bd_pins microblaze_0_axi_periph/M03_ARESETN] [get_bd_pins microblaze_0_axi_periph/M04_ARESETN] [get_bd_pins microblaze_0_axi_periph/M05_ARESETN] [get_bd_pins microblaze_0_axi_periph/M06_ARESETN] [get_bd_pins microblaze_0_axi_periph/M07_ARESETN] [get_bd_pins microblaze_0_axi_periph/M08_ARESETN] [get_bd_pins microblaze_0_axi_periph/M09_ARESETN] [get_bd_pins microblaze_0_axi_periph/M10_ARESETN] [get_bd_pins microblaze_0_axi_periph/M11_ARESETN] [get_bd_pins microblaze_0_axi_periph/M12_ARESETN] [get_bd_pins microblaze_0_axi_periph/M13_ARESETN] [get_bd_pins microblaze_0_axi_periph/S00_ARESETN] [get_bd_pins rst_clk_wiz_1_100M/peripheral_aresetn]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins axi_intc_0/intr] [get_bd_pins xlconcat_0/dout]

  # Create address segments
  create_bd_addr_seg -range 0x10000 -offset 0x41200000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs axi_intc_0/s_axi/Reg] SEG_axi_intc_0_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x40600000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs axi_uartlite_0/S_AXI/Reg] SEG_axi_uartlite_0_Reg
  create_bd_addr_seg -range 0x20000 -offset 0x0 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs microblaze_0_local_memory/dlmb_bram_if_cntlr/SLMB/Mem] SEG_dlmb_bram_if_cntlr_Mem
  create_bd_addr_seg -range 0x10000 -offset 0x40030000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs gpio_7seg_hex_out/S_AXI/Reg] SEG_gpio_7seg_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x40040000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs gpio_7seg_sel/S_AXI/Reg] SEG_gpio_7seg_sel_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x40000000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs gpio_leds/S_AXI/Reg] SEG_gpio_leds_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x400B0000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs gpio_p_btn_d/S_AXI/Reg] SEG_gpio_p_btn_d_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x40090000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs gpio_p_btn_l/S_AXI/Reg] SEG_gpio_p_btn_l_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x400A0000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs gpio_p_btn_r/S_AXI/Reg] SEG_gpio_p_btn_r_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x40020000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs gpio_p_btn_u/S_AXI/Reg] SEG_gpio_p_buttons_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x40010000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs gpio_s_switches/S_AXI/Reg] SEG_gpio_s_switches_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x40060000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs gpio_vga_colour_out/S_AXI/Reg] SEG_gpio_vga_colour_out_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x40070000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs gpio_vga_hs/S_AXI/Reg] SEG_gpio_vga_hs_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x40080000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs gpio_vga_region/S_AXI/Reg] SEG_gpio_vga_region_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x40050000 [get_bd_addr_spaces microblaze_0/Data] [get_bd_addr_segs gpio_vgs_vs/S_AXI/Reg] SEG_gpio_vgs_vs_Reg
  create_bd_addr_seg -range 0x20000 -offset 0x0 [get_bd_addr_spaces microblaze_0/Instruction] [get_bd_addr_segs microblaze_0_local_memory/ilmb_bram_if_cntlr/SLMB/Mem] SEG_ilmb_bram_if_cntlr_Mem
  

  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


