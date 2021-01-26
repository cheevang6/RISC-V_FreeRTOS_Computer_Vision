open_project -project {D:\Work\Libero\IGL2_MiV_FreeRTOS_Demo\designer\Top_Level\Top_Level_fp\Top_Level.pro}\
         -connect_programmers {FALSE}
if { [catch {load_programming_data \
    -name {M2GL025} \
    -fpga {D:\Work\Libero\IGL2_MiV_FreeRTOS_Demo\designer\Top_Level\Top_Level.map} \
    -header {D:\Work\Libero\IGL2_MiV_FreeRTOS_Demo\designer\Top_Level\Top_Level.hdr} \
    -envm {D:\Work\Libero\IGL2_MiV_FreeRTOS_Demo\designer\Top_Level\Top_Level.efc}  \
    -spm {D:\Work\Libero\IGL2_MiV_FreeRTOS_Demo\designer\Top_Level\Top_Level.spm} \
    -dca {D:\Work\Libero\IGL2_MiV_FreeRTOS_Demo\designer\Top_Level\Top_Level.dca} } return_val] } {
    save_project
    close_project
    exit }
if { [catch {export_single_ppd \
    -name {M2GL025} \
    -file {D:\Work\Libero\IGL2_MiV_FreeRTOS_Demo\designer\Top_Level\export/tempExport\Top_LevelIGL2_MiV_FreeRTOS_Demo.ppd}} return_val ] } {
    save_project
    close_project
    exit}

set_programming_file -name {M2GL025} -no_file
save_project
close_project
