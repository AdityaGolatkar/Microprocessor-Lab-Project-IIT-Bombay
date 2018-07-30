ghdl --remove
ghdl -a Microprocessor.vhd
ghdl -a ALU_2.vhd
ghdl -a decoder.vhd
ghdl -a ForwardUnit.vhd
ghdl -a encoder1.vhd
ghdl -a HDU.vhd
ghdl -a priority_encoder.vhd
ghdl -a ALU.vhd
ghdl -a ControlSignals.vhd
ghdl -a RFComplete.vhd
ghdl -a code_memory.vhd
ghdl -a data_memory.vhd
ghdl -a RF.vhd
ghdl -a IF_ID.vhd
ghdl -a ID_RR.vhd
ghdl -a RR_EX.vhd
ghdl -a EX_MA.vhd
ghdl -a MA_WB.vhd
ghdl -a IF_stage.vhd
ghdl -a ID_stage.vhd
ghdl -a RR.vhd
ghdl -a EX_entity.vhd
ghdl -a MA.vhd
ghdl -a WB_entity.vhd
ghdl -a tb_microprocessors.vhd
ghdl -m tb_microprocessors
ghdl -r tb_microprocessors --stop-time=1200ns --wave=run.ghw
