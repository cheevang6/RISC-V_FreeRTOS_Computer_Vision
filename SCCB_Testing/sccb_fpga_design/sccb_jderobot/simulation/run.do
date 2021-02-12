quietly set ACTELLIBNAME IGLOO2
quietly set PROJECT_DIR "C:/Users/cheec/Desktop/Master/RISC-V_FreeRTOS_Computer_Vision/SCCB_Testing/sccb_fpga_design/sccb_jderobot"

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
vlog -sv -work presynth "${PROJECT_DIR}/hdl/ov7670_ctrl_reg.v"
vlog -sv -work presynth "${PROJECT_DIR}/hdl/sccb_master.v"
vlog -sv -work presynth "${PROJECT_DIR}/hdl/ov7670_top_ctrl.v"
vlog -sv -work presynth "${PROJECT_DIR}/hdl/top_ov7670.v"
vlog -sv -work presynth "${PROJECT_DIR}/component/work/sccb_desgin/sccb_desgin.v"
vlog -sv -work presynth "${PROJECT_DIR}/hdl/reseting.v"
vlog "+incdir+${PROJECT_DIR}/hdl" "+incdir+${PROJECT_DIR}/component/work/tb" -sv -work presynth "${PROJECT_DIR}/component/work/tb/tb.v"

vsim -L IGLOO2 -L presynth  -t 1fs presynth.tb
add wave /tb/*
run 1000ns
