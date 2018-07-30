library std;
use std.standard.all;
use std.textio.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.ALL;
library work;
use work.Pack.all;

entity memory_TB is
end entity;


architecture Behave of memory_TB is
	
   component memory_new is
   	port(clk,reset: in std_logic;
	mem_enable: in std_logic;
     	r_w: in std_logic;
  	addr: in std_logic_vector(15 downto 0);
        write_data: in std_logic_vector(15 downto 0); 
        read_data: out std_logic_vector(15 downto 0));
   end component;

	  signal clk: std_logic := '0';
  	signal reset: std_logic := '1';
	signal mem_enable: std_logic;
     	signal r_w: std_logic;
  	signal addr: std_logic_vector(15 downto 0);
        signal write_data: std_logic_vector(15 downto 0); 
        signal read_data: std_logic_vector(15 downto 0);

----------------------------------------
----------to_std_logic------------------------------------------------
  function to_std_logic(x: bit) return std_logic is
      variable ret_val: std_logic;
  begin  
      if (x = '1') then
        ret_val := '1';
      else 
        ret_val := '0';
      end if;
      return(ret_val);
  end to_std_logic;
------------------------------------
function to_string(x: string) return string is
      variable ret_val: string(1 to x'length);
      alias lx : string (1 to x'length) is x;
  begin  
      ret_val := lx;
      return(ret_val);
  end to_string;

function to_bstring(sl : std_logic) return string is
  variable sl_str_v : string(1 to 3);  -- std_logic image with quotes around
begin
  sl_str_v := std_logic'image(sl);
  return "" & sl_str_v(2);  -- "" & character to get string
end function;

function to_bstring(slv : std_logic_vector) return string is
  alias    slv_norm : std_logic_vector(1 to slv'length) is slv;
  variable sl_str_v : string(1 to 1);  -- String of std_logic
  variable res_v    : string(1 to slv'length);
begin
  for idx in slv_norm'range loop
    sl_str_v := to_bstring(slv_norm(idx));
    res_v(idx) := sl_str_v(1);
  end loop;
  return res_v;
end function;

function hstr(slv: std_logic_vector) 
	return string is 
	variable hexlen: integer; 
	variable longslv : std_logic_vector(67 downto 0) := (others => '0'); 
	variable hex : string(1 to 16); variable fourstd_logic : std_logic_vector(3 downto 0); 
	begin 
	hexlen := (slv'left+1)/4; 
		if (slv'left+1) mod 4 /= 0 then hexlen := hexlen + 1;
		end if; longslv(slv'left downto 0) := slv;
		for i in (hexlen -1) downto 0 loop fourstd_logic := longslv(((i*4)+3) downto (i*4));
		 case fourstd_logic is 
			when "0000" => hex(hexlen -I) := '0';
			when "0001" => hex(hexlen -I) := '1'; 
			when "0010" => hex(hexlen -I) := '2'; 
			when "0011" => hex(hexlen -I) := '3'; 
			when "0100" => hex(hexlen -I) := '4'; 
			when "0101" => hex(hexlen -I) := '5'; 
			when "0110" => hex(hexlen -I) := '6'; 
			when "0111" => hex(hexlen -I) := '7'; 
			when "1000" => hex(hexlen -I) := '8'; 
			when "1001" => hex(hexlen -I) := '9'; 
			when "1010" => hex(hexlen -I) := 'A'; 
			when "1011" => hex(hexlen -I) := 'B'; 
			when "1100" => hex(hexlen -I) := 'C'; 
			when "1101" => hex(hexlen -I) := 'D'; 
			when "1110" => hex(hexlen -I) := 'E'; 
			when "1111" => hex(hexlen -I) := 'F'; 
			--when "ZZZZ" => hex(hexlen -I) := 'z'; 
			--when "UUUU" => hex(hexlen -I) := 'u'; 
			--when "XXXX" => hex(hexlen -I) := 'x'; 
			when others => hex(hexlen -I) := '?'; 
		end case; 
		end loop; 
	return hex(1 to hexlen); 
end hstr;
----------------------------

begin
  clk <= not clk after 10 ns; -- assume 10ns clock.

    -- reset process
  process
  begin
     wait until clk = '1';
     reset <= '0';
     wait;
  end process;

	process
	--  variables to be declared here
	FILE OUTFILE: text  open write_mode is "OUTPUTS.txt";
	variable OUTPUT_LINE: Line;
    		


	begin
	write(OUTPUT_LINE,to_string("Start..."));
	
   writeline(OUTFILE, OUTPUT_LINE);
	
	wait until clk = '0';

	------------------ read write instructions to DUT (memory)-------------
	
	--wait until clk = '1';
	--write @16'b0
	--wait for 20 ns; 
	r_w <= '1'; mem_enable <= '1'; addr <= "0000000000000000" ; write_data <= "0000000000011100" ;
	write(OUTPUT_LINE,to_string("Data Writen"));
        writeline(OUTFILE, OUTPUT_LINE);
	
	 
	--read @16'b0
	wait for 20 ns;
	r_w <= '0'; mem_enable <= '1'; addr <= "0000000000000000";
	write(OUTPUT_LINE,hstr(read_data));
        writeline(OUTFILE, OUTPUT_LINE);
	
	 
	--wait until clk = '1';
	--write @16'd17	
	wait for 20 ns;  
	r_w <= '1'; mem_enable <= '1'; addr <= "0000000000010001" ; write_data <= "0000000000010001" ;
	write(OUTPUT_LINE,to_string("Data Writen"));
        writeline(OUTFILE, OUTPUT_LINE);
	
	 

	--read @16'd17
	wait for 20 ns; 
	r_w <= '0'; mem_enable <= '1'; addr <= "0000000000010001";
	write(OUTPUT_LINE,hstr(read_data));
        writeline(OUTFILE, OUTPUT_LINE);
	
	--wait until clk = '1';
	--write @16'd30		 
	wait for 20 ns; 
	r_w <= '1'; mem_enable <= '1'; addr <= "0000000000011110" ; write_data <= "0000000000011110";
	write(OUTPUT_LINE,to_string("Data Writen"));
        writeline(OUTFILE, OUTPUT_LINE);
	
	 

	--read @16'b0
	wait for 20 ns;
	r_w <= '0'; mem_enable <= '1'; addr <= "0000000000000000";
	write(OUTPUT_LINE,hstr(read_data));
        writeline(OUTFILE, OUTPUT_LINE);
	 

	--read @16'd17
	wait for 20 ns; 
	r_w <= '0'; mem_enable <= '1'; addr <= "0000000000010001";
	write(OUTPUT_LINE,hstr(read_data));
        writeline(OUTFILE, OUTPUT_LINE);
	 

	--read @16'd30
	wait for 20 ns; 
	r_w <= '0'; mem_enable <= '1'; addr <= "0000000000011110";
	write(OUTPUT_LINE,hstr(read_data));
        writeline(OUTFILE, OUTPUT_LINE);
	
	wait;
	-----------------------------------------------------------------------
 end process;

  dut: memory_new
     port map(clk =>clk, reset => reset,
              mem_enable => mem_enable,
              r_w => r_w, 
	      addr => addr,              
              write_data => write_data ,
              read_data => read_data);

		
end Behave;
