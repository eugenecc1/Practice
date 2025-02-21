## This file is a general .xdc for the Nexys4 DDR Rev. C
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

#====================================================================================================
#====================================================================================================
#                                               Nexy 4
#====================================================================================================
#====================================================================================================

#======================================================================================================================
# Clock signal
#======================================================================================================================
set_property -dict {PACKAGE_PIN E3 IOSTANDARD LVCMOS33} [get_ports clk]
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports clk]

#======================================================================================================================
# To facilitate Quad-SPI flash programming 
#======================================================================================================================
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]


#======================================================================================================================
#Switches
#======================================================================================================================
set_property -dict {PACKAGE_PIN J15 IOSTANDARD LVCMOS33} [get_ports {sw[0]}]
set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports {sw[1]}]
set_property -dict {PACKAGE_PIN M13 IOSTANDARD LVCMOS33} [get_ports {sw[2]}]
set_property -dict {PACKAGE_PIN R15 IOSTANDARD LVCMOS33} [get_ports {sw[3]}]
set_property -dict {PACKAGE_PIN R17 IOSTANDARD LVCMOS33} [get_ports {sw[4]}]
set_property -dict {PACKAGE_PIN T18 IOSTANDARD LVCMOS33} [get_ports {sw[5]}]
set_property -dict {PACKAGE_PIN U18 IOSTANDARD LVCMOS33} [get_ports {sw[6]}]
set_property -dict {PACKAGE_PIN R13 IOSTANDARD LVCMOS33} [get_ports {sw[7]}]
set_property -dict {PACKAGE_PIN T8 IOSTANDARD LVCMOS33} [get_ports {sw[8]}]
set_property -dict {PACKAGE_PIN U8 IOSTANDARD LVCMOS33} [get_ports {sw[9]}]
set_property -dict {PACKAGE_PIN R16 IOSTANDARD LVCMOS33} [get_ports {sw[10]}]
set_property -dict {PACKAGE_PIN T13 IOSTANDARD LVCMOS33} [get_ports {sw[11]}]
set_property -dict {PACKAGE_PIN H6 IOSTANDARD LVCMOS33} [get_ports {sw[12]}]
set_property -dict {PACKAGE_PIN U12 IOSTANDARD LVCMOS33} [get_ports {sw[13]}]
set_property -dict {PACKAGE_PIN U11 IOSTANDARD LVCMOS33} [get_ports {sw[14]}]
set_property -dict {PACKAGE_PIN V10 IOSTANDARD LVCMOS33} [get_ports {sw[15]}]

#======================================================================================================================
#Buttons
#======================================================================================================================
# ***** CPU_reset button; active low
set_property -dict {PACKAGE_PIN C12 IOSTANDARD LVCMOS33} [get_ports reset_n]
# ***** Other buttons; active high
# ***** btn(0): btnu;  btn(1): btnr;  btn(2): btnd; btn(3): btnl;  btn(4): btnc;
set_property -dict {PACKAGE_PIN N17 IOSTANDARD LVCMOS33} [get_ports {btn[4]}]
set_property -dict {PACKAGE_PIN M18 IOSTANDARD LVCMOS33} [get_ports {btn[0]}]
set_property -dict {PACKAGE_PIN P17 IOSTANDARD LVCMOS33} [get_ports {btn[3]}]
set_property -dict {PACKAGE_PIN M17 IOSTANDARD LVCMOS33} [get_ports {btn[1]}]
set_property -dict {PACKAGE_PIN P18 IOSTANDARD LVCMOS33} [get_ports {btn[2]}]

#======================================================================================================================
# discrete LEDs
#======================================================================================================================
set_property -dict {PACKAGE_PIN H17 IOSTANDARD LVCMOS33} [get_ports {led[0]}]
set_property -dict {PACKAGE_PIN K15 IOSTANDARD LVCMOS33} [get_ports {led[1]}]
set_property -dict {PACKAGE_PIN J13 IOSTANDARD LVCMOS33} [get_ports {led[2]}]
set_property -dict {PACKAGE_PIN N14 IOSTANDARD LVCMOS33} [get_ports {led[3]}]
set_property -dict {PACKAGE_PIN R18 IOSTANDARD LVCMOS33} [get_ports {led[4]}]
set_property -dict {PACKAGE_PIN V17 IOSTANDARD LVCMOS33} [get_ports {led[5]}]
set_property -dict {PACKAGE_PIN U17 IOSTANDARD LVCMOS33} [get_ports {led[6]}]
set_property -dict {PACKAGE_PIN U16 IOSTANDARD LVCMOS33} [get_ports {led[7]}]
set_property -dict {PACKAGE_PIN V16 IOSTANDARD LVCMOS33} [get_ports {led[8]}]
set_property -dict {PACKAGE_PIN T15 IOSTANDARD LVCMOS33} [get_ports {led[9]}]
set_property -dict {PACKAGE_PIN U14 IOSTANDARD LVCMOS33} [get_ports {led[10]}]
set_property -dict {PACKAGE_PIN T16 IOSTANDARD LVCMOS33} [get_ports {led[11]}]
set_property -dict {PACKAGE_PIN V15 IOSTANDARD LVCMOS33} [get_ports {led[12]}]
set_property -dict {PACKAGE_PIN V14 IOSTANDARD LVCMOS33} [get_ports {led[13]}]
set_property -dict {PACKAGE_PIN V12 IOSTANDARD LVCMOS33} [get_ports {led[14]}]
set_property -dict {PACKAGE_PIN V11 IOSTANDARD LVCMOS33} [get_ports {led[15]}]

#======================================================================================================================
# tri-color LEDs
#======================================================================================================================
set_property -dict {PACKAGE_PIN R12 IOSTANDARD LVCMOS33} [get_ports {rgb_led1[0]}]
set_property -dict {PACKAGE_PIN M16 IOSTANDARD LVCMOS33} [get_ports {rgb_led1[1]}]
set_property -dict {PACKAGE_PIN N15 IOSTANDARD LVCMOS33} [get_ports {rgb_led1[2]}]
set_property -dict {PACKAGE_PIN G14 IOSTANDARD LVCMOS33} [get_ports {rgb_led2[0]}]
set_property -dict {PACKAGE_PIN R11 IOSTANDARD LVCMOS33} [get_ports {rgb_led2[1]}]
set_property -dict {PACKAGE_PIN N16 IOSTANDARD LVCMOS33} [get_ports {rgb_led2[2]}]

#======================================================================================================================
#7 segment display
#======================================================================================================================
set_property -dict {PACKAGE_PIN T10 IOSTANDARD LVCMOS33} [get_ports {sseg[0]}]
set_property -dict {PACKAGE_PIN R10 IOSTANDARD LVCMOS33} [get_ports {sseg[1]}]
set_property -dict {PACKAGE_PIN K16 IOSTANDARD LVCMOS33} [get_ports {sseg[2]}]
set_property -dict {PACKAGE_PIN K13 IOSTANDARD LVCMOS33} [get_ports {sseg[3]}]
set_property -dict {PACKAGE_PIN P15 IOSTANDARD LVCMOS33} [get_ports {sseg[4]}]
set_property -dict {PACKAGE_PIN T11 IOSTANDARD LVCMOS33} [get_ports {sseg[5]}]
set_property -dict {PACKAGE_PIN L18 IOSTANDARD LVCMOS33} [get_ports {sseg[6]}]
#decimal point
set_property -dict {PACKAGE_PIN H15 IOSTANDARD LVCMOS33} [get_ports {sseg[7]}]
# enable
set_property -dict {PACKAGE_PIN J17 IOSTANDARD LVCMOS33} [get_ports {an[0]}]
set_property -dict {PACKAGE_PIN J18 IOSTANDARD LVCMOS33} [get_ports {an[1]}]
set_property -dict {PACKAGE_PIN T9 IOSTANDARD LVCMOS33} [get_ports {an[2]}]
set_property -dict {PACKAGE_PIN J14 IOSTANDARD LVCMOS33} [get_ports {an[3]}]
set_property -dict {PACKAGE_PIN P14 IOSTANDARD LVCMOS33} [get_ports {an[4]}]
set_property -dict {PACKAGE_PIN T14 IOSTANDARD LVCMOS33} [get_ports {an[5]}]
set_property -dict {PACKAGE_PIN K2 IOSTANDARD LVCMOS33} [get_ports {an[6]}]
set_property -dict {PACKAGE_PIN U13 IOSTANDARD LVCMOS33} [get_ports {an[7]}]


#====================================================================================================
# PWM Audio Amplifier
#====================================================================================================
set_property -dict {PACKAGE_PIN A11 IOSTANDARD LVCMOS33} [get_ports audio_pdm]
set_property -dict {PACKAGE_PIN D12 IOSTANDARD LVCMOS33} [get_ports audio_on]


#====================================================================================================
# USB-RS232 Interface
#====================================================================================================
set_property -dict {PACKAGE_PIN D4 IOSTANDARD LVCMOS33} [get_ports tx]
set_property -dict {PACKAGE_PIN C4 IOSTANDARD LVCMOS33} [get_ports rx]
# ************CTS/RTS not used
#set_property -dict { PACKAGE_PIN D3    IOSTANDARD LVCMOS33 } [get_ports { uart_cts }]; #IO_L12N_T1_MRCC_35 Sch=uart_cts
#set_property -dict { PACKAGE_PIN E5    IOSTANDARD LVCMOS33 } [get_ports { uart_rts }]; #IO_L5N_T0_AD13N_35 Sch=uart_rts

#====================================================================================================
# USB HID (PS/2)
#====================================================================================================
set_property -dict {PACKAGE_PIN F4 IOSTANDARD LVCMOS33} [get_ports ps2c]
set_property -dict {PACKAGE_PIN B2 IOSTANDARD LVCMOS33} [get_ports ps2d]


#====================================================================================================
# I2C temperature sensor
# tmp_int / tmp_ct signals are not used
#====================================================================================================
set_property -dict {PACKAGE_PIN C14 IOSTANDARD LVCMOS33} [get_ports tmp_i2c_scl]
set_property -dict {PACKAGE_PIN C15 IOSTANDARD LVCMOS33} [get_ports tmp_i2c_sda]
# ************ tmp_int / tmp_ct not used
#set_property -dict { PACKAGE_PIN D13   IOSTANDARD LVCMOS33 } [get_ports { tmp_int }]; #IO_L6N_T0_VREF_15 Sch=tmp_int
#set_property -dict { PACKAGE_PIN B14   IOSTANDARD LVCMOS33 } [get_ports { tmp_ct }]; #IO_L2N_T0_AD8N_15 Sch=tmp_ct


#====================================================================================================
# SPI Accelerometer
# aclInt1 / aclInt2 signals are not used
#====================================================================================================
set_property -dict {PACKAGE_PIN E15 IOSTANDARD LVCMOS33} [get_ports acl_miso]
set_property -dict {PACKAGE_PIN F14 IOSTANDARD LVCMOS33} [get_ports acl_mosi]
set_property -dict {PACKAGE_PIN F15 IOSTANDARD LVCMOS33} [get_ports acl_sclk]
set_property -dict {PACKAGE_PIN D15 IOSTANDARD LVCMOS33} [get_ports acl_ss_n]
# *********** aclInt1 / aclInt2 signals are not used
#set_property -dict { PACKAGE_PIN B13   IOSTANDARD LVCMOS33 } [get_ports { aclInt1[1] }]; #IO_L2P_T0_AD8P_15 Sch=acl_int[1]
#set_property -dict { PACKAGE_PIN C16   IOSTANDARD LVCMOS33 } [get_ports { aclInt1[2] }]; #IO_L20P_T3_A20_15 Sch=acl_int[2]


#====================================================================================================
# VGA Port
#====================================================================================================
set_property -dict {PACKAGE_PIN B11 IOSTANDARD LVCMOS33} [get_ports hsync]
set_property -dict {PACKAGE_PIN B12 IOSTANDARD LVCMOS33} [get_ports vsync]
set_property -dict {PACKAGE_PIN A3 IOSTANDARD LVCMOS33} [get_ports {rgb[8]}]
set_property -dict {PACKAGE_PIN B4 IOSTANDARD LVCMOS33} [get_ports {rgb[9]}]
set_property -dict {PACKAGE_PIN C5 IOSTANDARD LVCMOS33} [get_ports {rgb[10]}]
set_property -dict {PACKAGE_PIN A4 IOSTANDARD LVCMOS33} [get_ports {rgb[11]}]
set_property -dict {PACKAGE_PIN C6 IOSTANDARD LVCMOS33} [get_ports {rgb[4]}]
set_property -dict {PACKAGE_PIN A5 IOSTANDARD LVCMOS33} [get_ports {rgb[5]}]
set_property -dict {PACKAGE_PIN B6 IOSTANDARD LVCMOS33} [get_ports {rgb[6]}]
set_property -dict {PACKAGE_PIN A6 IOSTANDARD LVCMOS33} [get_ports {rgb[7]}]
set_property -dict {PACKAGE_PIN B7 IOSTANDARD LVCMOS33} [get_ports {rgb[0]}]
set_property -dict {PACKAGE_PIN C7 IOSTANDARD LVCMOS33} [get_ports {rgb[1]}]
set_property -dict {PACKAGE_PIN D7 IOSTANDARD LVCMOS33} [get_ports {rgb[2]}]
set_property -dict {PACKAGE_PIN D8 IOSTANDARD LVCMOS33} [get_ports {rgb[3]}]

#====================================================================================================
#micro SD card Connector
#====================================================================================================
set_property -dict {PACKAGE_PIN E2 IOSTANDARD LVCMOS33} [get_ports sd_reset]
set_property -dict {PACKAGE_PIN B1 IOSTANDARD LVCMOS33} [get_ports sd_sclk]
set_property -dict {PACKAGE_PIN C1 IOSTANDARD LVCMOS33} [get_ports sd_mosi]
set_property -dict {PACKAGE_PIN C2 IOSTANDARD LVCMOS33} [get_ports sd_miso]
#set_property -dict { PACKAGE_PIN E1    IOSTANDARD LVCMOS33 } [get_ports { SD_DAT[1] }]; #IO_L18N_T2_35 Sch=sd_dat[1]
#set_property -dict { PACKAGE_PIN F1    IOSTANDARD LVCMOS33 } [get_ports { SD_DAT[2] }]; #IO_L18P_T2_35 Sch=sd_dat[2]
set_property -dict {PACKAGE_PIN D2 IOSTANDARD LVCMOS33} [get_ports sd_ss_n]
#set_property -dict { PACKAGE_PIN A1    IOSTANDARD LVCMOS33 } [get_ports { SD_CD }]; #IO_L9N_T1_DQS_AD7N_35 Sch=sd_cd  //** card detect not used

#set_property -dict { PACKAGE_PIN E2    IOSTANDARD LVCMOS33 } [get_ports { SD_RESET }]; #IO_L14P_T2_SRCC_35 Sch=sd_reset
#set_property -dict { PACKAGE_PIN A1    IOSTANDARD LVCMOS33 } [get_ports { SD_CD }]; #IO_L9N_T1_DQS_AD7N_35 Sch=sd_cd
#set_property -dict { PACKAGE_PIN B1    IOSTANDARD LVCMOS33 } [get_ports { SD_SCK }]; #IO_L9P_T1_DQS_AD7P_35 Sch=sd_sck
#set_property -dict { PACKAGE_PIN C1    IOSTANDARD LVCMOS33 } [get_ports { SD_CMD }]; #IO_L16N_T2_35 Sch=sd_cmd
#set_property -dict { PACKAGE_PIN C2    IOSTANDARD LVCMOS33 } [get_ports { SD_DAT[0] }]; #IO_L16P_T2_35 Sch=sd_dat[0]
#set_property -dict { PACKAGE_PIN E1    IOSTANDARD LVCMOS33 } [get_ports { SD_DAT[1] }]; #IO_L18N_T2_35 Sch=sd_dat[1]
#set_property -dict { PACKAGE_PIN F1    IOSTANDARD LVCMOS33 } [get_ports { SD_DAT[2] }]; #IO_L18P_T2_35 Sch=sd_dat[2]
#set_property -dict { PACKAGE_PIN D2    IOSTANDARD LVCMOS33 } [get_ports { SD_DAT[3] }]; #IO_L14N_T2_SRCC_35 Sch=sd_dat[3]
#-----------SPI mode pin map-------------------------------------------------------------------
#Clock	 [SCK]
#CMD/DI	 [MOSI]
#DAT0/D0 [MISO]
#DAT1/IRQ Unused/I
#DAT2/NC Unused
#DAT3/CS [SS]
#VSS1	 Ground
#Vss2	 Ground
#Vdd	 voltage
#===============================================================================================

#===============================================================================================
# PMOD xadc (JXADC)
# originally with LVDS (error for adcn/p[3]); not LVCOMS33
#===============================================================================================
set_property -dict {PACKAGE_PIN A14 IOSTANDARD LVCMOS33} [get_ports {adc_n[0]}]
set_property -dict {PACKAGE_PIN A13 IOSTANDARD LVCMOS33} [get_ports {adc_p[0]}]
set_property -dict {PACKAGE_PIN A16 IOSTANDARD LVCMOS33} [get_ports {adc_n[1]}]
set_property -dict {PACKAGE_PIN A15 IOSTANDARD LVCMOS33} [get_ports {adc_p[1]}]
set_property -dict {PACKAGE_PIN B17 IOSTANDARD LVCMOS33} [get_ports {adc_n[2]}]
set_property -dict {PACKAGE_PIN B16 IOSTANDARD LVCMOS33} [get_ports {adc_p[2]}]
set_property -dict {PACKAGE_PIN A18 IOSTANDARD LVCMOS33} [get_ports {adc_n[3]}]
set_property -dict {PACKAGE_PIN B18 IOSTANDARD LVCMOS33} [get_ports {adc_p[3]}]



#====================================================================================================
#Pmod Header JA
# 4 out of 10 pins are for Vcc/Gnd
# use two signals (for top and bottom rows) to maintain pin#
#====================================================================================================
set_property -dict {PACKAGE_PIN C17 IOSTANDARD LVCMOS33} [get_ports {ja_top[1]}]
set_property -dict {PACKAGE_PIN D18 IOSTANDARD LVCMOS33} [get_ports {ja_top[2]}]
set_property -dict {PACKAGE_PIN E18 IOSTANDARD LVCMOS33} [get_ports {ja_top[3]}]
set_property -dict {PACKAGE_PIN G17 IOSTANDARD LVCMOS33} [get_ports {ja_top[4]}]
set_property -dict {PACKAGE_PIN D17 IOSTANDARD LVCMOS33} [get_ports {ja_btm[7]}]
set_property -dict {PACKAGE_PIN E17 IOSTANDARD LVCMOS33} [get_ports {ja_btm[8]}]
set_property -dict {PACKAGE_PIN F18 IOSTANDARD LVCMOS33} [get_ports {ja_btm[9]}]
set_property -dict {PACKAGE_PIN G18 IOSTANDARD LVCMOS33} [get_ports {ja_btm[10]}]

#====================================================================================================
#Pmod Header JB
# 4 out of 10 pins are for Vcc/Gnd
# use two signals (for top and bottom rows) to maintain pin#
#====================================================================================================
set_property -dict {PACKAGE_PIN D14 IOSTANDARD LVCMOS33} [get_ports {jb_top[1]}]
set_property -dict {PACKAGE_PIN F16 IOSTANDARD LVCMOS33} [get_ports {jb_top[2]}]
set_property -dict {PACKAGE_PIN G16 IOSTANDARD LVCMOS33} [get_ports {jb_top[3]}]
set_property -dict {PACKAGE_PIN H14 IOSTANDARD LVCMOS33} [get_ports {jb_top[4]}]
set_property -dict {PACKAGE_PIN E16 IOSTANDARD LVCMOS33} [get_ports {jb_btm[7]}]
set_property -dict {PACKAGE_PIN F13 IOSTANDARD LVCMOS33} [get_ports {jb_btm[8]}]
set_property -dict {PACKAGE_PIN G13 IOSTANDARD LVCMOS33} [get_ports {jb_btm[9]}]
set_property -dict {PACKAGE_PIN H16 IOSTANDARD LVCMOS33} [get_ports {jb_btm[10]}]

#====================================================================================================
#Pmod Header JC
# 4 out of 10 pins are for Vcc/Gnd
# use two signals (for top and bottom rows) to maintain pin#
#====================================================================================================
set_property -dict {PACKAGE_PIN K1 IOSTANDARD LVCMOS33} [get_ports {jc_top[1]}]
set_property -dict {PACKAGE_PIN F6 IOSTANDARD LVCMOS33} [get_ports {jc_top[2]}]
set_property -dict {PACKAGE_PIN J2 IOSTANDARD LVCMOS33} [get_ports {jc_top[3]}]
set_property -dict {PACKAGE_PIN G6 IOSTANDARD LVCMOS33} [get_ports {jc_top[4]}]
set_property -dict {PACKAGE_PIN E7 IOSTANDARD LVCMOS33} [get_ports {jc_btm[7]}]
set_property -dict {PACKAGE_PIN J3 IOSTANDARD LVCMOS33} [get_ports {jc_btm[8]}]
set_property -dict {PACKAGE_PIN J4 IOSTANDARD LVCMOS33} [get_ports {jc_btm[9]}]
set_property -dict {PACKAGE_PIN E6 IOSTANDARD LVCMOS33} [get_ports {jc_btm[10]}]


#====================================================================================================
#Pmod Header JD
# 4 out of 10 pins are for Vcc/Gnd
# use two signals (for top and bottom rows) to maintain pin#
#====================================================================================================
set_property -dict {PACKAGE_PIN H4 IOSTANDARD LVCMOS33} [get_ports {jd_top[1]}]
set_property -dict {PACKAGE_PIN H1 IOSTANDARD LVCMOS33} [get_ports {jd_top[2]}]
set_property -dict {PACKAGE_PIN G1 IOSTANDARD LVCMOS33} [get_ports {jd_top[3]}]
set_property -dict {PACKAGE_PIN G3 IOSTANDARD LVCMOS33} [get_ports {jd_top[4]}]
set_property -dict {PACKAGE_PIN H2 IOSTANDARD LVCMOS33} [get_ports {jd_btm[7]}]
set_property -dict {PACKAGE_PIN G4 IOSTANDARD LVCMOS33} [get_ports {jd_btm[8]}]
set_property -dict {PACKAGE_PIN G2 IOSTANDARD LVCMOS33} [get_ports {jd_btm[9]}]
set_property -dict {PACKAGE_PIN F3 IOSTANDARD LVCMOS33} [get_ports {jd_btm[10]}]

#====================================================================================================
# **** not used in the FPro system
#====================================================================================================

##Omnidirectional Microphone
#set_property -dict { PACKAGE_PIN J5    IOSTANDARD LVCMOS33 } [get_ports { M_CLK }]; #IO_25_35 Sch=m_clk
#set_property -dict { PACKAGE_PIN H5    IOSTANDARD LVCMOS33 } [get_ports { M_DATA }]; #IO_L24N_T3_35 Sch=m_data
#set_property -dict { PACKAGE_PIN F5    IOSTANDARD LVCMOS33 } [get_ports { M_LRSEL }]; #IO_0_35 Sch=m_lrsel


##Quad SPI Flash

#set_property -dict { PACKAGE_PIN K17   IOSTANDARD LVCMOS33 } [get_ports { QSPI_DQ[0] }]; #IO_L1P_T0_D00_MOSI_14 Sch=qspi_dq[0]
#set_property -dict { PACKAGE_PIN K18   IOSTANDARD LVCMOS33 } [get_ports { QSPI_DQ[1] }]; #IO_L1N_T0_D01_DIN_14 Sch=qspi_dq[1]
#set_property -dict { PACKAGE_PIN L14   IOSTANDARD LVCMOS33 } [get_ports { QSPI_DQ[2] }]; #IO_L2P_T0_D02_14 Sch=qspi_dq[2]
#set_property -dict { PACKAGE_PIN M14   IOSTANDARD LVCMOS33 } [get_ports { QSPI_DQ[3] }]; #IO_L2N_T0_D03_14 Sch=qspi_dq[3]
#set_property -dict { PACKAGE_PIN L13   IOSTANDARD LVCMOS33 } [get_ports { QSPI_CSN }]; #IO_L6P_T0_FCS_B_14 Sch=qspi_csn


##SMSC Ethernet PHY

#set_property -dict { PACKAGE_PIN C9    IOSTANDARD LVCMOS33 } [get_ports { ETH_MDC }]; #IO_L11P_T1_SRCC_16 Sch=eth_mdc
#set_property -dict { PACKAGE_PIN A9    IOSTANDARD LVCMOS33 } [get_ports { ETH_MDIO }]; #IO_L14N_T2_SRCC_16 Sch=eth_mdio
#set_property -dict { PACKAGE_PIN B3    IOSTANDARD LVCMOS33 } [get_ports { ETH_RSTN }]; #IO_L10P_T1_AD15P_35 Sch=eth_rstn
#set_property -dict { PACKAGE_PIN D9    IOSTANDARD LVCMOS33 } [get_ports { ETH_CRSDV }]; #IO_L6N_T0_VREF_16 Sch=eth_crsdv
#set_property -dict { PACKAGE_PIN C10   IOSTANDARD LVCMOS33 } [get_ports { ETH_RXERR }]; #IO_L13N_T2_MRCC_16 Sch=eth_rxerr
#set_property -dict { PACKAGE_PIN C11   IOSTANDARD LVCMOS33 } [get_ports { ETH_RXD[0] }]; #IO_L13P_T2_MRCC_16 Sch=eth_rxd[0]
#set_property -dict { PACKAGE_PIN D10   IOSTANDARD LVCMOS33 } [get_ports { ETH_RXD[1] }]; #IO_L19N_T3_VREF_16 Sch=eth_rxd[1]
#set_property -dict { PACKAGE_PIN B9    IOSTANDARD LVCMOS33 } [get_ports { ETH_TXEN }]; #IO_L11N_T1_SRCC_16 Sch=eth_txen
#set_property -dict { PACKAGE_PIN A10   IOSTANDARD LVCMOS33 } [get_ports { ETH_TXD[0] }]; #IO_L14P_T2_SRCC_16 Sch=eth_txd[0]
#set_property -dict { PACKAGE_PIN A8    IOSTANDARD LVCMOS33 } [get_ports { ETH_TXD[1] }]; #IO_L12N_T1_MRCC_16 Sch=eth_txd[1]
#set_property -dict { PACKAGE_PIN D5    IOSTANDARD LVCMOS33 } [get_ports { ETH_REFCLK }]; #IO_L11P_T1_SRCC_35 Sch=eth_refclk
#set_property -dict { PACKAGE_PIN B8    IOSTANDARD LVCMOS33 } [get_ports { ETH_INTN }]; #IO_L12P_T1_MRCC_16 Sch=eth_intn



#====================================================================================================
#====================================================================================================
#                                               Nexy 3
#====================================================================================================
#====================================================================================================

## This file is a general .xdc for the Nexys4 DDR Rev. C
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

#======================================================================================================================
# Clock signal
#======================================================================================================================
set_property -dict {PACKAGE_PIN E3 IOSTANDARD LVCMOS33} [get_ports CLK100]
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports CLK100]

#======================================================================================================================
# To facilitate Quad-SPI flash programming 
#======================================================================================================================
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]


#======================================================================================================================
#Switches
#======================================================================================================================
set_property -dict {PACKAGE_PIN J15 IOSTANDARD LVCMOS33} [get_ports {SW[0]}]
set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports {SW[1]}]
set_property -dict {PACKAGE_PIN M13 IOSTANDARD LVCMOS33} [get_ports {SW[2]}]
set_property -dict {PACKAGE_PIN R15 IOSTANDARD LVCMOS33} [get_ports {SW[3]}]
#set_property -dict {PACKAGE_PIN R17 IOSTANDARD LVCMOS33} [get_ports {SW[4]}]
#set_property -dict {PACKAGE_PIN T18 IOSTANDARD LVCMOS33} [get_ports {SW[5]}]
#set_property -dict {PACKAGE_PIN U18 IOSTANDARD LVCMOS33} [get_ports {SW[6]}]
#set_property -dict {PACKAGE_PIN R13 IOSTANDARD LVCMOS33} [get_ports {SW[7]}]
#set_property -dict {PACKAGE_PIN T8 IOSTANDARD LVCMOS33} [get_ports {SW[8]}]
#set_property -dict {PACKAGE_PIN U8 IOSTANDARD LVCMOS33} [get_ports {SW[9]}]
#set_property -dict {PACKAGE_PIN R16 IOSTANDARD LVCMOS33} [get_ports {SW[10]}]
#set_property -dict {PACKAGE_PIN T13 IOSTANDARD LVCMOS33} [get_ports {SW[11]}]
#set_property -dict {PACKAGE_PIN H6 IOSTANDARD LVCMOS33} [get_ports {SW[12]}]
#set_property -dict {PACKAGE_PIN U12 IOSTANDARD LVCMOS33} [get_ports {SW[13]}]
#set_property -dict {PACKAGE_PIN U11 IOSTANDARD LVCMOS33} [get_ports {SW[14]}]
#set_property -dict {PACKAGE_PIN V10 IOSTANDARD LVCMOS33} [get_ports {SW[15]}]

#======================================================================================================================
#Buttons
#======================================================================================================================
# ***** CPU_reset button; active low
set_property -dict {PACKAGE_PIN C12 IOSTANDARD LVCMOS33} [get_ports RST_n]
# ***** Other buttons; active high
# ***** btn(0): btnu;  btn(1): btnr;  btn(2): btnd; btn(3): btnl;  btn(4): btnc;
set_property -dict {PACKAGE_PIN N17 IOSTANDARD LVCMOS33} [get_ports {BTN[4]}]
set_property -dict {PACKAGE_PIN M18 IOSTANDARD LVCMOS33} [get_ports {BTN[0]}]
set_property -dict {PACKAGE_PIN P17 IOSTANDARD LVCMOS33} [get_ports {BTN[3]}]
set_property -dict {PACKAGE_PIN M17 IOSTANDARD LVCMOS33} [get_ports {BTN[1]}]
set_property -dict {PACKAGE_PIN P18 IOSTANDARD LVCMOS33} [get_ports {BTN[2]}]

#======================================================================================================================
# discrete LEDs
#======================================================================================================================
set_property -dict {PACKAGE_PIN H17 IOSTANDARD LVCMOS33} [get_ports {LED[0]}]
set_property -dict {PACKAGE_PIN K15 IOSTANDARD LVCMOS33} [get_ports {LED[1]}]
set_property -dict {PACKAGE_PIN J13 IOSTANDARD LVCMOS33} [get_ports {LED[2]}]
set_property -dict {PACKAGE_PIN N14 IOSTANDARD LVCMOS33} [get_ports {LED[3]}]
set_property -dict {PACKAGE_PIN R18 IOSTANDARD LVCMOS33} [get_ports {LED[4]}]
set_property -dict {PACKAGE_PIN V17 IOSTANDARD LVCMOS33} [get_ports {LED[5]}]
set_property -dict {PACKAGE_PIN U17 IOSTANDARD LVCMOS33} [get_ports {LED[6]}]
set_property -dict {PACKAGE_PIN U16 IOSTANDARD LVCMOS33} [get_ports {LED[7]}]
set_property -dict {PACKAGE_PIN V16 IOSTANDARD LVCMOS33} [get_ports {LED[8]}]
set_property -dict {PACKAGE_PIN T15 IOSTANDARD LVCMOS33} [get_ports {LED[9]}]
set_property -dict {PACKAGE_PIN U14 IOSTANDARD LVCMOS33} [get_ports {LED[10]}]
set_property -dict {PACKAGE_PIN T16 IOSTANDARD LVCMOS33} [get_ports {LED[11]}]
set_property -dict {PACKAGE_PIN V15 IOSTANDARD LVCMOS33} [get_ports {LED[12]}]
set_property -dict {PACKAGE_PIN V14 IOSTANDARD LVCMOS33} [get_ports {LED[13]}]
set_property -dict {PACKAGE_PIN V12 IOSTANDARD LVCMOS33} [get_ports {LED[14]}]
set_property -dict {PACKAGE_PIN V11 IOSTANDARD LVCMOS33} [get_ports {LED[15]}]

#======================================================================================================================
# tri-color LEDs
#======================================================================================================================
#set_property -dict {PACKAGE_PIN R12 IOSTANDARD LVCMOS33} [get_ports {rgb_led1[0]}]
#set_property -dict {PACKAGE_PIN M16 IOSTANDARD LVCMOS33} [get_ports {rgb_led1[1]}]
#set_property -dict {PACKAGE_PIN N15 IOSTANDARD LVCMOS33} [get_ports {rgb_led1[2]}]
#set_property -dict {PACKAGE_PIN G14 IOSTANDARD LVCMOS33} [get_ports {rgb_led2[0]}]
#set_property -dict {PACKAGE_PIN R11 IOSTANDARD LVCMOS33} [get_ports {rgb_led2[1]}]
#set_property -dict {PACKAGE_PIN N16 IOSTANDARD LVCMOS33} [get_ports {rgb_led2[2]}]

#VGA Connector

set_property -dict { PACKAGE_PIN A3    IOSTANDARD LVCMOS33 } [get_ports { VGA_R[0] }]; #IO_L8N_T1_AD14N_35 Sch=vga_r[0]
set_property -dict { PACKAGE_PIN B4    IOSTANDARD LVCMOS33 } [get_ports { VGA_R[1] }]; #IO_L7N_T1_AD6N_35 Sch=vga_r[1]
set_property -dict { PACKAGE_PIN C5    IOSTANDARD LVCMOS33 } [get_ports { VGA_R[2] }]; #IO_L1N_T0_AD4N_35 Sch=vga_r[2]
set_property -dict { PACKAGE_PIN A4    IOSTANDARD LVCMOS33 } [get_ports { VGA_R[3] }]; #IO_L8P_T1_AD14P_35 Sch=vga_r[3]
set_property -dict { PACKAGE_PIN C6    IOSTANDARD LVCMOS33 } [get_ports { VGA_G[0] }]; #IO_L1P_T0_AD4P_35 Sch=vga_g[0]
set_property -dict { PACKAGE_PIN A5    IOSTANDARD LVCMOS33 } [get_ports { VGA_G[1] }]; #IO_L3N_T0_DQS_AD5N_35 Sch=vga_g[1]
set_property -dict { PACKAGE_PIN B6    IOSTANDARD LVCMOS33 } [get_ports { VGA_G[2] }]; #IO_L2N_T0_AD12N_35 Sch=vga_g[2]
set_property -dict { PACKAGE_PIN A6    IOSTANDARD LVCMOS33 } [get_ports { VGA_G[3] }]; #IO_L3P_T0_DQS_AD5P_35 Sch=vga_g[3]
set_property -dict { PACKAGE_PIN B7    IOSTANDARD LVCMOS33 } [get_ports { VGA_B[0] }]; #IO_L2P_T0_AD12P_35 Sch=vga_b[0]
set_property -dict { PACKAGE_PIN C7    IOSTANDARD LVCMOS33 } [get_ports { VGA_B[1] }]; #IO_L4N_T0_35 Sch=vga_b[1]
set_property -dict { PACKAGE_PIN D7    IOSTANDARD LVCMOS33 } [get_ports { VGA_B[2] }]; #IO_L6N_T0_VREF_35 Sch=vga_b[2]
set_property -dict { PACKAGE_PIN D8    IOSTANDARD LVCMOS33 } [get_ports { VGA_B[3] }]; #IO_L4P_T0_35 Sch=vga_b[3]
set_property -dict { PACKAGE_PIN B11   IOSTANDARD LVCMOS33 } [get_ports { VGA_HS }]; #IO_L4P_T0_15 Sch=vga_hs
set_property -dict { PACKAGE_PIN B12   IOSTANDARD LVCMOS33 } [get_ports { VGA_VS }]; #IO_L3N_T0_DQS_AD1N_15 Sch=vga_vs

#======================================================================================================================
#7 segment display
#======================================================================================================================
set_property -dict {PACKAGE_PIN T10 IOSTANDARD LVCMOS33} [get_ports {nSEG[0]}]
set_property -dict {PACKAGE_PIN R10 IOSTANDARD LVCMOS33} [get_ports {nSEG[1]}]
set_property -dict {PACKAGE_PIN K16 IOSTANDARD LVCMOS33} [get_ports {nSEG[2]}]
set_property -dict {PACKAGE_PIN K13 IOSTANDARD LVCMOS33} [get_ports {nSEG[3]}]
set_property -dict {PACKAGE_PIN P15 IOSTANDARD LVCMOS33} [get_ports {nSEG[4]}]
set_property -dict {PACKAGE_PIN T11 IOSTANDARD LVCMOS33} [get_ports {nSEG[5]}]
set_property -dict {PACKAGE_PIN L18 IOSTANDARD LVCMOS33} [get_ports {nSEG[6]}]
#decimal point
set_property -dict {PACKAGE_PIN H15 IOSTANDARD LVCMOS33} [get_ports {nSEG[7]}]
# enable
set_property -dict {PACKAGE_PIN J17 IOSTANDARD LVCMOS33} [get_ports {nAN[0]}]
set_property -dict {PACKAGE_PIN J18 IOSTANDARD LVCMOS33} [get_ports {nAN[1]}]
set_property -dict {PACKAGE_PIN T9 IOSTANDARD LVCMOS33} [get_ports {nAN[2]}]
set_property -dict {PACKAGE_PIN J14 IOSTANDARD LVCMOS33} [get_ports {nAN[3]}]
set_property -dict {PACKAGE_PIN P14 IOSTANDARD LVCMOS33} [get_ports {nAN[4]}]
set_property -dict {PACKAGE_PIN T14 IOSTANDARD LVCMOS33} [get_ports {nAN[5]}]
set_property -dict {PACKAGE_PIN K2 IOSTANDARD LVCMOS33} [get_ports {nAN[6]}]
set_property -dict {PACKAGE_PIN U13 IOSTANDARD LVCMOS33} [get_ports {nAN[7]}]


#====================================================================================================
# PWM Audio Amplifier
#====================================================================================================
set_property -dict {PACKAGE_PIN A11 IOSTANDARD LVCMOS33} [get_ports audio_pdm]
set_property -dict {PACKAGE_PIN D12 IOSTANDARD LVCMOS33} [get_ports audio_on]


#====================================================================================================
# USB-RS232 Interface
#====================================================================================================
set_property -dict {PACKAGE_PIN D4 IOSTANDARD LVCMOS33} [get_ports TXD]
set_property -dict {PACKAGE_PIN C4 IOSTANDARD LVCMOS33} [get_ports RXD]
# ************CTS/RTS not used
#set_property -dict { PACKAGE_PIN D3    IOSTANDARD LVCMOS33 } [get_ports { uart_cts }]; #IO_L12N_T1_MRCC_35 Sch=uart_cts
#set_property -dict { PACKAGE_PIN E5    IOSTANDARD LVCMOS33 } [get_ports { uart_rts }]; #IO_L5N_T0_AD13N_35 Sch=uart_rts

#====================================================================================================
# USB HID (PS/2)
#====================================================================================================
set_property -dict {PACKAGE_PIN F4 IOSTANDARD LVCMOS33} [get_ports PS2CLK_KB]
set_property -dict {PACKAGE_PIN B2 IOSTANDARD LVCMOS33} [get_ports PS2DATA_KB]
#set_property -dict {PACKAGE_PIN F4 IOSTANDARD LVCMOS33} [get_ports PS2CLK_MS]
#set_property -dict {PACKAGE_PIN B2 IOSTANDARD LVCMOS33} [get_ports PS2DATA_MS]

#====================================================================================================
# I2C temperature sensor
# tmp_int / tmp_ct signals are not used
#====================================================================================================
set_property -dict {PACKAGE_PIN C14 IOSTANDARD LVCMOS33} [get_ports tmp_i2c_scl]
set_property -dict {PACKAGE_PIN C15 IOSTANDARD LVCMOS33} [get_ports tmp_i2c_sda]
# ************ tmp_int / tmp_ct not used
#set_property -dict { PACKAGE_PIN D13   IOSTANDARD LVCMOS33 } [get_ports { tmp_int }]; #IO_L6N_T0_VREF_15 Sch=tmp_int
#set_property -dict { PACKAGE_PIN B14   IOSTANDARD LVCMOS33 } [get_ports { tmp_ct }]; #IO_L2N_T0_AD8N_15 Sch=tmp_ct


#====================================================================================================
# SPI Accelerometer
# aclInt1 / aclInt2 signals are not used
#====================================================================================================
set_property -dict {PACKAGE_PIN E15 IOSTANDARD LVCMOS33} [get_ports acl_miso]
set_property -dict {PACKAGE_PIN F14 IOSTANDARD LVCMOS33} [get_ports acl_mosi]
set_property -dict {PACKAGE_PIN F15 IOSTANDARD LVCMOS33} [get_ports acl_sclk]
set_property -dict {PACKAGE_PIN D15 IOSTANDARD LVCMOS33} [get_ports acl_ss_n]
# *********** aclInt1 / aclInt2 signals are not used
#set_property -dict { PACKAGE_PIN B13   IOSTANDARD LVCMOS33 } [get_ports { aclInt1[1] }]; #IO_L2P_T0_AD8P_15 Sch=acl_int[1]
#set_property -dict { PACKAGE_PIN C16   IOSTANDARD LVCMOS33 } [get_ports { aclInt1[2] }]; #IO_L20P_T3_A20_15 Sch=acl_int[2]


#====================================================================================================
# VGA Port
#====================================================================================================
set_property -dict {PACKAGE_PIN B11 IOSTANDARD LVCMOS33} [get_ports hsync]
set_property -dict {PACKAGE_PIN B12 IOSTANDARD LVCMOS33} [get_ports vsync]
set_property -dict {PACKAGE_PIN A3 IOSTANDARD LVCMOS33} [get_ports {rgb[8]}]
set_property -dict {PACKAGE_PIN B4 IOSTANDARD LVCMOS33} [get_ports {rgb[9]}]
set_property -dict {PACKAGE_PIN C5 IOSTANDARD LVCMOS33} [get_ports {rgb[10]}]
set_property -dict {PACKAGE_PIN A4 IOSTANDARD LVCMOS33} [get_ports {rgb[11]}]
set_property -dict {PACKAGE_PIN C6 IOSTANDARD LVCMOS33} [get_ports {rgb[4]}]
set_property -dict {PACKAGE_PIN A5 IOSTANDARD LVCMOS33} [get_ports {rgb[5]}]
set_property -dict {PACKAGE_PIN B6 IOSTANDARD LVCMOS33} [get_ports {rgb[6]}]
set_property -dict {PACKAGE_PIN A6 IOSTANDARD LVCMOS33} [get_ports {rgb[7]}]
set_property -dict {PACKAGE_PIN B7 IOSTANDARD LVCMOS33} [get_ports {rgb[0]}]
set_property -dict {PACKAGE_PIN C7 IOSTANDARD LVCMOS33} [get_ports {rgb[1]}]
set_property -dict {PACKAGE_PIN D7 IOSTANDARD LVCMOS33} [get_ports {rgb[2]}]
set_property -dict {PACKAGE_PIN D8 IOSTANDARD LVCMOS33} [get_ports {rgb[3]}]

#====================================================================================================
#micro SD card Connector
#====================================================================================================
set_property -dict {PACKAGE_PIN E2 IOSTANDARD LVCMOS33} [get_ports sd_reset]
set_property -dict {PACKAGE_PIN B1 IOSTANDARD LVCMOS33} [get_ports sd_sclk]
set_property -dict {PACKAGE_PIN C1 IOSTANDARD LVCMOS33} [get_ports sd_mosi]
set_property -dict {PACKAGE_PIN C2 IOSTANDARD LVCMOS33} [get_ports sd_miso]
#set_property -dict { PACKAGE_PIN E1    IOSTANDARD LVCMOS33 } [get_ports { SD_DAT[1] }]; #IO_L18N_T2_35 Sch=sd_dat[1]
#set_property -dict { PACKAGE_PIN F1    IOSTANDARD LVCMOS33 } [get_ports { SD_DAT[2] }]; #IO_L18P_T2_35 Sch=sd_dat[2]
set_property -dict {PACKAGE_PIN D2 IOSTANDARD LVCMOS33} [get_ports sd_ss_n]
#set_property -dict { PACKAGE_PIN A1    IOSTANDARD LVCMOS33 } [get_ports { SD_CD }]; #IO_L9N_T1_DQS_AD7N_35 Sch=sd_cd  //** card detect not used

#set_property -dict { PACKAGE_PIN E2    IOSTANDARD LVCMOS33 } [get_ports { SD_RESET }]; #IO_L14P_T2_SRCC_35 Sch=sd_reset
#set_property -dict { PACKAGE_PIN A1    IOSTANDARD LVCMOS33 } [get_ports { SD_CD }]; #IO_L9N_T1_DQS_AD7N_35 Sch=sd_cd
#set_property -dict { PACKAGE_PIN B1    IOSTANDARD LVCMOS33 } [get_ports { SD_SCK }]; #IO_L9P_T1_DQS_AD7P_35 Sch=sd_sck
#set_property -dict { PACKAGE_PIN C1    IOSTANDARD LVCMOS33 } [get_ports { SD_CMD }]; #IO_L16N_T2_35 Sch=sd_cmd
#set_property -dict { PACKAGE_PIN C2    IOSTANDARD LVCMOS33 } [get_ports { SD_DAT[0] }]; #IO_L16P_T2_35 Sch=sd_dat[0]
#set_property -dict { PACKAGE_PIN E1    IOSTANDARD LVCMOS33 } [get_ports { SD_DAT[1] }]; #IO_L18N_T2_35 Sch=sd_dat[1]
#set_property -dict { PACKAGE_PIN F1    IOSTANDARD LVCMOS33 } [get_ports { SD_DAT[2] }]; #IO_L18P_T2_35 Sch=sd_dat[2]
#set_property -dict { PACKAGE_PIN D2    IOSTANDARD LVCMOS33 } [get_ports { SD_DAT[3] }]; #IO_L14N_T2_SRCC_35 Sch=sd_dat[3]
#-----------SPI mode pin map-------------------------------------------------------------------
#Clock	 [SCK]
#CMD/DI	 [MOSI]
#DAT0/D0 [MISO]
#DAT1/IRQ Unused/I
#DAT2/NC Unused
#DAT3/CS [SS]
#VSS1	 Ground
#Vss2	 Ground
#Vdd	 voltage
#===============================================================================================

#===============================================================================================
# PMOD xadc (JXADC)
# originally with LVDS (error for adcn/p[3]); not LVCOMS33
#===============================================================================================
set_property -dict {PACKAGE_PIN A14 IOSTANDARD LVCMOS33} [get_ports {adc_n[0]}]
set_property -dict {PACKAGE_PIN A13 IOSTANDARD LVCMOS33} [get_ports {adc_p[0]}]
set_property -dict {PACKAGE_PIN A16 IOSTANDARD LVCMOS33} [get_ports {adc_n[1]}]
set_property -dict {PACKAGE_PIN A15 IOSTANDARD LVCMOS33} [get_ports {adc_p[1]}]
set_property -dict {PACKAGE_PIN B17 IOSTANDARD LVCMOS33} [get_ports {adc_n[2]}]
set_property -dict {PACKAGE_PIN B16 IOSTANDARD LVCMOS33} [get_ports {adc_p[2]}]
set_property -dict {PACKAGE_PIN A18 IOSTANDARD LVCMOS33} [get_ports {adc_n[3]}]
set_property -dict {PACKAGE_PIN B18 IOSTANDARD LVCMOS33} [get_ports {adc_p[3]}]



#====================================================================================================
#Pmod Header JA
# 4 out of 10 pins are for Vcc/Gnd
# use two signals (for top and bottom rows) to maintain pin#
#====================================================================================================
set_property -dict {PACKAGE_PIN C17 IOSTANDARD LVCMOS33} [get_ports {ja_top[1]}]
set_property -dict {PACKAGE_PIN D18 IOSTANDARD LVCMOS33} [get_ports {ja_top[2]}]
set_property -dict {PACKAGE_PIN E18 IOSTANDARD LVCMOS33} [get_ports {ja_top[3]}]
set_property -dict {PACKAGE_PIN G17 IOSTANDARD LVCMOS33} [get_ports {ja_top[4]}]
set_property -dict {PACKAGE_PIN D17 IOSTANDARD LVCMOS33} [get_ports {ja_btm[7]}]
set_property -dict {PACKAGE_PIN E17 IOSTANDARD LVCMOS33} [get_ports {ja_btm[8]}]
set_property -dict {PACKAGE_PIN F18 IOSTANDARD LVCMOS33} [get_ports {ja_btm[9]}]
set_property -dict {PACKAGE_PIN G18 IOSTANDARD LVCMOS33} [get_ports {ja_btm[10]}]

#====================================================================================================
#Pmod Header JB
# 4 out of 10 pins are for Vcc/Gnd
# use two signals (for top and bottom rows) to maintain pin#
#====================================================================================================
set_property -dict {PACKAGE_PIN D14 IOSTANDARD LVCMOS33} [get_ports {jb_top[1]}]
set_property -dict {PACKAGE_PIN F16 IOSTANDARD LVCMOS33} [get_ports {jb_top[2]}]
set_property -dict {PACKAGE_PIN G16 IOSTANDARD LVCMOS33} [get_ports {jb_top[3]}]
set_property -dict {PACKAGE_PIN H14 IOSTANDARD LVCMOS33} [get_ports {jb_top[4]}]
set_property -dict {PACKAGE_PIN E16 IOSTANDARD LVCMOS33} [get_ports {jb_btm[7]}]
set_property -dict {PACKAGE_PIN F13 IOSTANDARD LVCMOS33} [get_ports {jb_btm[8]}]
set_property -dict {PACKAGE_PIN G13 IOSTANDARD LVCMOS33} [get_ports {jb_btm[9]}]
set_property -dict {PACKAGE_PIN H16 IOSTANDARD LVCMOS33} [get_ports {jb_btm[10]}]

#====================================================================================================
#Pmod Header JC
# 4 out of 10 pins are for Vcc/Gnd
# use two signals (for top and bottom rows) to maintain pin#
#====================================================================================================
set_property -dict {PACKAGE_PIN K1 IOSTANDARD LVCMOS33} [get_ports {jc_top[1]}]
set_property -dict {PACKAGE_PIN F6 IOSTANDARD LVCMOS33} [get_ports {jc_top[2]}]
set_property -dict {PACKAGE_PIN J2 IOSTANDARD LVCMOS33} [get_ports {jc_top[3]}]
set_property -dict {PACKAGE_PIN G6 IOSTANDARD LVCMOS33} [get_ports {jc_top[4]}]
set_property -dict {PACKAGE_PIN E7 IOSTANDARD LVCMOS33} [get_ports {jc_btm[7]}]
set_property -dict {PACKAGE_PIN J3 IOSTANDARD LVCMOS33} [get_ports {jc_btm[8]}]
set_property -dict {PACKAGE_PIN J4 IOSTANDARD LVCMOS33} [get_ports {jc_btm[9]}]
set_property -dict {PACKAGE_PIN E6 IOSTANDARD LVCMOS33} [get_ports {jc_btm[10]}]


#====================================================================================================
#Pmod Header JD
# 4 out of 10 pins are for Vcc/Gnd
# use two signals (for top and bottom rows) to maintain pin#
#====================================================================================================
set_property -dict {PACKAGE_PIN H4 IOSTANDARD LVCMOS33} [get_ports {jd_top[1]}]
set_property -dict {PACKAGE_PIN H1 IOSTANDARD LVCMOS33} [get_ports {jd_top[2]}]
set_property -dict {PACKAGE_PIN G1 IOSTANDARD LVCMOS33} [get_ports {jd_top[3]}]
set_property -dict {PACKAGE_PIN G3 IOSTANDARD LVCMOS33} [get_ports {jd_top[4]}]
set_property -dict {PACKAGE_PIN H2 IOSTANDARD LVCMOS33} [get_ports {jd_btm[7]}]
set_property -dict {PACKAGE_PIN G4 IOSTANDARD LVCMOS33} [get_ports {jd_btm[8]}]
set_property -dict {PACKAGE_PIN G2 IOSTANDARD LVCMOS33} [get_ports {jd_btm[9]}]
set_property -dict {PACKAGE_PIN F3 IOSTANDARD LVCMOS33} [get_ports {jd_btm[10]}]

#====================================================================================================
# **** not used in the FPro system
#====================================================================================================

##Omnidirectional Microphone
#set_property -dict { PACKAGE_PIN J5    IOSTANDARD LVCMOS33 } [get_ports { M_CLK }]; #IO_25_35 Sch=m_clk
#set_property -dict { PACKAGE_PIN H5    IOSTANDARD LVCMOS33 } [get_ports { M_DATA }]; #IO_L24N_T3_35 Sch=m_data
#set_property -dict { PACKAGE_PIN F5    IOSTANDARD LVCMOS33 } [get_ports { M_LRSEL }]; #IO_0_35 Sch=m_lrsel


##Quad SPI Flash

#set_property -dict { PACKAGE_PIN K17   IOSTANDARD LVCMOS33 } [get_ports { QSPI_DQ[0] }]; #IO_L1P_T0_D00_MOSI_14 Sch=qspi_dq[0]
#set_property -dict { PACKAGE_PIN K18   IOSTANDARD LVCMOS33 } [get_ports { QSPI_DQ[1] }]; #IO_L1N_T0_D01_DIN_14 Sch=qspi_dq[1]
#set_property -dict { PACKAGE_PIN L14   IOSTANDARD LVCMOS33 } [get_ports { QSPI_DQ[2] }]; #IO_L2P_T0_D02_14 Sch=qspi_dq[2]
#set_property -dict { PACKAGE_PIN M14   IOSTANDARD LVCMOS33 } [get_ports { QSPI_DQ[3] }]; #IO_L2N_T0_D03_14 Sch=qspi_dq[3]
#set_property -dict { PACKAGE_PIN L13   IOSTANDARD LVCMOS33 } [get_ports { QSPI_CSN }]; #IO_L6P_T0_FCS_B_14 Sch=qspi_csn


##SMSC Ethernet PHY

#set_property -dict { PACKAGE_PIN C9    IOSTANDARD LVCMOS33 } [get_ports { ETH_MDC }]; #IO_L11P_T1_SRCC_16 Sch=eth_mdc
#set_property -dict { PACKAGE_PIN A9    IOSTANDARD LVCMOS33 } [get_ports { ETH_MDIO }]; #IO_L14N_T2_SRCC_16 Sch=eth_mdio
#set_property -dict { PACKAGE_PIN B3    IOSTANDARD LVCMOS33 } [get_ports { ETH_RSTN }]; #IO_L10P_T1_AD15P_35 Sch=eth_rstn
#set_property -dict { PACKAGE_PIN D9    IOSTANDARD LVCMOS33 } [get_ports { ETH_CRSDV }]; #IO_L6N_T0_VREF_16 Sch=eth_crsdv
#set_property -dict { PACKAGE_PIN C10   IOSTANDARD LVCMOS33 } [get_ports { ETH_RXERR }]; #IO_L13N_T2_MRCC_16 Sch=eth_rxerr
#set_property -dict { PACKAGE_PIN C11   IOSTANDARD LVCMOS33 } [get_ports { ETH_RXD[0] }]; #IO_L13P_T2_MRCC_16 Sch=eth_rxd[0]
#set_property -dict { PACKAGE_PIN D10   IOSTANDARD LVCMOS33 } [get_ports { ETH_RXD[1] }]; #IO_L19N_T3_VREF_16 Sch=eth_rxd[1]
#set_property -dict { PACKAGE_PIN B9    IOSTANDARD LVCMOS33 } [get_ports { ETH_TXEN }]; #IO_L11N_T1_SRCC_16 Sch=eth_txen
#set_property -dict { PACKAGE_PIN A10   IOSTANDARD LVCMOS33 } [get_ports { ETH_TXD[0] }]; #IO_L14P_T2_SRCC_16 Sch=eth_txd[0]
#set_property -dict { PACKAGE_PIN A8    IOSTANDARD LVCMOS33 } [get_ports { ETH_TXD[1] }]; #IO_L12N_T1_MRCC_16 Sch=eth_txd[1]
#set_property -dict { PACKAGE_PIN D5    IOSTANDARD LVCMOS33 } [get_ports { ETH_REFCLK }]; #IO_L11P_T1_SRCC_35 Sch=eth_refclk
#set_property -dict { PACKAGE_PIN B8    IOSTANDARD LVCMOS33 } [get_ports { ETH_INTN }]; #IO_L12P_T1_MRCC_16 Sch=eth_intn



#====================================================================================================
#====================================================================================================
#                                               Zybo Z7
#====================================================================================================
#====================================================================================================


# Zybo Z7 constraints file
# chapter: ?
# project: ?????

#Clock signal
set_property -dict { PACKAGE_PIN K17   IOSTANDARD LVCMOS33 } [get_ports { CLK }];
create_clock -add -name sys_clk_pin -period 8.00 -waveform {0 4} [get_ports { CLK }];

#Reset
set_property -dict { PACKAGE_PIN Y16   IOSTANDARD LVCMOS33 } [get_ports { RST }]; # BTN[3]

#RGB LED
set_property -dict { PACKAGE_PIN V16   IOSTANDARD LVCMOS33 } [get_ports { LED_RGB[2] }]; # Red
set_property -dict { PACKAGE_PIN F17   IOSTANDARD LVCMOS33 } [get_ports { LED_RGB[1] }]; # Green
set_property -dict { PACKAGE_PIN M17   IOSTANDARD LVCMOS33 } [get_ports { LED_RGB[0] }]; # Blue

#Buttons
set_property -dict { PACKAGE_PIN K18   IOSTANDARD LVCMOS33 } [get_ports { BTN[0] }];
set_property -dict { PACKAGE_PIN P16   IOSTANDARD LVCMOS33 } [get_ports { BTN[1] }];
set_property -dict { PACKAGE_PIN K19   IOSTANDARD LVCMOS33 } [get_ports { BTN[2] }];
set_property -dict { PACKAGE_PIN Y16   IOSTANDARD LVCMOS33 } [get_ports { BTN[3] }];

#HDMI TX
set_property -dict { PACKAGE_PIN H17   IOSTANDARD TMDS_33  } [get_ports { HDMI_CLK_N }];
set_property -dict { PACKAGE_PIN H16   IOSTANDARD TMDS_33  } [get_ports { HDMI_CLK_P }];
set_property -dict { PACKAGE_PIN D20   IOSTANDARD TMDS_33  } [get_ports { HDMI_N[0] }];
set_property -dict { PACKAGE_PIN D19   IOSTANDARD TMDS_33  } [get_ports { HDMI_P[0] }];
set_property -dict { PACKAGE_PIN B20   IOSTANDARD TMDS_33  } [get_ports { HDMI_N[1] }];
set_property -dict { PACKAGE_PIN C20   IOSTANDARD TMDS_33  } [get_ports { HDMI_P[1] }];
set_property -dict { PACKAGE_PIN A20   IOSTANDARD TMDS_33  } [get_ports { HDMI_N[2] }];
set_property -dict { PACKAGE_PIN B19   IOSTANDARD TMDS_33  } [get_ports { HDMI_P[2] }];

#Pmod VGA

#Pmod Header JC
set_property -dict { PACKAGE_PIN V15   IOSTANDARD LVCMOS33 } [get_ports { VGA_R[0] }]; #jc_p[1]
set_property -dict { PACKAGE_PIN W15   IOSTANDARD LVCMOS33 } [get_ports { VGA_R[1] }]; #jc_n[1]
set_property -dict { PACKAGE_PIN T11   IOSTANDARD LVCMOS33 } [get_ports { VGA_R[2] }]; #jc_p[2]
set_property -dict { PACKAGE_PIN T10   IOSTANDARD LVCMOS33 } [get_ports { VGA_R[3] }]; #jc_n[2]
set_property -dict { PACKAGE_PIN W14   IOSTANDARD LVCMOS33 } [get_ports { VGA_B[0] }]; #jc_p[3]
set_property -dict { PACKAGE_PIN Y14   IOSTANDARD LVCMOS33 } [get_ports { VGA_B[1] }]; #jc_n[3]
set_property -dict { PACKAGE_PIN T12   IOSTANDARD LVCMOS33 } [get_ports { VGA_B[2] }]; #jc_p[4]
set_property -dict { PACKAGE_PIN U12   IOSTANDARD LVCMOS33 } [get_ports { VGA_B[3] }]; #jc_n[4]

#Pmod Header JD
set_property -dict { PACKAGE_PIN T14   IOSTANDARD LVCMOS33 } [get_ports { VGA_G[0] }]; #jd_p[1]
set_property -dict { PACKAGE_PIN T15   IOSTANDARD LVCMOS33 } [get_ports { VGA_G[1] }]; #jd_n[1]
set_property -dict { PACKAGE_PIN P14   IOSTANDARD LVCMOS33 } [get_ports { VGA_G[2] }]; #jd_p[2]
set_property -dict { PACKAGE_PIN R14   IOSTANDARD LVCMOS33 } [get_ports { VGA_G[3] }]; #jd_n[2]
set_property -dict { PACKAGE_PIN U14   IOSTANDARD LVCMOS33 } [get_ports { VGA_HS }];   #jd_p[3]
set_property -dict { PACKAGE_PIN U15   IOSTANDARD LVCMOS33 } [get_ports { VGA_VS }];   #jd_n[3]

#Single LED
set_property -dict { PACKAGE_PIN M14   IOSTANDARD LVCMOS33 } [get_ports { LED[0] }];
set_property -dict { PACKAGE_PIN M15   IOSTANDARD LVCMOS33 } [get_ports { LED[1] }];
set_property -dict { PACKAGE_PIN G14   IOSTANDARD LVCMOS33 } [get_ports { LED[2] }];
set_property -dict { PACKAGE_PIN D18   IOSTANDARD LVCMOS33 } [get_ports { LED[3] }];

#Switches
set_property -dict { PACKAGE_PIN G15   IOSTANDARD LVCMOS33 } [get_ports { SW[0] }];
set_property -dict { PACKAGE_PIN P15   IOSTANDARD LVCMOS33 } [get_ports { SW[1] }];
set_property -dict { PACKAGE_PIN W13   IOSTANDARD LVCMOS33 } [get_ports { SW[2] }];
set_property -dict { PACKAGE_PIN T16   IOSTANDARD LVCMOS33 } [get_ports { SW[3] }];

#RGB LED2 (Zybo Z7-20 only)
set_property -dict { PACKAGE_PIN Y11   IOSTANDARD LVCMOS33 } [get_ports { LED_RGB2[2] }]; # Red
set_property -dict { PACKAGE_PIN T5    IOSTANDARD LVCMOS33 } [get_ports { LED_RGB2[1] }]; # Green
set_property -dict { PACKAGE_PIN Y12   IOSTANDARD LVCMOS33 } [get_ports { LED_RGB2[0] }]; # Blue

# false path
set_clock_groups -asynchronous -group [get_clocks clk_fpga_0] \
    -group [get_clocks -include_generated_clocks clk_fpga_0 -filter {NAME !~ clk_fpga_0}]



