## Generated SDC file "P3.out.sdc"

## Copyright (C) 2022  Intel Corporation. All rights reserved.
## Your use of Intel Corporation's design tools, logic functions 
## and other software and tools, and any partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Intel Program License 
## Subscription Agreement, the Intel Quartus Prime License Agreement,
## the Intel FPGA IP License Agreement, or other applicable license
## agreement, including, without limitation, that your use is for
## the sole purpose of programming logic devices manufactured by
## Intel and sold by Intel or its authorized distributors.  Please
## refer to the applicable agreement for further details, at
## https://fpgasoftware.intel.com/eula.


## VENDOR  "Altera"
## PROGRAM "Quartus Prime"
## VERSION "Version 22.1std.0 Build 915 10/25/2022 SC Lite Edition"

## DATE    "Sat Mar 23 20:16:19 2024"

##
## DEVICE  "10M50DAF484C6GES"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {vga:U_VGA|clk_div:clk_div|temp_clk} -period 1.000 -waveform { 0.000 0.500 } [get_registers {vga:U_VGA|clk_div:clk_div|temp_clk}]
create_clock -name {clk_div:U_CLK_DIV|temp_clk} -period 1.000 -waveform { 0.000 0.500 } [get_registers {clk_div:U_CLK_DIV|temp_clk}]
create_clock -name {clkDE10} -period 20.000 -waveform { 0.000 10.000 } [get_ports {clk50MHz}]


#**************************************************************
# Create Generated Clock
#**************************************************************



#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************

set_clock_uncertainty -rise_from [get_clocks {clkDE10}] -rise_to [get_clocks {clkDE10}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {clkDE10}] -fall_to [get_clocks {clkDE10}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {clkDE10}] -rise_to [get_clocks {clk_div:U_CLK_DIV|temp_clk}]  0.030  
set_clock_uncertainty -rise_from [get_clocks {clkDE10}] -fall_to [get_clocks {clk_div:U_CLK_DIV|temp_clk}]  0.030  
set_clock_uncertainty -fall_from [get_clocks {clkDE10}] -rise_to [get_clocks {clkDE10}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {clkDE10}] -fall_to [get_clocks {clkDE10}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {clkDE10}] -rise_to [get_clocks {clk_div:U_CLK_DIV|temp_clk}]  0.030  
set_clock_uncertainty -fall_from [get_clocks {clkDE10}] -fall_to [get_clocks {clk_div:U_CLK_DIV|temp_clk}]  0.030  
set_clock_uncertainty -rise_from [get_clocks {vga:U_VGA|clk_div:clk_div|temp_clk}] -rise_to [get_clocks {vga:U_VGA|clk_div:clk_div|temp_clk}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {vga:U_VGA|clk_div:clk_div|temp_clk}] -fall_to [get_clocks {vga:U_VGA|clk_div:clk_div|temp_clk}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {vga:U_VGA|clk_div:clk_div|temp_clk}] -rise_to [get_clocks {clk_div:U_CLK_DIV|temp_clk}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {vga:U_VGA|clk_div:clk_div|temp_clk}] -fall_to [get_clocks {clk_div:U_CLK_DIV|temp_clk}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {vga:U_VGA|clk_div:clk_div|temp_clk}] -rise_to [get_clocks {vga:U_VGA|clk_div:clk_div|temp_clk}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {vga:U_VGA|clk_div:clk_div|temp_clk}] -fall_to [get_clocks {vga:U_VGA|clk_div:clk_div|temp_clk}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {vga:U_VGA|clk_div:clk_div|temp_clk}] -rise_to [get_clocks {clk_div:U_CLK_DIV|temp_clk}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {vga:U_VGA|clk_div:clk_div|temp_clk}] -fall_to [get_clocks {clk_div:U_CLK_DIV|temp_clk}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {clk_div:U_CLK_DIV|temp_clk}] -rise_to [get_clocks {clkDE10}]  0.030  
set_clock_uncertainty -rise_from [get_clocks {clk_div:U_CLK_DIV|temp_clk}] -fall_to [get_clocks {clkDE10}]  0.030  
set_clock_uncertainty -rise_from [get_clocks {clk_div:U_CLK_DIV|temp_clk}] -rise_to [get_clocks {vga:U_VGA|clk_div:clk_div|temp_clk}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {clk_div:U_CLK_DIV|temp_clk}] -fall_to [get_clocks {vga:U_VGA|clk_div:clk_div|temp_clk}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {clk_div:U_CLK_DIV|temp_clk}] -rise_to [get_clocks {clk_div:U_CLK_DIV|temp_clk}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {clk_div:U_CLK_DIV|temp_clk}] -fall_to [get_clocks {clk_div:U_CLK_DIV|temp_clk}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {clk_div:U_CLK_DIV|temp_clk}] -rise_to [get_clocks {clkDE10}]  0.030  
set_clock_uncertainty -fall_from [get_clocks {clk_div:U_CLK_DIV|temp_clk}] -fall_to [get_clocks {clkDE10}]  0.030  
set_clock_uncertainty -fall_from [get_clocks {clk_div:U_CLK_DIV|temp_clk}] -rise_to [get_clocks {vga:U_VGA|clk_div:clk_div|temp_clk}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {clk_div:U_CLK_DIV|temp_clk}] -fall_to [get_clocks {vga:U_VGA|clk_div:clk_div|temp_clk}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {clk_div:U_CLK_DIV|temp_clk}] -rise_to [get_clocks {clk_div:U_CLK_DIV|temp_clk}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {clk_div:U_CLK_DIV|temp_clk}] -fall_to [get_clocks {clk_div:U_CLK_DIV|temp_clk}]  0.020  


#**************************************************************
# Set Input Delay
#**************************************************************



#**************************************************************
# Set Output Delay
#**************************************************************



#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************



#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************

