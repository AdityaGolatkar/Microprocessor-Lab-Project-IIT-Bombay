library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.ALL;
entity data_memory is
   port(clk,reset: in std_logic;
	mem_enable: in std_logic;
     	r_w: in std_logic;
  	addr: in std_logic_vector(15 downto 0);
        write_data: in std_logic_vector(15 downto 0); 
        read_data: out std_logic_vector(15 downto 0));
   
end entity data_memory;

architecture Behave of data_memory is
type mem_arr is array(0 to 65535) of std_logic_vector(15 downto 0);
signal mem: mem_arr := (0 => "0000000000000001",
			1 => "0000000000000001",
			2 => "0000000000000011",
			3 => "0000000000000100",
			4 => "0000000000000101",
			5 => "0000000000000110", 
			6 => "0000000000000111", 
			7 => "0000000000001000",
			10 => "0000000000011001",
			11 => "0000000000011010",
			12 => "0000000000011011",
			13 => "0000000000011100",
			15 =>"0000000000001001",  
			16 =>"0000000000001010",
			17 =>"0000000000001011",
			18 =>"0000000000001100",

			others => "0000000000000000");
type mem_instruction is array(0 to 14) of std_logic_vector(15 downto 0);		
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
			read_data <= (others => '1');
	
		end if;
	else	
	read_data <= (others => '1');	
	end if;
end process;
		
end Behave;
		
