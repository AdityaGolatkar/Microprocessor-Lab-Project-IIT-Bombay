library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.ALL;
entity memory_new is
   port(clk,reset: in std_logic;
	mem_enable: in std_logic;
     	r_w: in std_logic;
  	addr: in std_logic_vector(15 downto 0);
        write_data: in std_logic_vector(15 downto 0); 
        read_data: out std_logic_vector(15 downto 0));
   
end entity memory_new;

architecture Behave of memory_new is
	type mem_arr is array(0 to 65535) of std_logic_vector(15 downto 0);
	signal mem: mem_arr;	
begin	
	process(clk,reset,mem_enable,r_w,addr,write_data)
	begin
		if(mem_enable = '1') then
			-- read happens throughout the cycle;
			-- write only at the falling edge;
			if(reset = '0') then 
					-- read case, r_w = 0
					if(r_w = '0') then 
						read_data <= mem(to_integer(unsigned(addr)));
					-- write case, r_w = 1
					else	
					    if(clk'event and (clk  = '1')) then						
						 mem(to_integer(unsigned(addr))) <= write_data;
					    end if;
					  	 -- value at the output is the value that has just been written
						read_data <= write_data;
					end if;	
			else 
				for I in 0 to 65535 loop
					if(I = 0) then
					mem(I) <= "0011010100010001";-- r2 load
					elsif(I = 1) then
					mem(I) <= "0011011100010001";-- r3 load
					elsif(I = 2) then
					mem(I) <= "0010001010011000";-- r1 = r2 + r3 ndu
					elsif(I = 3) then
					mem(I) <= "0010100010011010";-- r4 = r2 + r3 ndc
					elsif(I = 4) then
					mem(I) <= "0010101010011001";-- r5 = r2 + r3 ndz
					elsif(I = 5) then
					mem(I) <= "0001110011000100";-- r6 r3+4 adi
					else
					mem(I) <= "0000000000000000";
					end if;
				end loop;
			end if;
		end if;
	end process;
		
end Behave;
		
