set BOARD zedboard
set IPS "/home/victor/pulp_shared_vm/pulp_box/pulpissimo/ips"
set XILINX_PART xc7z020clg484-1
set XILINX_BOARD em.avnet.com:zed:part0:1.4
set FC_CLK_PERIOD_NS 62.5
set PER_CLK_PERIOD_NS 100
set SLOW_CLK_PERIOD_NS 30517
#Must also change the localparam 'L2_BANK_SIZE' in pulp_soc.sv accordingly
set INTERLEAVED_BANK_SIZE 28672
#Must also change the localparam 'L2_BANK_SIZE_PRI' in pulp_soc.sv accordingly
set PRIVATE_BANK_SIZE 8192
#$(info Setting environment variables for $(BOARD) board)

# Check if BOARD variable exists
#if [info exists ::env(BOARD)] {
#    set BOARD $::env(BOARD)
#} else {
#    puts "BOARD is not defined. Please include 'fpga-settings.mk' in your Makefile to setup necessary environment variables."
#    exit
#}

set partNumber "Cyclone V"

# Set FPGA parameters
#if {[info exists ::env(INTEL_BOARD)]} {
#    set INTEL_BOARD $::env(INTEL_BOARD)
#}
#set partNumber $::env(INTEL_PART)

# Set Quartus messaging severity levels
#set_msg_config -id {[Quartus Synth 3352]}         -new_severity "critical warning"
#set_msg_config -id {[Quartus Synth 350]}          -new_severity "critical warning"
#set_msg_config -id {[Quartus Synth 2490]}         -new_severity "warning"
#set_msg_config -id {[Quartus Synth 2306]}         -new_severity "info"
#set_msg_config -id {[Quartus Synth 3331]}         -new_severity "critical warning"
#set_msg_config -id {[Quartus Synth 3332]}         -new_severity "info"
#set_msg_config -id {[Quartus Synth 2715]}         -new_severity "error"
#set_msg_config -id {[Quartus Opt 31-35]}          -new_severity "info"
#set_msg_config -id {[Quartus Opt 31-32]}          -new_severity "info"
#set_msg_config -id {[Quartus Shape Builder 18-119]} -new_severity "warning"
#set_msg_config -id {[Quartus Filemgmt 20-742]}      -new_severity "error"

# Set the number of processors, defaulting to 4 if unavailable
set CPUS [exec getconf _NPROCESSORS_ONLN]
if {![info exists CPUS]} {
    set CPUS 4
}

#set PROJECT pulpissimo-$BOARD
set PROJECT xilinx_pulpissimo
set RTL ../../../rtl
set IPS ../../../ips
set CONSTRS constraints

# Create a Quartus project
    project_new $PROJECT


# Set global assignments
set_global_assignment -name FAMILY "Cyclone V"
set_global_assignment -name DEVICE 5CSXFC6D6F31C6
set_global_assignment -name ORIGINAL_QUARTUS_VERSION "23.1STD.1"
set_global_assignment -name LAST_QUARTUS_VERSION "23.1std.1 Lite Edition"
set_global_assignment -name PROJECT_CREATION_TIME_DATE "15:20:33 JUNE 03,2025"
set_global_assignment -name DEVICE_FILTER_PACKAGE FBGA
set_global_assignment -name DEVICE_FILTER_PIN_COUNT 896
set_global_assignment -name DEVICE_FILTER_SPEED_GRADE 6
set_global_assignment -name SDC_FILE DE10_Standard.SDC

# Include necessary files
if {! [info exists INCLUDE_DIRS]} {
    set INCLUDE_DIRS ""
}

eval "set INCLUDE_DIRS {
    /home/victor/pulp_box/pulpissimo/rtl/includes/ \
    /home/victor/pulp_box/pulpissimo/ips/common_cells/include \
    /home/victor/pulp_box/pulpissimo/ips/cluster_interconnect/rtl/low_latency_interco \
    /home/victor/pulp_box/pulpissimo/ips/cluster_interconnect/rtl/peripheral_interco \
    /home/victor/pulp_box/pulpissimo/ips/cluster_interconnect/../../rtl/includes \
    /home/victor/pulp_box/pulpissimo/ips/adv_dbg_if/rtl \
    /home/victor/pulp_box/pulpissimo/ips/apb/apb_adv_timer/./rtl \
    /home/victor/pulp_box/pulpissimo/ips/axi/axi/include \
    /home/victor/pulp_box/pulpissimo/ips/axi/axi/../../common_cells/include \
    /home/victor/pulp_box/pulpissimo/ips/timer_unit/rtl \
    /home/victor/pulp_box/pulpissimo/ips/fpnew/../common_cells/include \
    /home/victor/pulp_box/pulpissimo/ips/jtag_pulp/../../rtl/includes \
    /home/victor/pulp_box/pulpissimo/ips/riscv/./rtl/include \
    /home/victor/pulp_box/pulpissimo/ips/riscv/../../rtl/includes \
    /home/victor/pulp_box/pulpissimo/ips/riscv/./rtl/include \
    /home/victor/pulp_box/pulpissimo/ips/ibex/rtl \
    /home/victor/pulp_box/pulpissimo/ips/ibex/shared/rtl \
    /home/victor/pulp_box/pulpissimo/ips/udma/udma_core/./rtl \
    /home/victor/pulp_box/pulpissimo/ips/udma/udma_qspi/rtl \
    /home/victor/pulp_box/pulpissimo/ips/hwpe-ctrl/rtl \
    /home/victor/pulp_box/pulpissimo/ips/hwpe-stream/rtl \
    /home/victor/pulp_box/pulpissimo/ips/hwpe-mac-engine/rtl \
    /home/victor/pulp_box/pulpissimo/ips/register_interface/include \
    /home/victor/pulp_box/pulpissimo/ips/register_interface/../axi/axi/include \
    /home/victor/pulp_box/pulpissimo/ips/register_interface/../common_cells/include \
    /home/victor/pulp_box/pulpissimo/ips/register_interface/include \
    /home/victor/pulp_box/pulpissimo/ips/register_interface/../axi/axi/include \
    /home/victor/pulp_box/pulpissimo/ips/register_interface/../common_cells/include \
    /home/victor/pulp_box/pulpissimo/ips/pulp_soc/../../rtl/includes \
    /home/victor/pulp_box/pulpissimo/ips/pulp_soc/rtl/include \
    /home/victor/pulp_box/pulpissimo/ips/pulp_soc/../axi/axi/include \
    /home/victor/pulp_box/pulpissimo/ips/pulp_soc/../../rtl/includes \
    /home/victor/pulp_box/pulpissimo/ips/pulp_soc/. \
    /home/victor/pulp_box/pulpissimo/ips/pulp_soc/../../rtl/includes \
    /home/victor/pulp_box/pulpissimo/ips/pulp_soc/. \
    /home/victor/pulp_box/pulpissimo/ips/pulp_soc/../../rtl/includes \
    ${INCLUDE_DIRS} \
}"
set_global_assignment -name SEARCH_PATH $INCLUDE_DIRS

# Add IP source files
set RTL /home/victor/pulp_shared_vm/pulp_box/pulpissimo/rtl
set IPS /home/victor/pulp_shared_vm/pulp_box/pulpissimo/ips
set FPGA_IPS ../ips
set FPGA_RTL ../rtl

##########################################################
#add_files -norecurse -scan_for_includes $SRC_COMMON_CELLS_ALL
#add_files -norecurse -scan_for_includes $SRC_SOC_INTERCONNECT
#add_files -norecurse -scan_for_includes $SRC_LOW_LATENCY_INTERCO
#add_files -norecurse -scan_for_includes $SRC_PERIPHERAL_INTERCO
#add_files -norecurse -scan_for_includes $SRC_TCDM_INTERCONNECT
#add_files -norecurse -scan_for_includes $SRC_ADV_DBG_IF
#add_files -norecurse -scan_for_includes $SRC_APB2PER
#add_files -norecurse -scan_for_includes $SRC_APB_ADV_TIMER
#add_files -norecurse -scan_for_includes $SRC_APB_FLL_IF
#add_files -norecurse -scan_for_includes $SRC_APB_GPIO
#add_files -norecurse -scan_for_includes $SRC_APB_NODE
#add_files -norecurse -scan_for_includes $SRC_APB_INTERRUPT_CNTRL
#add_files -norecurse -scan_for_includes $SRC_AXI
#add_files -norecurse -scan_for_includes $SRC_AXI_SLICE
#add_files -norecurse -scan_for_includes $SRC_AXI_SLICE_DC
#add_files -norecurse -scan_for_includes $SRC_TIMER_UNIT
#add_files -norecurse -scan_for_includes $SRC_DIV_SQRT_TOP_MVP
#add_files -norecurse -scan_for_includes $SRC_FPNEW
#add_files -norecurse -scan_for_includes $SRC_JTAG_PULP
#add_files -norecurse -scan_for_includes $SRC_RISCV
#add_files -norecurse -scan_for_includes $SRC_RISCV_REGFILE_FPGA
#add_files -norecurse -scan_for_includes $SRC_IBEX
#add_files -norecurse -scan_for_includes $SRC_IBEX_REGFILE_FPGA
#add_files -norecurse -scan_for_includes $SRC_SCM_FPGA
#add_files -norecurse -scan_for_includes $SRC_TECH_CELLS_RTL_SYNTH
#add_files -norecurse -scan_for_includes $SRC_TECH_CELLS_FPGA
#add_files -norecurse -scan_for_includes $SRC_UDMA_CORE
#add_files -norecurse -scan_for_includes $SRC_UDMA_UART
#add_files -norecurse -scan_for_includes $SRC_UDMA_I2C
#add_files -norecurse -scan_for_includes $SRC_UDMA_I2S
#add_files -norecurse -scan_for_includes $SRC_UDMA_QSPI
#add_files -norecurse -scan_for_includes $SRC_UDMA_SDIO
#add_files -norecurse -scan_for_includes $SRC_UDMA_CAMERA
#add_files -norecurse -scan_for_includes $SRC_UDMA_FILTER
#add_files -norecurse -scan_for_includes $SRC_UDMA_EXTERNAL_PER
#add_files -norecurse -scan_for_includes $SRC_HWPE_CTRL
#add_files -norecurse -scan_for_includes $SRC_HWPE_STREAM
#add_files -norecurse -scan_for_includes $SRC_HW_MAC_ENGINE
#add_files -norecurse -scan_for_includes $SRC_RISCV_DBG
#add_files -norecurse -scan_for_includes $SRC_REGISTER_INTERFACE
#add_files -norecurse -scan_for_includes $SRC_REGGEN_PRIMITIVES
#add_files -norecurse -scan_for_includes $SRC_PULP_SOC
#add_files -norecurse -scan_for_includes $SRC_UDMA_SUBSYSTEM
#add_files -norecurse -scan_for_includes $SRC_FC
#add_files -norecurse -scan_for_includes $SRC_COMPONENTS
######################################################################


# Add Quartus-compatible IPs
#
# COMMON_CELLS_ALL
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/binary_to_gray.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/cb_filter_pkg.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/cdc_2phase.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/cf_math_pkg.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/clk_div.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/delta_counter.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/ecc_pkg.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/edge_propagator_tx.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/exp_backoff.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/fifo_v3.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/gray_to_binary.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/isochronous_spill_register.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/lfsr.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/lfsr_16bit.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/lfsr_8bit.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/mv_filter.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/onehot_to_bin.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/plru_tree.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/popcount.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/rr_arb_tree.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/rstgen_bypass.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/serial_deglitch.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/shift_reg.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/spill_register.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/stream_demux.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/stream_filter.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/stream_fork.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/stream_intf.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/stream_join.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/stream_mux.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/sub_per_hash.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/sync.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/sync_wedge.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/unread.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/addr_decode.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/cb_filter.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/cdc_fifo_2phase.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/cdc_fifo_gray.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/counter.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/ecc_decode.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/ecc_encode.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/edge_detect.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/lzc.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/max_counter.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/rstgen.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/stream_delay.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/stream_fifo.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/stream_fork_dynamic.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/stream_xbar.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/fall_through_register.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/id_queue.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/stream_to_mem.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/stream_arbiter_flushable.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/stream_omega_net.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/stream_register.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/stream_arbiter.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/deprecated/clock_divider_counter.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/deprecated/find_first_one.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/deprecated/generic_LFSR_8bit.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/deprecated/generic_fifo.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/deprecated/generic_fifo_adv.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/deprecated/pulp_sync.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/deprecated/pulp_sync_wedge.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/deprecated/clock_divider.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/deprecated/fifo_v2.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/deprecated/prioarbiter.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/deprecated/rrarbiter.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/deprecated/fifo_v1.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/edge_propagator.sv 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/common_cells/src/edge_propagator_rx.sv 
# SOC_INTERCONNECT
set_global_assignment -name SYSTEMVERILOG_FILE  $IPS/L2_tcdm_hybrid_interco/RTL/l2_tcdm_demux.sv
set_global_assignment -name SYSTEMVERILOG_FILE  $IPS/L2_tcdm_hybrid_interco/RTL/lint_2_apb.sv 
set_global_assignment -name SYSTEMVERILOG_FILE  $IPS/L2_tcdm_hybrid_interco/RTL/lint_2_axi.sv
set_global_assignment -name SYSTEMVERILOG_FILE  $IPS/L2_tcdm_hybrid_interco/RTL/axi_2_lint/axi64_2_lint32.sv
set_global_assignment -name SYSTEMVERILOG_FILE  $IPS/L2_tcdm_hybrid_interco/RTL/axi_2_lint/axi_read_ctrl.sv
set_global_assignment -name SYSTEMVERILOG_FILE  $IPS/L2_tcdm_hybrid_interco/RTL/axi_2_lint/axi_write_ctrl.sv
set_global_assignment -name SYSTEMVERILOG_FILE  $IPS/L2_tcdm_hybrid_interco/RTL/axi_2_lint/lint64_to_32.sv
set_global_assignment -name SYSTEMVERILOG_FILE  $IPS/L2_tcdm_hybrid_interco/RTL/XBAR_L2/AddressDecoder_Req_L2.sv
set_global_assignment -name SYSTEMVERILOG_FILE  $IPS/L2_tcdm_hybrid_interco/RTL/XBAR_L2/AddressDecoder_Resp_L2.sv
set_global_assignment -name SYSTEMVERILOG_FILE  $IPS/L2_tcdm_hybrid_interco/RTL/XBAR_L2/ArbitrationTree_L2.sv
set_global_assignment -name SYSTEMVERILOG_FILE  $IPS/L2_tcdm_hybrid_interco/RTL/XBAR_L2/FanInPrimitive_Req_L2.sv
set_global_assignment -name SYSTEMVERILOG_FILE  $IPS/L2_tcdm_hybrid_interco/RTL/XBAR_L2/FanInPrimitive_Resp_L2.sv
set_global_assignment -name SYSTEMVERILOG_FILE  $IPS/L2_tcdm_hybrid_interco/RTL/XBAR_L2/MUX2_REQ_L2.sv
set_global_assignment -name SYSTEMVERILOG_FILE  $IPS/L2_tcdm_hybrid_interco/RTL/XBAR_L2/RequestBlock_L2_1CH.sv
set_global_assignment -name SYSTEMVERILOG_FILE  $IPS/L2_tcdm_hybrid_interco/RTL/XBAR_L2/RequestBlock_L2_2CH.sv
set_global_assignment -name SYSTEMVERILOG_FILE  $IPS/L2_tcdm_hybrid_interco/RTL/XBAR_L2/ResponseBlock_L2.sv
set_global_assignment -name SYSTEMVERILOG_FILE  $IPS/L2_tcdm_hybrid_interco/RTL/XBAR_L2/ResponseTree_L2.sv
set_global_assignment -name SYSTEMVERILOG_FILE  $IPS/L2_tcdm_hybrid_interco/RTL/XBAR_L2/RR_Flag_Req_L2.sv
set_global_assignment -name SYSTEMVERILOG_FILE  $IPS/L2_tcdm_hybrid_interco/RTL/XBAR_L2/XBAR_L2.sv
set_global_assignment -name SYSTEMVERILOG_FILE  $IPS/L2_tcdm_hybrid_interco/RTL/XBAR_BRIDGE/AddressDecoder_Req_BRIDGE.sv
set_global_assignment -name SYSTEMVERILOG_FILE  $IPS/L2_tcdm_hybrid_interco/RTL/XBAR_BRIDGE/AddressDecoder_Resp_BRIDGE.sv
set_global_assignment -name SYSTEMVERILOG_FILE  $IPS/L2_tcdm_hybrid_interco/RTL/XBAR_BRIDGE/ArbitrationTree_BRIDGE.sv
set_global_assignment -name SYSTEMVERILOG_FILE  $IPS/L2_tcdm_hybrid_interco/RTL/XBAR_BRIDGE/FanInPrimitive_Req_BRIDGE.sv
set_global_assignment -name SYSTEMVERILOG_FILE  $IPS/L2_tcdm_hybrid_interco/RTL/XBAR_BRIDGE/FanInPrimitive_Resp_BRIDGE.sv
set_global_assignment -name SYSTEMVERILOG_FILE  $IPS/L2_tcdm_hybrid_interco/RTL/XBAR_BRIDGE/MUX2_REQ_BRIDGE.sv
set_global_assignment -name SYSTEMVERILOG_FILE  $IPS/L2_tcdm_hybrid_interco/RTL/XBAR_BRIDGE/RequestBlock1CH_BRIDGE.sv
set_global_assignment -name SYSTEMVERILOG_FILE  $IPS/L2_tcdm_hybrid_interco/RTL/XBAR_BRIDGE/RequestBlock2CH_BRIDGE.sv
set_global_assignment -name SYSTEMVERILOG_FILE  $IPS/L2_tcdm_hybrid_interco/RTL/XBAR_BRIDGE/ResponseBlock_BRIDGE.sv
set_global_assignment -name SYSTEMVERILOG_FILE  $IPS/L2_tcdm_hybrid_interco/RTL/XBAR_BRIDGE/ResponseTree_BRIDGE.sv
set_global_assignment -name SYSTEMVERILOG_FILE  $IPS/L2_tcdm_hybrid_interco/RTL/XBAR_BRIDGE/RR_Flag_Req_BRIDGE.sv
set_global_assignment -name SYSTEMVERILOG_FILE  $IPS/L2_tcdm_hybrid_interco/RTL/XBAR_BRIDGE/XBAR_BRIDGE.sv
#
set_global_assignment -name SYSTEMVERILOG_FILE   $IPS/cluster_interconnect/rtl/low_latency_interco/FanInPrimitive_Req.sv
set_global_assignment -name SYSTEMVERILOG_FILE   $IPS/cluster_interconnect/rtl/low_latency_interco/ArbitrationTree.sv
set_global_assignment -name SYSTEMVERILOG_FILE   $IPS/cluster_interconnect/rtl/low_latency_interco/MUX2_REQ.sv
set_global_assignment -name SYSTEMVERILOG_FILE   $IPS/cluster_interconnect/rtl/low_latency_interco/AddressDecoder_Resp.sv
set_global_assignment -name SYSTEMVERILOG_FILE   $IPS/cluster_interconnect/rtl/low_latency_interco/TestAndSet.sv
set_global_assignment -name SYSTEMVERILOG_FILE   $IPS/cluster_interconnect/rtl/low_latency_interco/RequestBlock2CH.sv
set_global_assignment -name SYSTEMVERILOG_FILE   $IPS/cluster_interconnect/rtl/low_latency_interco/RequestBlock1CH.sv
set_global_assignment -name SYSTEMVERILOG_FILE   $IPS/cluster_interconnect/rtl/low_latency_interco/FanInPrimitive_Resp.sv
set_global_assignment -name SYSTEMVERILOG_FILE   $IPS/cluster_interconnect/rtl/low_latency_interco/ResponseTree.sv
set_global_assignment -name SYSTEMVERILOG_FILE   $IPS/cluster_interconnect/rtl/low_latency_interco/ResponseBlock.sv
set_global_assignment -name SYSTEMVERILOG_FILE   $IPS/cluster_interconnect/rtl/low_latency_interco/AddressDecoder_Req.sv
set_global_assignment -name SYSTEMVERILOG_FILE   $IPS/cluster_interconnect/rtl/low_latency_interco/XBAR_TCDM.sv
set_global_assignment -name SYSTEMVERILOG_FILE   $IPS/cluster_interconnect/rtl/low_latency_interco/XBAR_TCDM_WRAPPER.sv
set_global_assignment -name SYSTEMVERILOG_FILE   $IPS/cluster_interconnect/rtl/low_latency_interco/TCDM_PIPE_REQ.sv
set_global_assignment -name SYSTEMVERILOG_FILE   $IPS/cluster_interconnect/rtl/low_latency_interco/TCDM_PIPE_RESP.sv
set_global_assignment -name SYSTEMVERILOG_FILE   $IPS/cluster_interconnect/rtl/low_latency_interco/grant_mask.sv
set_global_assignment -name SYSTEMVERILOG_FILE   $IPS/cluster_interconnect/rtl/low_latency_interco/priority_Flag_Req.sv
#
set_global_assignment -name SYSTEMVERILOG_FILE   $IPS/cluster_interconnect/rtl/peripheral_interco/AddressDecoder_PE_Req.sv
set_global_assignment -name SYSTEMVERILOG_FILE   $IPS/cluster_interconnect/rtl/peripheral_interco/AddressDecoder_Resp_PE.sv
set_global_assignment -name SYSTEMVERILOG_FILE   $IPS/cluster_interconnect/rtl/peripheral_interco/ArbitrationTree_PE.sv
set_global_assignment -name SYSTEMVERILOG_FILE   $IPS/cluster_interconnect/rtl/peripheral_interco/FanInPrimitive_Req_PE.sv
set_global_assignment -name SYSTEMVERILOG_FILE   $IPS/cluster_interconnect/rtl/peripheral_interco/RR_Flag_Req_PE.sv
set_global_assignment -name SYSTEMVERILOG_FILE   $IPS/cluster_interconnect/rtl/peripheral_interco/MUX2_REQ_PE.sv
set_global_assignment -name SYSTEMVERILOG_FILE   $IPS/cluster_interconnect/rtl/peripheral_interco/FanInPrimitive_PE_Resp.sv
set_global_assignment -name SYSTEMVERILOG_FILE   $IPS/cluster_interconnect/rtl/peripheral_interco/RequestBlock1CH_PE.sv
set_global_assignment -name SYSTEMVERILOG_FILE   $IPS/cluster_interconnect/rtl/peripheral_interco/RequestBlock2CH_PE.sv
set_global_assignment -name SYSTEMVERILOG_FILE   $IPS/cluster_interconnect/rtl/peripheral_interco/ResponseBlock_PE.sv
set_global_assignment -name SYSTEMVERILOG_FILE   $IPS/cluster_interconnect/rtl/peripheral_interco/ResponseTree_PE.sv
set_global_assignment -name SYSTEMVERILOG_FILE   $IPS/cluster_interconnect/rtl/peripheral_interco/XBAR_PE.sv
#
set_global_assignment -name SYSTEMVERILOG_FILE   $IPS/cluster_interconnect/rtl/tcdm_interconnect/tcdm_interconnect_pkg.sv
set_global_assignment -name SYSTEMVERILOG_FILE   $IPS/cluster_interconnect/rtl/tcdm_interconnect/addr_dec_resp_mux.sv
set_global_assignment -name SYSTEMVERILOG_FILE   $IPS/cluster_interconnect/rtl/tcdm_interconnect/amo_shim.sv
set_global_assignment -name SYSTEMVERILOG_FILE   $IPS/cluster_interconnect/rtl/tcdm_interconnect/xbar.sv
set_global_assignment -name SYSTEMVERILOG_FILE   $IPS/cluster_interconnect/rtl/tcdm_interconnect/clos_net.sv
set_global_assignment -name SYSTEMVERILOG_FILE   $IPS/cluster_interconnect/rtl/tcdm_interconnect/bfly_net.sv
set_global_assignment -name SYSTEMVERILOG_FILE   $IPS/cluster_interconnect/rtl/tcdm_interconnect/tcdm_interconnect.sv
#
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/adv_dbg_if/rtl/adbg_axi_biu.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/adv_dbg_if/rtl/adbg_axi_module.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/adv_dbg_if/rtl/adbg_lint_biu.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/adv_dbg_if/rtl/adbg_lint_module.sv
set_global_assignment -name VERILOG_FILE $IPS/adv_dbg_if/rtl/adbg_crc32.v 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/adv_dbg_if/rtl/adbg_or1k_biu.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/adv_dbg_if/rtl/adbg_or1k_module.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/adv_dbg_if/rtl/adbg_or1k_status_reg.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/adv_dbg_if/rtl/adbg_top.sv
set_global_assignment -name VERILOG_FILE $IPS/adv_dbg_if/rtl/bytefifo.v 
set_global_assignment -name VERILOG_FILE $IPS/adv_dbg_if/rtl/syncflop.v 
set_global_assignment -name VERILOG_FILE $IPS/adv_dbg_if/rtl/syncreg.v 
set_global_assignment -name VERILOG_FILE $IPS/adv_dbg_if/rtl/adbg_tap_top.v 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/adv_dbg_if/rtl/adv_dbg_if.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/adv_dbg_if/rtl/adbg_axionly_top.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/adv_dbg_if/rtl/adbg_lintonly_top.sv
#
 set_global_assignment -name SYSTEMVERILOG_FILE $IPS/apb/apb2per/apb2per.sv
#
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/apb/apb_adv_timer/./rtl/adv_timer_apb_if.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/apb/apb_adv_timer/./rtl/comparator.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/apb/apb_adv_timer/./rtl/lut_4x4.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/apb/apb_adv_timer/./rtl/out_filter.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/apb/apb_adv_timer/./rtl/up_down_counter.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/apb/apb_adv_timer/./rtl/input_stage.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/apb/apb_adv_timer/./rtl/prescaler.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/apb/apb_adv_timer/./rtl/apb_adv_timer.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/apb/apb_adv_timer/./rtl/timer_cntrl.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/apb/apb_adv_timer/./rtl/timer_module.sv
#
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/apb/apb_fll_if/apb_fll_if.sv
#
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/apb/apb_gpio/./rtl/apb_gpio.sv
#
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/apb/apb_node/src/apb_node.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/apb/apb_node/src/apb_node_wrap.sv
#
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/apb_interrupt_cntrl/apb_interrupt_cntrl.sv
#
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/axi/axi/src/axi_pkg.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/axi/axi/src/axi_intf.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/axi/axi/src/axi_atop_filter.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/axi/axi/src/axi_burst_splitter.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/axi/axi/src/axi_cdc.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/axi/axi/src/axi_cut.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/axi/axi/src/axi_delayer.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/axi/axi/src/axi_demux.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/axi/axi/src/axi_dw_downsizer.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/axi/axi/src/axi_dw_upsizer.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/axi/axi/src/axi_id_prepend.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/axi/axi/src/axi_isolate.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/axi/axi/src/axi_join.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/axi/axi/src/axi_lite_demux.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/axi/axi/src/axi_lite_join.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/axi/axi/src/axi_lite_mailbox.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/axi/axi/src/axi_lite_mux.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/axi/axi/src/axi_lite_regs.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/axi/axi/src/axi_lite_to_apb.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/axi/axi/src/axi_lite_to_axi.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/axi/axi/src/axi_modify_address.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/axi/axi/src/axi_mux.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/axi/axi/src/axi_serializer.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/axi/axi/src/axi_err_slv.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/axi/axi/src/axi_dw_converter.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/axi/axi/src/axi_multicut.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/axi/axi/src/axi_to_axi_lite.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/axi/axi/src/axi_lite_xbar.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/axi/axi/src/axi_xbar.sv   
#
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/axi/axi_slice/src/axi_single_slice.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/axi/axi_slice/src/axi_ar_buffer.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/axi/axi_slice/src/axi_aw_buffer.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/axi/axi_slice/src/axi_b_buffer.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/axi/axi_slice/src/axi_r_buffer.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/axi/axi_slice/src/axi_slice.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/axi/axi_slice/src/axi_w_buffer.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/axi/axi_slice/src/axi_slice_wrap.sv
#
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/axi/axi_slice_dc/src/axi_slice_dc_master.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/axi/axi_slice_dc/src/axi_slice_dc_slave.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/axi/axi_slice_dc/src/dc_data_buffer.sv
set_global_assignment -name VERILOG_FILE $IPS/axi/axi_slice_dc/src/dc_full_detector.v 
set_global_assignment -name VERILOG_FILE $IPS/axi/axi_slice_dc/src/dc_synchronizer.v 
set_global_assignment -name VERILOG_FILE $IPS/axi/axi_slice_dc/src/dc_token_ring_fifo_din.v 
set_global_assignment -name VERILOG_FILE $IPS/axi/axi_slice_dc/src/dc_token_ring_fifo_dout.v 
set_global_assignment -name VERILOG_FILE $IPS/axi/axi_slice_dc/src/dc_token_ring.v 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/axi/axi_slice_dc/src/axi_slice_dc_master_wrap.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/axi/axi_slice_dc/src/axi_slice_dc_slave_wrap.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/axi/axi_slice_dc/src/axi_cdc.sv
#
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/timer_unit/./rtl/apb_timer_unit.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/timer_unit/./rtl/timer_unit.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/timer_unit/./rtl/timer_unit_counter.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/timer_unit/./rtl/timer_unit_counter_presc.sv
#
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/fpu_div_sqrt_mvp/hdl/defs_div_sqrt_mvp.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/fpu_div_sqrt_mvp/hdl/control_mvp.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/fpu_div_sqrt_mvp/hdl/div_sqrt_mvp_wrapper.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/fpu_div_sqrt_mvp/hdl/div_sqrt_top_mvp.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/fpu_div_sqrt_mvp/hdl/iteration_div_sqrt_mvp.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/fpu_div_sqrt_mvp/hdl/norm_div_sqrt_mvp.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/fpu_div_sqrt_mvp/hdl/nrbd_nrsc_mvp.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/fpu_div_sqrt_mvp/hdl/preprocess_mvp.sv
#
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/fpnew/src/fpnew_pkg.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/fpnew/src/fpnew_cast_multi.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/fpnew/src/fpnew_classifier.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/fpnew/src/fpnew_divsqrt_multi.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/fpnew/src/fpnew_fma.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/fpnew/src/fpnew_fma_multi.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/fpnew/src/fpnew_noncomp.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/fpnew/src/fpnew_opgroup_block.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/fpnew/src/fpnew_opgroup_fmt_slice.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/fpnew/src/fpnew_opgroup_multifmt_slice.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/fpnew/src/fpnew_rounding.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/fpnew/src/fpnew_top.sv
#
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/jtag_pulp/src/bscell.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/jtag_pulp/src/jtag_axi_wrap.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/jtag_pulp/src/jtag_enable.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/jtag_pulp/src/jtag_enable_synch.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/jtag_pulp/src/jtagreg.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/jtag_pulp/src/jtag_rst_synch.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/jtag_pulp/src/jtag_sync.sv
set_global_assignment -name VERILOG_FILE $IPS/jtag_pulp/src/tap_top.v 
#
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/riscv/./rtl/include/apu_core_package.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/riscv/./rtl/include/riscv_defines.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/riscv/./rtl/include/riscv_tracer_defines.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/riscv/./rtl/riscv_alu.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/riscv/./rtl/riscv_alu_basic.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/riscv/./rtl/riscv_alu_div.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/riscv/./rtl/riscv_compressed_decoder.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/riscv/./rtl/riscv_controller.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/riscv/./rtl/riscv_cs_registers.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/riscv/./rtl/riscv_decoder.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/riscv/./rtl/riscv_int_controller.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/riscv/./rtl/riscv_ex_stage.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/riscv/./rtl/riscv_hwloop_controller.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/riscv/./rtl/riscv_hwloop_regs.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/riscv/./rtl/riscv_id_stage.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/riscv/./rtl/riscv_if_stage.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/riscv/./rtl/riscv_load_store_unit.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/riscv/./rtl/riscv_mult.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/riscv/./rtl/riscv_prefetch_buffer.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/riscv/./rtl/riscv_prefetch_L0_buffer.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/riscv/./rtl/riscv_core.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/riscv/./rtl/riscv_apu_disp.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/riscv/./rtl/riscv_fetch_fifo.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/riscv/./rtl/riscv_L0_buffer.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/riscv/./rtl/riscv_pmp.sv
#
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/riscv/./rtl/register_file_test_wrap.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/riscv/./rtl/riscv_register_file.sv
#
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/ibex/rtl/ibex_pkg.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/ibex/rtl/ibex_alu.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/ibex/rtl/ibex_compressed_decoder.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/ibex/rtl/ibex_controller.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/ibex/rtl/ibex_cs_registers.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/ibex/rtl/ibex_counters.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/ibex/rtl/ibex_decoder.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/ibex/rtl/ibex_ex_block.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/ibex/rtl/ibex_id_stage.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/ibex/rtl/ibex_if_stage.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/ibex/rtl/ibex_wb_stage.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/ibex/rtl/ibex_load_store_unit.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/ibex/rtl/ibex_multdiv_slow.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/ibex/rtl/ibex_multdiv_fast.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/ibex/rtl/ibex_prefetch_buffer.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/ibex/rtl/ibex_fetch_fifo.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/ibex/rtl/ibex_pmp.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/ibex/rtl/ibex_core.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/ibex/shared/rtl/prim_assert.sv
#
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/ibex/rtl/ibex_register_file_fpga.sv
#
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/scm/fpga_scm/register_file_1r_1w_all.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/scm/fpga_scm/register_file_1r_1w_be.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/scm/fpga_scm/register_file_1r_1w.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/scm/fpga_scm/register_file_1r_1w_1row.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/scm/fpga_scm/register_file_1r_1w_raw.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/scm/fpga_scm/register_file_1w_multi_port_read.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/scm/fpga_scm/register_file_1w_64b_multi_port_read_32b.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/scm/fpga_scm/register_file_1w_64b_1r_32b.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/scm/fpga_scm/register_file_2r_1w_asymm.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/scm/fpga_scm/register_file_2r_1w_asymm_test_wrap.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/scm/fpga_scm/register_file_2r_2w.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/scm/fpga_scm/register_file_3r_2w.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/scm/fpga_scm/register_file_3r_2w_be.sv
#
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/tech_cells_generic/src/deprecated/pulp_clock_gating_async.sv
#
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/tech_cells_generic/src/deprecated/cluster_clk_cells_xilinx.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/tech_cells_generic/src/deprecated/cluster_pwr_cells.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/tech_cells_generic/src/deprecated/pulp_clk_cells_xilinx.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/tech_cells_generic/src/deprecated/pulp_pwr_cells.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/tech_cells_generic/src/deprecated/pulp_buffer.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/tech_cells_generic/src/fpga/tc_clk_xilinx.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/tech_cells_generic/src/tc_pwr.sv
#
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_core/rtl/core/udma_ch_addrgen.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_core/rtl/core/udma_arbiter.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_core/rtl/core/udma_core.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_core/rtl/core/udma_rx_channels.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_core/rtl/core/udma_tx_channels.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_core/rtl/core/udma_stream_unit.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_core/rtl/common/udma_ctrl.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_core/rtl/common/udma_apb_if.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_core/rtl/common/io_clk_gen.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_core/rtl/common/io_event_counter.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_core/rtl/common/io_generic_fifo.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_core/rtl/common/io_tx_fifo.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_core/rtl/common/io_tx_fifo_mark.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_core/rtl/common/io_tx_fifo_dc.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_core/rtl/common/io_shiftreg.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_core/rtl/common/udma_dc_fifo.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_core/rtl/common/udma_clkgen.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_core/rtl/common/udma_clk_div_cnt.sv
#
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_uart/rtl/udma_uart_reg_if.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_uart/rtl/udma_uart_top.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_uart/rtl/udma_uart_rx.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_uart/rtl/udma_uart_tx.sv
#
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_i2c/rtl/udma_i2c_reg_if.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_i2c/rtl/udma_i2c_bus_ctrl.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_i2c/rtl/udma_i2c_control.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_i2c/rtl/udma_i2c_top.sv
#
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_i2s/rtl/i2s_clk_gen.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_i2s/rtl/i2s_rx_channel.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_i2s/rtl/i2s_tx_channel.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_i2s/rtl/i2s_ws_gen.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_i2s/rtl/i2s_clkws_gen.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_i2s/rtl/i2s_txrx.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_i2s/rtl/cic_top.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_i2s/rtl/cic_integrator.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_i2s/rtl/cic_comb.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_i2s/rtl/pdm_top.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_i2s/rtl/udma_i2s_reg_if.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_i2s/rtl/udma_i2s_top.sv
#
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_qspi/rtl/udma_spim_reg_if.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_qspi/rtl/udma_spim_ctrl.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_qspi/rtl/udma_spim_txrx.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_qspi/rtl/udma_spim_top.sv
#
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_sdio/rtl/sdio_crc7.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_sdio/rtl/sdio_crc16.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_sdio/rtl/sdio_txrx_cmd.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_sdio/rtl/sdio_txrx_data.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_sdio/rtl/sdio_txrx.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_sdio/rtl/udma_sdio_reg_if.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_sdio/rtl/udma_sdio_top.sv
#
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_camera/rtl/camera_reg_if.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_camera/rtl/camera_if.sv
#
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_filter/rtl/udma_filter_au.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_filter/rtl/udma_filter_bincu.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_filter/rtl/udma_filter_rx_dataout.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_filter/rtl/udma_filter_tx_datafetch.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_filter/rtl/udma_filter_reg_if.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_filter/rtl/udma_filter.sv
#
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_external_per/rtl/udma_external_per_reg_if.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_external_per/rtl/udma_external_per_wrapper.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_external_per/rtl/udma_external_per_top.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_external_per/rtl/udma_traffic_gen_rx.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/udma/udma_external_per/rtl/udma_traffic_gen_tx.sv
#
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/hwpe-ctrl/rtl/hwpe_ctrl_package.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/hwpe-ctrl/rtl/hwpe_ctrl_interfaces.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/hwpe-ctrl/rtl/hwpe_ctrl_regfile.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/hwpe-ctrl/rtl/hwpe_ctrl_regfile_latch.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/hwpe-ctrl/rtl/hwpe_ctrl_slave.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/hwpe-ctrl/rtl/hwpe_ctrl_seq_mult.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/hwpe-ctrl/rtl/hwpe_ctrl_ucode.sv
#
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/hwpe-stream/rtl/hwpe_stream_package.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/hwpe-stream/rtl/hwpe_stream_interfaces.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/hwpe-stream/rtl/hwpe_stream_addressgen.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/hwpe-stream/rtl/hwpe_stream_fifo_earlystall_sidech.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/hwpe-stream/rtl/hwpe_stream_fifo_earlystall.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/hwpe-stream/rtl/hwpe_stream_fifo_scm.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/hwpe-stream/rtl/hwpe_stream_fifo_sidech.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/hwpe-stream/rtl/hwpe_stream_fifo.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/hwpe-stream/rtl/hwpe_stream_buffer.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/hwpe-stream/rtl/hwpe_stream_merge.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/hwpe-stream/rtl/hwpe_stream_fence.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/hwpe-stream/rtl/hwpe_stream_split.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/hwpe-stream/rtl/hwpe_stream_sink.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/hwpe-stream/rtl/hwpe_stream_source.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/hwpe-stream/rtl/hwpe_stream_sink_realign.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/hwpe-stream/rtl/hwpe_stream_source_realign.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/hwpe-stream/rtl/hwpe_stream_mux_static.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/hwpe-stream/rtl/hwpe_stream_demux_static.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/hwpe-stream/rtl/hwpe_stream_tcdm_fifo_load.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/hwpe-stream/rtl/hwpe_stream_tcdm_fifo_load_sidech.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/hwpe-stream/rtl/hwpe_stream_tcdm_fifo_store.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/hwpe-stream/rtl/hwpe_stream_tcdm_mux.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/hwpe-stream/rtl/hwpe_stream_tcdm_mux_static.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/hwpe-stream/rtl/hwpe_stream_tcdm_reorder.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/hwpe-stream/rtl/hwpe_stream_tcdm_reorder_static.sv
#
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/hwpe-mac-engine/rtl/mac_package.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/hwpe-mac-engine/rtl/mac_fsm.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/hwpe-mac-engine/rtl/mac_ctrl.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/hwpe-mac-engine/rtl/mac_streamer.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/hwpe-mac-engine/rtl/mac_engine.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/hwpe-mac-engine/rtl/mac_top.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/hwpe-mac-engine/wrap/mac_top_wrap.sv
#
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/riscv-dbg/src/dm_pkg.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/riscv-dbg/debug_rom/debug_rom.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/riscv-dbg/src/dm_csrs.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/riscv-dbg/src/dm_mem.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/riscv-dbg/src/dm_top.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/riscv-dbg/src/dmi_cdc.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/riscv-dbg/src/dmi_jtag.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/riscv-dbg/src/dmi_jtag_tap.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/riscv-dbg/src/dm_sba.sv
# 
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/register_interface/src/reg_intf_pkg.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/register_interface/src/reg_intf.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/register_interface/src/apb_to_reg.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/register_interface/src/axi_to_reg.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/register_interface/src/reg_cdc.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/register_interface/src/reg_demux.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/register_interface/src/reg_mux.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/register_interface/src/reg_to_mem.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/register_interface/src/reg_uniform.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/register_interface/src/axi_lite_to_reg.sv
#
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/register_interface/vendor/lowrisc_opentitan/src/prim_subreg.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/register_interface/vendor/lowrisc_opentitan/src/prim_subreg_arb.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/register_interface/vendor/lowrisc_opentitan/src/prim_subreg_ext.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/register_interface/vendor/lowrisc_opentitan/src/prim_subreg_shadow.sv
#
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/pulp_soc/rtl/pulp_soc/pkg_soc_interconnect.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/pulp_soc/rtl/pulp_soc/axi64_2_lint32_wrap.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/pulp_soc/rtl/pulp_soc/lint_2_axi_wrap.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/pulp_soc/rtl/pulp_soc/contiguous_crossbar.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/pulp_soc/rtl/pulp_soc/interleaved_crossbar.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/pulp_soc/rtl/pulp_soc/tcdm_demux.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/pulp_soc/rtl/pulp_soc/boot_rom.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/pulp_soc/rtl/pulp_soc/l2_ram_multi_bank.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/pulp_soc/rtl/pulp_soc/lint_jtag_wrap.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/pulp_soc/rtl/pulp_soc/periph_bus_wrap.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/pulp_soc/rtl/pulp_soc/soc_clk_rst_gen.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/pulp_soc/rtl/pulp_soc/soc_event_arbiter.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/pulp_soc/rtl/pulp_soc/soc_event_generator.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/pulp_soc/rtl/pulp_soc/soc_event_queue.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/pulp_soc/rtl/pulp_soc/tcdm_error_slave.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/pulp_soc/rtl/pulp_soc/soc_interconnect.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/pulp_soc/rtl/pulp_soc/soc_interconnect_wrap.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/pulp_soc/rtl/pulp_soc/soc_peripherals.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/pulp_soc/rtl/pulp_soc/pulp_soc.sv
#
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/pulp_soc/rtl/udma_subsystem/udma_subsystem.sv
#
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/pulp_soc/rtl/fc/fc_demux.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/pulp_soc/rtl/fc/fc_subsystem.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/pulp_soc/rtl/fc/fc_hwpe.sv
#
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/pulp_soc/rtl/components/apb_clkdiv.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/pulp_soc/rtl/components/apb_timer_unit.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/pulp_soc/rtl/components/apb_soc_ctrl.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/pulp_soc/rtl/components/memory_models.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/pulp_soc/rtl/components/pulp_interfaces.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/pulp_soc/rtl/components/glitch_free_clk_mux.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/pulp_soc/rtl/components/scm_2048x32.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/pulp_soc/rtl/components/scm_512x32.sv
set_global_assignment -name SYSTEMVERILOG_FILE $IPS/pulp_soc/rtl/components/tcdm_arbiter_2x1.sv

#pulpissimo
set_global_assignment -name SYSTEMVERILOG_FILE /home/victor/pulp_shared_vm/pulp_box/pulpissimo/rtl/pulpissimo/jtag_tap_top.sv 
set_global_assignment -name SYSTEMVERILOG_FILE /home/victor/pulp_shared_vm/pulp_box/pulpissimo/rtl/pulpissimo/pad_control.sv 
set_global_assignment -name SYSTEMVERILOG_FILE /home/victor/pulp_shared_vm/pulp_box/pulpissimo/rtl/pulpissimo/pad_frame.sv 
set_global_assignment -name SYSTEMVERILOG_FILE /home/victor/pulp_shared_vm/pulp_box/pulpissimo/rtl/pulpissimo/safe_domain.sv 
set_global_assignment -name SYSTEMVERILOG_FILE /home/victor/pulp_shared_vm/pulp_box/pulpissimo/rtl/pulpissimo/soc_domain.sv 
set_global_assignment -name SYSTEMVERILOG_FILE /home/victor/pulp_shared_vm/pulp_box/pulpissimo/rtl/pulpissimo/rtc_date.sv 
set_global_assignment -name SYSTEMVERILOG_FILE /home/victor/pulp_shared_vm/pulp_box/pulpissimo/rtl/pulpissimo/rtc_clock.sv 
set_global_assignment -name SYSTEMVERILOG_FILE /home/victor/pulp_shared_vm/pulp_box/pulpissimo/rtl/pulpissimo/pulpissimo.sv 

# Set Verilog defines
set_global_assignment -name VERILOG_FILE /home/victor/pulp_shared_vm/pulp_box/pulpissimo/fpga/aux_def_vers_quartus.v

#top level
set_global_assignment -name VERILOG_FILE /home/victor/pulp_shared_vm/pulp_box/pulpissimo/fpga/pulpissimo-zedboard/rtl/xilinx_pulpissimo.v
set_global_assignment -name TOP_LEVEL_ENTITY xilinx_pulpissimo

# Add constraints files
set_global_assignment -name SDC_FILE /home/victor/pulp_shared_vm/pulp_box/pulpissimo/fpga/DE10_Standard.SDC

# Compile the design
exec quartus_map $PROJECT
exec quartus_fit $PROJECT
exec quartus_sta $PROJECT

exec quartus_asm $PROJECT

# Generate Bitstream
exec quartus_cpf -c output.sof sockit_fpga.pof

puts "Bitstream generation for SoCKit finished. The .sof and .pof files are ready."






