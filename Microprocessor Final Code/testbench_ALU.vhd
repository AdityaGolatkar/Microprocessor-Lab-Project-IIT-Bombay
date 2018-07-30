library ieee;
use ieee.std_logic_1164.all;
library std;
use std.textio.all;
library work;
use work.Pack.all;

entity testbench_ALU is
end entity;
architecture Behave of testbench_ALU is
  signal X,Y,R: std_logic_vector(15 downto 0);
  signal alu_enable,C_enable,Z_enable,C,Z,alu_done,alu_done_tmp: std_logic;
  signal op_code: std_logic_vector(1 downto 0);
  signal clk,reset: std_logic := '0';

  function to_string(x: string) return string is
      variable ret_val: string(1 to x'length);
      alias lx : string (1 to x'length) is x;
  begin  
      ret_val := lx;
      return(ret_val);
  end to_string;

  function to_std_logic_vector(x: bit_vector) return std_logic_vector is
    alias lx: bit_vector(1 to x'length) is x;
    variable ret_var : std_logic_vector(1 to x'length);
  begin
     for I in 1 to x'length loop
        if(lx(I) = '1') then
           ret_var(I) :=  '1';
        else 
           ret_var(I) :=  '0';
	end if;
     end loop;
     return(ret_var);
  end to_std_logic_vector;

 function to_std_logic(x: bit) return std_logic is
    alias lx: bit is x;
    variable ret_var : std_logic;
  begin
	if(lx = '1') then
	   ret_var :=  '1';
	else 
	   ret_var :=  '0';
	end if;
     return(ret_var);
  end to_std_logic;

function to_bit_vector(x: std_logic_vector) return bit_vector is
    alias lx: std_logic_vector(1 to x'length) is x;
    variable ret_var : bit_vector(1 to x'length);
  begin
     for I in 1 to x'length loop
        if(lx(I) = '1') then
           ret_var(I) :=  '1';
        else 
           ret_var(I) :=  '0';
	end if;
     end loop;
     return(ret_var);
  end to_bit_vector;

 function to_bit2(x: std_logic) return bit is
    alias lx: std_logic is x;
    variable ret_var : bit;
  begin
	if(lx = '1') then
	   ret_var :=  '1';
	else 
	   ret_var :=  '0';
	end if;
     return(ret_var);
  end to_bit2;

begin

  clk <= not clk after 5 ns; -- assume 10ns clock.

  process
  begin
     wait until clk = '1';
     reset <= '0';
     wait;
  end process;

  process 
    variable err_flag : boolean := false;
    File INFILE: text open read_mode is "TRACEFILE.txt";
    FILE OUTFILE: text  open write_mode is "OUTPUTS.txt";

    ---------------------------------------------------
    -- edit the next few lines to customize
    variable X_var,Y_var,R_var: bit_vector (15 downto 0);
    variable op_code_var: bit_vector (1 downto 0);
    variable C_var,Z_var,alu_enable_var: bit;
    ----------------------------------------------------
    variable INPUT_LINE: Line;
    variable OUTPUT_LINE: Line;
    variable LINE_COUNT: integer := 0;
    
  begin
   
    wait until clk = '1';

    while not endfile(INFILE) loop
	  wait until clk = '0'; 

 	  --alu_done_tmp <= '0';

          LINE_COUNT := LINE_COUNT + 1;
	
	  readLine (INFILE, INPUT_LINE);
          read (INPUT_LINE, X_var);
	  read (INPUT_LINE, Y_var);
	  read (INPUT_LINE, alu_enable_var);
	  read (INPUT_LINE, op_code_var);
          read (INPUT_LINE, C_var);
	  read (INPUT_LINE, Z_var);
	  read (INPUT_LINE, R_var);
          --------------------------------------
          -- from input-vector to DUT inputs
	  X <= to_std_logic_vector(X_var);
	  Y <= to_std_logic_vector(Y_var);
	  op_code <= to_std_logic_vector(op_code_var);	  
	  alu_enable <= to_std_logic(alu_enable_var);
          --------------------------------------
	  while (true) loop
	     --alu_done_tmp <= alu_done;
	     wait until clk = '1';
             if(alu_done = '1') then
                exit;
             end if;
          end loop;
          --------------------------------------
	  -- check outputs.
	  if (C /= to_std_logic(C_var) or Z /= to_std_logic(Z_var) or R /= to_std_logic_vector(R_var)) then
             write(OUTPUT_LINE,to_string("ERROR: in RESULT, line "));
             write(OUTPUT_LINE, LINE_COUNT);
	     write(OUTPUT_LINE, to_bit_vector(R));
	     --write(OUTPUT_LINE, to_bit2(C));
	     --write(OUTPUT_LINE, to_bit2(Z));
             writeline(OUTFILE, OUTPUT_LINE);
             err_flag := true;
          end if;
          --------------------------------------
    end loop;

    assert (err_flag) report "SUCCESS, all tests passed." severity note;
    assert (not err_flag) report "FAILURE, some tests failed." severity error;

    wait;
  end process;

  dut: ALU
     port map(X => X,
	Y => Y,
  clk => clk,
  	alu_enable => alu_enable,
        op_code => op_code,
  	C => C,
  	Z => Z,
        R => R,
	alu_done => alu_done);

end Behave;

