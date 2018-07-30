library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.ALL;
entity code_memory is
   port(clk,reset: in std_logic;
	mem_enable: in std_logic;
     	r_w: in std_logic;
  	addr: in std_logic_vector(15 downto 0);
        write_data: in std_logic_vector(15 downto 0); 
        read_data: out std_logic_vector(15 downto 0));
   
end entity code_memory;

architecture Behave of code_memory is
	type mem_arr is array(0 to 1000) of std_logic_vector(15 downto 0);

signal mem: mem_arr := (0 => "0011000000000000",
			1 => "0100001000000000",
			2 => "0011010000000000",
			3 => "0001010010010011",
			4 => "0001000000000001",
			5 => "0100011000000000",
			6 => "0011100000000000",
			7 => "0010100100100000",
			8 => "0010101001100000",
			9 => "0001101101000001",
			10 => "0000100011101000",
			11 => "0011101000000000",
			12 => "0000001011101010",
			13 => "1100000010000100",
			14 => "0011101000000000",
			15 => "0001101101000100",
			16 => "1001100101000000",
			17 => "0101001010000001",
			18 => "0001111111000000",
			others => "0000000000000000");


--signal mem: mem_arr := (0=>"0011000100010001",	--lhi r0 8080
--			1 => "0011001100010001", --lhi r1 8080 
--			2 => "0010010001000000", --nand r2 r1 r0  -- 777F
--			3 => "0001011011000010", --adi r3 r3 #2 
--			4=> "0101000110000001",  --sw r0 r6 1
--			5 => "0001100000110001", --adi r4 r0 110001  -- 8871
--			6 => "0000101000001001",--adz r5 r0 r1  -- 
--			7=> "0100110110000001", --lw r6 r6 1
--			8=>  "0001101101001110",   -- r5 = r5+14
--			9=> "1001110101000000", --jlr r6 r5
--			14 => "1100000001000011", --BEQ R0, R1, #3, PC = PC+3 as R0 = R1
--			17 =>"0110101000001111",  -- LM r5 (0,1,2,3)
--			18 =>"0110010001110000",  -- LM r2 (4,5,6)
--			19 => "0000101101101000", --R5 = R5+R5
--			20 =>"0111101001010101", --SM r5 (store 0,2,4,6)
--			21 =>"0000111100001000", -- ADD R7,R4, R1 --PC = 34
--			34 => "0101111101001000", --SW R7 , R5, #8
--			35 => "0001111111000101", -- ADI R7, R7, #5 -- PC = 40
--			40 => "0000111111000000", -- here SJMP here  
--			others => "0000000000000000");

--signal mem: mem_arr := (0 =>"0011000100010001",	--lhi r0 8080
--			1 => "0011001100010001", --lhi r1 8080 
--			2 => "0000010001000000", --add r2 r1 r0
--			3 => "0010011010001010", --ndc r3 r1 r0
--			4 => "0011001000000000", --lhi r1 0000 
--			5 => "0110001001011101", --lm r1 (load 0,2,3,4,6)
--			6 => "1100000010000010", --beq r0 r2 2
--			7 => "1000101000000100", --jal r5 4
--			8 => "1000101000000100", --jal r5 4  
--			--8=> "1001110101000000", --jlr r6 r5
--			11 =>"0011000100010001", --lhi r0 8080  
--			12 =>"0011000000000000", --lhi r0 0000
--			others => "0000000000000000");

--signal mem: mem_arr := (0=>"0011000100010001",	
--			1 => "0011001000000011", 
--			2 => "0010010001000000",
--			3 => "0000011000001000",
--			4 => "0001100000110001",
--			5 => "0000101000001001",     
--			others => "0000000000000000");
--signal mem: mem_arr := (0=>"0011000100010001",	
--                        1 => "0011001100000011", 
--			2 => "0000010001000000", 
--			3 => "0010 011 001 000 010",  --- NDC 
--			others => "0000000000000000");			
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
		
