quietly set ACTELLIBNAME IGLOO2
quietly set PROJECT_DIR "C:/Users/cheec/Desktop/Master/RISC-V_FreeRTOS_Computer_Vision/SCCB_Testing/sccb_fpga_design/sccb_fpga_design"

if {[file exists presynth/_info]} {
   echo "INFO: Simulation library presynth already exists"
} else {
   file delete -force presynth 
   vlib presynth
}
vmap presynth presynth
vmap IGLOO2 "C:/Microsemi/Libero_SoC_v12.3/Designer/lib/modelsimpro/precompiled/vlog/smartfusion2"
vmap SmartFusion2 "C:/Microsemi/Libero_SoC_v12.3/Designer/lib/modelsimpro/precompiled/vlog/smartfusion2"

vlog -sv -work presynth "${PROJECT_DIR}/component/work/FCCC_C0/FCCC_C0_0/FCCC_C0_FCCC_C0_0_FCCC.v"
vlog -sv -work presynth "${PROJECT_DIR}/component/work/FCCC_C0/FCCC_C0.v"
vlog -sv -work presynth "${PROJECT_DIR}/component/work/OSC_C0/OSC_C0_0/OSC_C0_OSC_C0_0_OSC.v"
vlog -sv -work presynth "${PROJECT_DIR}/component/work/OSC_C0/OSC_C0.v"
vlog -sv -work presynth "${PROJECT_DIR}/hdl/CoreSCCB.v"
vlog -sv -work presynth "${PROJECT_DIR}/hdl/clock_divider.v"
vlog -sv -work presynth "${PROJECT_DIR}/hdl/config_sccb.v"
vlog -sv -work presynth "${PROJECT_DIR}/component/work/sccb_design/sccb_design.v"
vlog "+incdir+${PROJECT_DIR}/stimulus" -sv -work presynth "${PROJECT_DIR}/stimulus/testbench.v"

vsim -L IGLOO2 -L presynth  -t 1fs presynth.testbench
add wave /testbench/*
run 500ns
