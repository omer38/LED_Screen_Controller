# This file is a general .xdc for the Basys3 rev B board
# To use it in a project:
# - uncomment the lines corresponding to used pins
# - rename the used ports (in each line, after get_ports) according to the top level signal names in the project
# Clock signal
set_property PACKAGE_PIN W5 [get_ports clk_in]
set_property IOSTANDARD LVCMOS33 [get_ports clk_in]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk_in]

# Switches
set_property PACKAGE_PIN V17 [get_ports {load_in}]
set_property IOSTANDARD LVCMOS33 [get_ports {load_in}]


#Buttons
set_property PACKAGE_PIN U18 [get_ports reset_in]
set_property IOSTANDARD LVCMOS33 [get_ports reset_in]

##Pmod Header JA
##Sch name = JA1
set_property PACKAGE_PIN J1 [get_ports {clk_out}]
set_property IOSTANDARD LVCMOS33 [get_ports {clk_out}]
##Sch name = JA2
set_property PACKAGE_PIN L2 [get_ports {hoe1_out}]
set_property IOSTANDARD LVCMOS33 [get_ports {hoe1_out}]
##Sch name = JA3
set_property PACKAGE_PIN J2 [get_ports {hlatch_out}]
set_property IOSTANDARD LVCMOS33 [get_ports {hlatch_out}]
##Sch name = JA4
set_property PACKAGE_PIN G2 [get_ports {dataout_out}]
set_property IOSTANDARD LVCMOS33 [get_ports {dataout_out}]

##Pmod Header JB
##Sch name = JB1
set_property PACKAGE_PIN A14 [get_ports {counter_out[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {counter_out[0]}]
##Sch name = JB2
set_property PACKAGE_PIN A16 [get_ports {counter_out[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {counter_out[1]}]
##Sch name = JB3
set_property PACKAGE_PIN B15 [get_ports {counter_out[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {counter_out[2]}]
##Sch name = JB4
set_property PACKAGE_PIN B16 [get_ports {counter_out[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {counter_out[3]}]
##Sch name = JB7
set_property PACKAGE_PIN A15 [get_ports {counter_out[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {counter_out[4]}]





#entity top_module is
#	port(
#		clk_in : in std_logic;
#		load_in : in std_logic;
#		reset_in : in std_logic;
#-------------------------------------------------------------
#		dataout_out : out std_logic;
#		counter_out : out std_logic_vector(4 downto 0);
#		clk_out : out std_logic;
#		hlatch_out	: out std_logic;
#		hoe1_out	: out std_logic
#	);
#end top_module;
