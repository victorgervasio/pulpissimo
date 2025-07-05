source "/home/victor/simplify-5.9/install/fpga/T-2022.09-SP2/lib/altera/quartus_cons.tcl"
syn_create_and_open_prj xilinx_pulpissimo
source $::quartus(binpath)/prj_asd_import.tcl
syn_create_and_open_csf xilinx_pulpissimo
syn_handle_cons xilinx_pulpissimo
