onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate {/varExperiment_top_tb/DUT/dut0/u_pipeline[0]/CLK}
add wave -noupdate {/varExperiment_top_tb/DUT/dut0/u_pipeline[0]/SE}
add wave -noupdate {/varExperiment_top_tb/DUT/dut0/u_pipeline[0]/DELAY_CTRL_BITS}
add wave -noupdate {/varExperiment_top_tb/DUT/dut0/u_pipeline[0]/PRIME_L2}
add wave -noupdate {/varExperiment_top_tb/DUT/dut0/u_pipeline[0]/enable_l1_sync}
add wave -noupdate {/varExperiment_top_tb/DUT/dut0/u_pipeline[0]/enable_l2}
add wave -noupdate {/varExperiment_top_tb/DUT/dut0/u_pipeline[0]/word_in}
add wave -noupdate {/varExperiment_top_tb/DUT/dut0/u_pipeline[0]/word_out}
add wave -noupdate {/varExperiment_top_tb/DUT/dut0/u_pipeline[0]/scan_chain}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2117000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
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
WaveRestoreZoom {1147461 ps} {2891845 ps}
