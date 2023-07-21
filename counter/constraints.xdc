# This file is a general .xdc for the Basys3 rev B board
# To use it in a project:
# - uncomment the lines corresponding to used pins
# - rename the used ports (in each line, after get_ports) according to the top level signal names in the project
# Clock signal
set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]

# BUTTON
set_property PACKAGE_PIN U18 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports reset]

##Pmod Header JA
##Sch name = JA1
set_property PACKAGE_PIN J1 [get_ports {counter[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {counter[0]}]
##Sch name = counter2
set_property PACKAGE_PIN L2 [get_ports {counter[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {counter[1]}]
##Sch name = counter3
set_property PACKAGE_PIN J2 [get_ports {counter[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {counter[2]}]
##Sch name = counter4
set_property PACKAGE_PIN G2 [get_ports {counter[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {counter[3]}]
##Sch name = counter7
set_property PACKAGE_PIN H1 [get_ports {counter[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {counter[4]}]
