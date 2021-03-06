ghdl --remove
ghdl -a decoder.vhd
ghdl -a RF.vhd
ghdl -a encoder1.vhd
ghdl -a RFComplete.vhd
ghdl -a memory_new.vhd
ghdl -a priority_encoder.vhd
ghdl -a ALU.vhd
ghdl -a Microprocessor.vhd
ghdl -a TopLevel.vhd
ghdl -a Testbench.vhd
ghdl -e Testbench
ghdl -r Testbench --stop-time=10000ns --wave=run.ghw
ghdl -r Testbench --stop-time=100ns --vcd=run.vcd