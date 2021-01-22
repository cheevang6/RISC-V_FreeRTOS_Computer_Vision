# Core10100  v3.0  01Sep06

quietly set fam    VARfam
quietly set famnum VARfnum

################################################################
# Switch management

quietly set do_wave  1
quietly set do_core  1
quietly set do_amba  1
quietly set do_tb    1
quietly set do_run   1
quietly set testnum  0
quietly set debug    0
quietly set obfuscate 0
quietly set do_quit   0

quietly set Nparas $argc
quietly set allokay  1

while { $Nparas>0 } {
 quietly set para  $1
 quietly set Nparas [expr $Nparas - 1 ]
 quietly set okay  0

 if {$para == "-clean" } {
     puts "####################"
     puts "Removing old Library"
     vlib Core10100_LIB
     vdel -lib Core10100_LIB -all
     vlib Core10100_LIB
     puts "####################"
     quietly set okay 1
 }
 
 if {$para == "-core" } {
     quietly set do_core  0
     puts "Not Compiling Core"
     quietly set okay 1
 }
 
 if {$para == "-amba" } {
     quietly set do_amba  0
     quietly set do_core  0
     puts "Not Compiling Core and AMBA Wrapper"
     quietly set okay 1
 }

 if {$para == "-debug" } {
     quietly set debug  0
     quietly set okay 1
 }

 if { $para == "+debug" } {
     quietly set debug  1
     quietly set okay 1
 }

 if {$para == "-tb" } {
     quietly set do_core  0
     quietly set do_amba  0
     quietly set do_tb  0
     puts "Not Compiling Core, Wrapper & Testbench"
     quietly set okay 1
 }

 if {$para == "-testnum" || $para == "-test" } {
     quietly set Nparas [expr $Nparas - 1 ]
     shift
     quietly set testnum  $1
     quietly set okay 1
 }

 if {$para == "-run" } {
     quietly set do_run  0
     puts "run dissabled"
     quietly set okay 1
 }

 if {$para == "+run" } {
     quietly set do_run  1
     quietly set do_core  0
     quietly set do_amba  0
     quietly set do_tb    0
     puts "Just running simulation"
     quietly set okay 1
 }

 if {$para == "+obfus" } {
     quietly set obfuscate  1
     puts "Using Obfuscated Code"
     quietly set okay 1
 }

 if {$para == "-obfus" } {
     quietly set obfuscate  0
     puts "Using Normal Code"
     quietly set okay 1
 }
 
 if {$para == "-wave" } {
     quietly set do_wave  0
     puts "waves dissabled"
     quietly set okay 1
 }

 if {$para == "-quit" } {
     quietly set do_quit  1
     quietly set okay 1
 }


 if {$okay == 0 } {
   quietly set allokay 0
   puts "ERROR: Incorrect Parameters to compile.do"
   puts " do compile.do  [switches] "
   puts "  -clean   remove all previously compiled files"
   puts "  -core    does not recompile the core"
   puts "  -amba    does not recompile the amba wrapper"
   puts "  -tb      does not recompile the testbench"
   puts "  -run     disable simulation run"
   puts "  +run     just run the simulation"
   puts "  -debug   turn off debug mode"
   puts "  +debug   turn on debug mode"
   puts "  +obfus   use obfuscated source code"
   puts "  -obfus   use non obfuscated source code"
   puts "  -wave    do not load the wave.do file"
   puts "  -test N  run with configuration N"
   puts "  -quit    when simulation completes quit the simulator"
 }

 shift
}

quietly set chmod_exe    "/bin/chmod"
quietly set linux_exe    "./bfmtovec.lin"
quietly set windows_exe  "./bfmtovec.exe"

# check OS type and use appropriate executable
if {$tcl_platform(os) == "Linux"} {
	echo "--- Using Linux Actel DirectCore AMBA BFM compiler"
	quietly set bfmtovec_exe $linux_exe
	if {![file executable $bfmtovec_exe]} {
		quietly set cmds "exec $chmod_exe +x $bfmtovec_exe"
		eval $cmds
	}
} else {
	echo "--- Using Windows Actel DirectCore AMBA BFM compiler"
	quietly set bfmtovec_exe $windows_exe
}

exec $bfmtovec_exe -in "core10100.bfm" -out "core10100.vec"  
