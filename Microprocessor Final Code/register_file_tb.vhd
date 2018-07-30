library std;
use std.standard.all;
use std.textio.all;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.ALL;
library work;
use work.Pack.all;

entity register_file_tb is
end entity;

architecture Behave of register_file_tb is 

	component RFComplete is
	port(A1: in std_logic_vector(2 downto 0);
	A2: in std_logic_vector(2 downto 0);
	A3: in std_logic_vector(2 downto 0);
	D1: out std_logic_vector(15 downto 0);
	D2: out std_logic_vector(15 downto 0);
	D3: in std_logic_vector(15 downto 0);
	RF_write: in std_logic;
	clk : in std_logic);
	end component;
	
	signal A1: std_logic_vector(2 downto 0);
	signal A2: std_logic_vector(2 downto 0);
	signal A3: std_logic_vector(2 downto 0);
	signal D1: std_logic_vector(15 downto 0);
	signal D2: std_logic_vector(15 downto 0);
	signal D3: std_logic_vector(15 downto 0);
	signal RF_write:std_logic;
	signal clk : std_logic := '0';

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

	clk <= not clk after 50 ns; -- assume 10ns clock.


	process
	--  variables to be declared here
	FILE OUTFILE: text  open write_mode is "OUTPUTS.txt";
	variable OUTPUT_LINE: Line;
	
	
	begin
	write(OUTPUT_LINE,to_string("Start..."));
	
        writeline(OUTFILE, OUTPUT_LINE);
	
	wait until clk = '0';
	
	
	-- write on r0
	RF_write <= '1'; A3 <= "000"; D3 <= "0000000000000001";
	
	wait for 200 ns;
	-- write on r1
	RF_write <= '1'; A3 <= "001"; D3 <= "0000000000000010";

	
	wait for 200 ns;
	-- write on r2
	RF_write <= '1'; A3 <= "010"; D3 <= "0000000000000011";


	wait for 200 ns;
	-- write on r3
	RF_write <= '1'; A3 <= "011"; D3 <= "0000000000000100";


	wait for 200 ns;
	-- write on r4
	RF_write <= '1'; A3 <= "100"; D3 <= "0000000000000101";


	wait for 200 ns;
	-- write on r5
	RF_write <= '1'; A3 <= "101"; D3 <= "0000000000000110";


	wait for 200 ns;
	-- write on r6
	RF_write <= '1'; A3 <= "110"; D3 <= "0000000000000111";

	
	wait for 200 ns;
	-- write on r7
	RF_write <= '1'; A3 <= "111"; D3 <= "0000000000001000";


	write(OUTPUT_LINE,to_string("Data Writen on all registers"));
        writeline(OUTFILE, OUTPUT_LINE);


	-- read from the registers
	wait for 200 ns;
	RF_write <= '0'; A1 <= "000";A2 <= "001";
	wait for 200 ns; 
	write(OUTPUT_LINE,hstr(D1));
	write(OUTPUT_LINE,hstr(D2));
        writeline(OUTFILE, OUTPUT_LINE);

	RF_write <= '0'; A1 <= "010";A2 <= "011";
	wait for 200 ns; 
	write(OUTPUT_LINE,hstr(D1));
	write(OUTPUT_LINE,hstr(D2));
        writeline(OUTFILE, OUTPUT_LINE);
	

	RF_write <= '0'; A1 <= "100";A2 <= "101";
	wait for 200 ns; 
	write(OUTPUT_LINE,hstr(D1));
	write(OUTPUT_LINE,hstr(D2));
        writeline(OUTFILE, OUTPUT_LINE);


	RF_write <= '0'; A1 <= "110";A2 <= "111";
	wait for 200 ns; 
	write(OUTPUT_LINE,hstr(D1));
	write(OUTPUT_LINE,hstr(D2));
        writeline(OUTFILE, OUTPUT_LINE);





	wait;

end process;
	
	dut: RFComplete
	port map( clk => clk, RF_write => RF_write, A1 => A1, A2 => A2, A3 => A3, D1 => D1, D2 => D2, D3 => D3);


end Behave;



