library ieee;
use ieee.std_logic_1164.all;
library std;
library work;
use work.Pack.all;

entity tb_microprocessors is
end entity;
architecture Behave of tb_microprocessors is

component Microprocessor is
port(    reset: in std_logic;
	 clk: in std_logic
	);
end component;

signal clk: std_logic := '1';
signal reset: std_logic := '1';

begin
    dut: Microprocessor port map(reset => reset,clk=> clk);
    clk <= not clk after 1 ns; -- assume 2ns clock.
	 
	 --reset process
   process
   begin
      wait until clk = '0';
      wait until clk = '1';
      reset <= '0';
      wait;
   end process;
  
  process 
  begin
  wait;
  end process;

end Behave;
