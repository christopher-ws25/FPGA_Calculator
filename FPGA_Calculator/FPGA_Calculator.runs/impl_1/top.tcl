proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

start_step init_design
set rc [catch {
  create_msg_db init_design.pb
  debug::add_scope template.lib 1
  set_property design_mode GateLvl [current_fileset]
  set_property webtalk.parent_dir C:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.cache/wt [current_project]
  set_property parent.project_path C:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.xpr [current_project]
  set_property ip_repo_paths c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.cache/ip [current_project]
  set_property ip_output_repo c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.cache/ip [current_project]
  add_files -quiet C:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.runs/synth_1/top.dcp
  add_files C:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/mb_system.bmm
  set_property SCOPED_TO_REF mb_system [get_files -all C:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/mb_system.bmm]
  set_property SCOPED_TO_CELLS {} [get_files -all C:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/mb_system.bmm]
  add_files c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/ipshared/xilinx.com/microblaze_v9_5/cfde4cbb/data/mb_bootloop_le.elf
  set_property SCOPED_TO_REF mb_system [get_files -all c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/ipshared/xilinx.com/microblaze_v9_5/cfde4cbb/data/mb_bootloop_le.elf]
  set_property SCOPED_TO_CELLS microblaze_0 [get_files -all c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/ipshared/xilinx.com/microblaze_v9_5/cfde4cbb/data/mb_bootloop_le.elf]
  read_xdc -ref mb_system_microblaze_0_0 -cells U0 c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_microblaze_0_0/mb_system_microblaze_0_0.xdc
  set_property processing_order EARLY [get_files c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_microblaze_0_0/mb_system_microblaze_0_0.xdc]
  read_xdc -ref mb_system_dlmb_v10_0 -cells U0 c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_dlmb_v10_0/mb_system_dlmb_v10_0.xdc
  set_property processing_order EARLY [get_files c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_dlmb_v10_0/mb_system_dlmb_v10_0.xdc]
  read_xdc -ref mb_system_ilmb_v10_0 -cells U0 c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_ilmb_v10_0/mb_system_ilmb_v10_0.xdc
  set_property processing_order EARLY [get_files c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_ilmb_v10_0/mb_system_ilmb_v10_0.xdc]
  read_xdc -prop_thru_buffers -ref mb_system_rst_clk_wiz_1_100M_0 c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_rst_clk_wiz_1_100M_0/mb_system_rst_clk_wiz_1_100M_0_board.xdc
  set_property processing_order EARLY [get_files c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_rst_clk_wiz_1_100M_0/mb_system_rst_clk_wiz_1_100M_0_board.xdc]
  read_xdc -ref mb_system_rst_clk_wiz_1_100M_0 c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_rst_clk_wiz_1_100M_0/mb_system_rst_clk_wiz_1_100M_0.xdc
  set_property processing_order EARLY [get_files c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_rst_clk_wiz_1_100M_0/mb_system_rst_clk_wiz_1_100M_0.xdc]
  read_xdc -prop_thru_buffers -ref mb_system_axi_gpio_0_0 -cells U0 c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_axi_gpio_0_0/mb_system_axi_gpio_0_0_board.xdc
  set_property processing_order EARLY [get_files c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_axi_gpio_0_0/mb_system_axi_gpio_0_0_board.xdc]
  read_xdc -ref mb_system_axi_gpio_0_0 -cells U0 c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_axi_gpio_0_0/mb_system_axi_gpio_0_0.xdc
  set_property processing_order EARLY [get_files c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_axi_gpio_0_0/mb_system_axi_gpio_0_0.xdc]
  read_xdc -prop_thru_buffers -ref mb_system_gpio_leds_0 -cells U0 c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_gpio_leds_0/mb_system_gpio_leds_0_board.xdc
  set_property processing_order EARLY [get_files c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_gpio_leds_0/mb_system_gpio_leds_0_board.xdc]
  read_xdc -ref mb_system_gpio_leds_0 -cells U0 c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_gpio_leds_0/mb_system_gpio_leds_0.xdc
  set_property processing_order EARLY [get_files c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_gpio_leds_0/mb_system_gpio_leds_0.xdc]
  read_xdc -prop_thru_buffers -ref mb_system_gpio_s_switches_0 -cells U0 c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_gpio_s_switches_0/mb_system_gpio_s_switches_0_board.xdc
  set_property processing_order EARLY [get_files c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_gpio_s_switches_0/mb_system_gpio_s_switches_0_board.xdc]
  read_xdc -ref mb_system_gpio_s_switches_0 -cells U0 c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_gpio_s_switches_0/mb_system_gpio_s_switches_0.xdc
  set_property processing_order EARLY [get_files c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_gpio_s_switches_0/mb_system_gpio_s_switches_0.xdc]
  read_xdc -prop_thru_buffers -ref mb_system_gpio_leds_1 -cells U0 c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_gpio_leds_1/mb_system_gpio_leds_1_board.xdc
  set_property processing_order EARLY [get_files c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_gpio_leds_1/mb_system_gpio_leds_1_board.xdc]
  read_xdc -ref mb_system_gpio_leds_1 -cells U0 c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_gpio_leds_1/mb_system_gpio_leds_1.xdc
  set_property processing_order EARLY [get_files c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_gpio_leds_1/mb_system_gpio_leds_1.xdc]
  read_xdc -prop_thru_buffers -ref mb_system_gpio_7seg_0 -cells U0 c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_gpio_7seg_0/mb_system_gpio_7seg_0_board.xdc
  set_property processing_order EARLY [get_files c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_gpio_7seg_0/mb_system_gpio_7seg_0_board.xdc]
  read_xdc -ref mb_system_gpio_7seg_0 -cells U0 c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_gpio_7seg_0/mb_system_gpio_7seg_0.xdc
  set_property processing_order EARLY [get_files c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_gpio_7seg_0/mb_system_gpio_7seg_0.xdc]
  read_xdc -prop_thru_buffers -ref mb_system_gpio_s_switches_1 -cells U0 c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_gpio_s_switches_1/mb_system_gpio_s_switches_1_board.xdc
  set_property processing_order EARLY [get_files c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_gpio_s_switches_1/mb_system_gpio_s_switches_1_board.xdc]
  read_xdc -ref mb_system_gpio_s_switches_1 -cells U0 c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_gpio_s_switches_1/mb_system_gpio_s_switches_1.xdc
  set_property processing_order EARLY [get_files c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_gpio_s_switches_1/mb_system_gpio_s_switches_1.xdc]
  read_xdc -prop_thru_buffers -ref mb_system_gpio_s_switches_2 -cells U0 c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_gpio_s_switches_2/mb_system_gpio_s_switches_2_board.xdc
  set_property processing_order EARLY [get_files c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_gpio_s_switches_2/mb_system_gpio_s_switches_2_board.xdc]
  read_xdc -ref mb_system_gpio_s_switches_2 -cells U0 c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_gpio_s_switches_2/mb_system_gpio_s_switches_2.xdc
  set_property processing_order EARLY [get_files c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_gpio_s_switches_2/mb_system_gpio_s_switches_2.xdc]
  read_xdc -prop_thru_buffers -ref mb_system_gpio_s_switches_3 -cells U0 c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_gpio_s_switches_3/mb_system_gpio_s_switches_3_board.xdc
  set_property processing_order EARLY [get_files c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_gpio_s_switches_3/mb_system_gpio_s_switches_3_board.xdc]
  read_xdc -ref mb_system_gpio_s_switches_3 -cells U0 c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_gpio_s_switches_3/mb_system_gpio_s_switches_3.xdc
  set_property processing_order EARLY [get_files c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_gpio_s_switches_3/mb_system_gpio_s_switches_3.xdc]
  read_xdc -prop_thru_buffers -ref mb_system_gpio_vga_hs_0 -cells U0 c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_gpio_vga_hs_0/mb_system_gpio_vga_hs_0_board.xdc
  set_property processing_order EARLY [get_files c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_gpio_vga_hs_0/mb_system_gpio_vga_hs_0_board.xdc]
  read_xdc -ref mb_system_gpio_vga_hs_0 -cells U0 c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_gpio_vga_hs_0/mb_system_gpio_vga_hs_0.xdc
  set_property processing_order EARLY [get_files c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_gpio_vga_hs_0/mb_system_gpio_vga_hs_0.xdc]
  read_xdc -prop_thru_buffers -ref mb_system_gpio_p_btn_u_0 -cells U0 c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_gpio_p_btn_u_0/mb_system_gpio_p_btn_u_0_board.xdc
  set_property processing_order EARLY [get_files c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_gpio_p_btn_u_0/mb_system_gpio_p_btn_u_0_board.xdc]
  read_xdc -ref mb_system_gpio_p_btn_u_0 -cells U0 c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_gpio_p_btn_u_0/mb_system_gpio_p_btn_u_0.xdc
  set_property processing_order EARLY [get_files c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_gpio_p_btn_u_0/mb_system_gpio_p_btn_u_0.xdc]
  read_xdc -prop_thru_buffers -ref mb_system_gpio_p_btn_u_1 -cells U0 c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_gpio_p_btn_u_1/mb_system_gpio_p_btn_u_1_board.xdc
  set_property processing_order EARLY [get_files c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_gpio_p_btn_u_1/mb_system_gpio_p_btn_u_1_board.xdc]
  read_xdc -ref mb_system_gpio_p_btn_u_1 -cells U0 c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_gpio_p_btn_u_1/mb_system_gpio_p_btn_u_1.xdc
  set_property processing_order EARLY [get_files c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_gpio_p_btn_u_1/mb_system_gpio_p_btn_u_1.xdc]
  read_xdc -prop_thru_buffers -ref mb_system_gpio_p_btn_u_2 -cells U0 c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_gpio_p_btn_u_2/mb_system_gpio_p_btn_u_2_board.xdc
  set_property processing_order EARLY [get_files c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_gpio_p_btn_u_2/mb_system_gpio_p_btn_u_2_board.xdc]
  read_xdc -ref mb_system_gpio_p_btn_u_2 -cells U0 c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_gpio_p_btn_u_2/mb_system_gpio_p_btn_u_2.xdc
  set_property processing_order EARLY [get_files c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_gpio_p_btn_u_2/mb_system_gpio_p_btn_u_2.xdc]
  read_xdc -prop_thru_buffers -ref mb_system_axi_uartlite_0_0 -cells U0 c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_axi_uartlite_0_0/mb_system_axi_uartlite_0_0_board.xdc
  set_property processing_order EARLY [get_files c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_axi_uartlite_0_0/mb_system_axi_uartlite_0_0_board.xdc]
  read_xdc -ref mb_system_axi_uartlite_0_0 -cells U0 c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_axi_uartlite_0_0/mb_system_axi_uartlite_0_0.xdc
  set_property processing_order EARLY [get_files c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_axi_uartlite_0_0/mb_system_axi_uartlite_0_0.xdc]
  read_xdc -ref mb_system_mdm_0_0 -cells U0 c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_mdm_0_0/mb_system_mdm_0_0.xdc
  set_property processing_order EARLY [get_files c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_mdm_0_0/mb_system_mdm_0_0.xdc]
  read_xdc -ref mb_system_axi_intc_0_0 -cells U0 c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_axi_intc_0_0/mb_system_axi_intc_0_0.xdc
  set_property processing_order EARLY [get_files c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_axi_intc_0_0/mb_system_axi_intc_0_0.xdc]
  read_xdc C:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/constrs_1/imports/sources_1/constraints.xdc
  read_xdc -ref mb_system_axi_intc_0_0 -cells U0 c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_axi_intc_0_0/mb_system_axi_intc_0_0_clocks.xdc
  set_property processing_order LATE [get_files c:/Users/s1301217/Desktop/ES3_Lab_Upgrade/Upgrade/Assessment_1_Calculator/es3_hw_assmnt_1/es3_hw_assmnt_1.srcs/sources_1/bd/mb_system/ip/mb_system_axi_intc_0_0/mb_system_axi_intc_0_0_clocks.xdc]
  link_design -top top -part xc7a35tcpg236-1
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
}

start_step opt_design
set rc [catch {
  create_msg_db opt_design.pb
  catch {write_debug_probes -quiet -force debug_nets}
  opt_design 
  write_checkpoint -force top_opt.dcp
  catch {report_drc -file top_drc_opted.rpt}
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
}

start_step place_design
set rc [catch {
  create_msg_db place_design.pb
  catch {write_hwdef -file top.hwdef}
  place_design 
  write_checkpoint -force top_placed.dcp
  catch { report_io -file top_io_placed.rpt }
  catch { report_utilization -file top_utilization_placed.rpt -pb top_utilization_placed.pb }
  catch { report_control_sets -verbose -file top_control_sets_placed.rpt }
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
}

start_step route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force top_routed.dcp
  catch { report_drc -file top_drc_routed.rpt -pb top_drc_routed.pb }
  catch { report_timing_summary -warn_on_violation -max_paths 10 -file top_timing_summary_routed.rpt -rpx top_timing_summary_routed.rpx }
  catch { report_power -file top_power_routed.rpt -pb top_power_summary_routed.pb }
  catch { report_route_status -file top_route_status.rpt -pb top_route_status.pb }
  catch { report_clock_utilization -file top_clock_utilization_routed.rpt }
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
}

start_step write_bitstream
set rc [catch {
  create_msg_db write_bitstream.pb
  catch { write_mem_info -force top.mmi }
  catch { write_bmm -force top_bd.bmm }
  write_bitstream -force top.bit 
  catch { write_sysdef -hwdef top.hwdef -bitfile top.bit -meminfo top.mmi -ltxfile debug_nets.ltx -file top.sysdef }
  close_msg_db -file write_bitstream.pb
} RESULT]
if {$rc} {
  step_failed write_bitstream
  return -code error $RESULT
} else {
  end_step write_bitstream
}

