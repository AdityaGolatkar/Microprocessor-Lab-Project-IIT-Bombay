library ieee;
use ieee.std_logic_1164.all;
entity priority_encoder is
   port(x: in std_logic_vector(15 downto 0);
	enable: in std_logic;
   a: out std_logic_vector(2 downto 0);
	i: out std_logic_vector(15 downto 0);
	done: out std_logic);
end entity;

architecture Behave of priority_encoder is
   begin
   	process(x,enable)
		variable pos: integer := 0;
		variable tmp: std_logic_vector(15 downto 0) := (others => '1');
   	begin
		if(enable = '1') then 
			if(x = "0000000000000000") then
				done <= '1';
				i <= "1111111111111111";
				a <= "000";
			else
				for J in 0 to 7	loop 
					if (x(J) = '1') then
						pos := J;
						tmp(J) := '0';
						exit;
					end if;
				end loop;
				
				i <= tmp;				

				if(pos = 0) then
					a <= "000";
				elsif(pos = 1) then
					a <= "001";
				elsif(pos <= 2) then
					a <= "010";
				elsif(pos <= 3) then
					a <= "011";
				elsif(pos <= 4) then
					a <= "100";
				elsif(pos <= 5) then
					a <= "101";		
				elsif(pos <= 6) then
					a <= "110";
				else
					a <= "111";
				end if;
				
				done <= '0';
			end if;
		end if;
	end process;
end Behave;
  

