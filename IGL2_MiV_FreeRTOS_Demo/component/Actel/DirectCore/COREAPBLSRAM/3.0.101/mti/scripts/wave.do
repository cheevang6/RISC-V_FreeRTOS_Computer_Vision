onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {APB LSRAM}
add wave -noupdate -color Violet /testbench/COREAPBLSRAM_0/PCLK
add wave -noupdate -color Violet /testbench/COREAPBLSRAM_0/PRESETN
add wave -noupdate -color Violet /testbench/COREAPBLSRAM_0/PSEL
add wave -noupdate -color Violet /testbench/COREAPBLSRAM_0/PENABLE
add wave -noupdate -color Violet /testbench/COREAPBLSRAM_0/PWRITE
add wave -noupdate -color Violet /testbench/COREAPBLSRAM_0/PADDR
add wave -noupdate -color Violet /testbench/COREAPBLSRAM_0/PWDATA
add wave -noupdate -color Violet /testbench/COREAPBLSRAM_0/PRDATA
add wave -noupdate -color Violet /testbench/COREAPBLSRAM_0/PSLVERR
add wave -noupdate -color Violet /testbench/COREAPBLSRAM_0/PREADY
add wave -noupdate -color Violet /testbench/COREAPBLSRAM_0/addr
add wave -noupdate -color Violet /testbench/COREAPBLSRAM_0/wen
add wave -noupdate -color Violet /testbench/COREAPBLSRAM_0/ren
add wave -noupdate -divider {Memory signals}
add wave -noupdate /testbench/COREAPBLSRAM_0/genblk1/genblk1/lsram_512to35328x32_block0/writeData
add wave -noupdate /testbench/COREAPBLSRAM_0/genblk1/genblk1/lsram_512to35328x32_block0/wen
add wave -noupdate /testbench/COREAPBLSRAM_0/genblk1/genblk1/lsram_512to35328x32_block0/ren
add wave -noupdate /testbench/COREAPBLSRAM_0/genblk1/genblk1/lsram_512to35328x32_block0/writeAddr
add wave -noupdate /testbench/COREAPBLSRAM_0/genblk1/genblk1/lsram_512to35328x32_block0/readAddr
add wave -noupdate /testbench/COREAPBLSRAM_0/genblk1/genblk1/lsram_512to35328x32_block0/readData
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {499260000 ps} 0}
configure wave -namecolwidth 356
configure wave -valuecolwidth 262
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {408730 ps}
