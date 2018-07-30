library ieee;
use ieee.std_logic_1164.all;
library std;
library work;
use work.Pack.all;

entity Testbench is
end entity;
architecture Behave of Testbench is
signal clk: std_logic := '1';
signal reset: std_logic := '1';

begin
    dut: TopLevel port map(clk=> clk, reset => reset);
	 clk <= not clk after 1 ns; -- assume 2ns clock.
	 
	 -- reset process
  process
  begin
     wait until clk = '0';
     reset <= '0';
     wait;
  end process;
  
  process 
  begin
  wait;
  end process;

end Behave;
