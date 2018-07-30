library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;

--package Pack is
--  component decoder is
--   port(X: in std_logic_vector(15 downto 0);
--	enable: in std_logic;
--	Y: in std_logic_vector(2 downto 0);
--        Z0: out std_logic_vector(16 downto 0);
--	Z1: out std_logic_vector(16 downto 0);
--	Z2: out std_logic_vector(16 downto 0);
--	Z3: out std_logic_vector(16 downto 0);
--	Z4: out std_logic_vector(16 downto 0);
--	Z5: out std_logic_vector(16 downto 0);
--	Z6: out std_logic_vector(16 downto 0);
--	Z7: out std_logic_vector(16 downto 0));
--   end component;
--end Pack;

library ieee;
use ieee.std_logic_1164.all;
use work.Pack.all;
entity decoder is
   port(X: in std_logic_vector(15 downto 0);
	enable: in std_logic;
	Y: in std_logic_vector(2 downto 0);
        Z0: out std_logic_vector(16 downto 0);
	Z1: out std_logic_vector(16 downto 0);
	Z2: out std_logic_vector(16 downto 0);
	Z3: out std_logic_vector(16 downto 0);
	Z4: out std_logic_vector(16 downto 0);
	Z5: out std_logic_vector(16 downto 0);
	Z6: out std_logic_vector(16 downto 0);
	Z7: out std_logic_vector(16 downto 0));
end entity;

architecture Behave of decoder is
   begin
   	process(X,Y,enable)
			variable tmp: std_logic_vector(16 downto 0) := (others => '0');
			begin
			if(enable = '1') then 
				if(Y = "000") then
					Z0 <= ('1' & X);
				elsif(Y = "001") then
					Z1 <= ('1' & X);
				elsif(Y = "010") then
					Z2 <= ('1' & X);
				elsif(Y = "011") then
					Z3 <= ('1' & X);
				elsif(Y = "100") then
					Z4 <= ('1' & X);
				elsif(Y = "101") then
					Z5 <= ('1' & X);
				elsif(Y = "110") then
					Z6 <= ('1' & X);
				elsif(Y = "111") then
					Z7 <= ('1' & X);
				end if;
			end if;
		end process;
end Behave;
  

