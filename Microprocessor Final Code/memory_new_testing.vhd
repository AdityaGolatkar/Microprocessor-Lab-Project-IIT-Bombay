library std;
use std.standard.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.ALL;

package Pack is
  component memory_new is
   port(clk,reset: in std_logic;
	mem_enable: in std_logic;
     	r_w: in std_logic;
  	addr: in std_logic_vector(15 downto 0);
        write_data: in std_logic_vector(15 downto 0); 
        read_data: out std_logic_vector(15 downto 0));
   end component;
  component DataRegister is
	generic (data_width:integer);
	port (Din: in std_logic_vector(data_width-1 downto 0);
	      Dout: out std_logic_vector(data_width-1 downto 0);
	      clk, enable: in std_logic);
  end component DataRegister;
end Pack;

--------------------DataRegister--------------
library ieee;
use ieee.std_logic_1164.all;
entity DataRegister is
	generic (data_width:integer);
	port (Din: in std_logic_vector(data_width-1 downto 0);
	      Dout: out std_logic_vector(data_width-1 downto 0);
	      clk, enable: in std_logic);
end entity;
architecture Behave of DataRegister is
begin
    process(clk)
    begin
       if(clk'event and (clk  = '1')) then
           if(enable = '1') then
               Dout <= Din;
           end if;
       end if;
    end process;
end Behave;
-------------End DatRegister-----------

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
	type mem_instruction is array(0 to 49) of std_logic_vector(15 downto 0);
	signal temp : mem_instruction := ("1000000000011101",
					   "0100100110000101",
					   "0100110110000101",
					   "0100000101010100",
					   "0100001101010101",
					   "0001000010000000",
					   "0010000001011000",
					   "0010011011011000",
                                           "0001011011000000",
					   "0000100010100001",
					   "0000000000000000",
					   "0010110110110010",
					   "1100110101111010",
					   "0101100101010110");	
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
					if(I < 49) then 
					mem(I) <= temp(I);
					else mem(I) <= "0000000000000000";
					end if;	
				end loop;
			end if;
		end if;
	end process;
		
end Behave;
		
