quietly set ACTELLIBNAME IGLOO2
quietly set PROJECT_DIR "C:/Users/cheec/Desktop/Master/RISC-V_FreeRTOS_Computer_Vision/SCCB_Test"

if {[file exists presynth/_info]} {
   echo "INFO: Simulation library presynth already exists"
} else {
   file delete -force presynth 
   vlib presynth
}
vmap presynth presynth
vmap IGLOO2 "C:/Microsemi/Libero_SoC_v12.3/Designer/lib/modelsimpro/precompiled/vlog/smartfusion2"

vlog -sv -work presynth "${PROJECT_DIR}/hdl/SCCB_CTRL.v"
vlog -sv -work presynth "${PROJECT_DIR}/component/work/sccb_design/sccb_design.v"
vlog "+incdir+${PROJECT_DIR}/stimulus" -sv -work presynth "${PROJECT_DIR}/stimulus/SCCB_tb.v"

vsim -L IGLOO2 -L presynth  -t 1fs presynth.SCCB_tb
add wave /SCCB_tb/*
run 1000ns
