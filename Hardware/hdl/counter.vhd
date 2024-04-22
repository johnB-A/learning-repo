library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
entity onehz_clk is
	generic(
	counter_width : integer := 2); --simulation is 12.5 MHZ ,actual has to be 26 bits 1 hz 50,0000
	port(
		i_clk1        : in std_logic;
		h_reset  : in std_logic;
		o_oneHZ_clk    : out std_logic);
end onehz_clk;

architecture RTL of onehz_clk is 
	signal r_counter : std_logic_vector(counter_width downto 0) := (others => '0');
	CONSTANT  threshold : integer := 4;
	signal o_clk : std_logic := '0';

begin
	process(i_clk1, h_reset)
	begin
		if(rising_edge(i_clk1)) then
			if(h_reset = '1') then
				r_counter <= (others => '0');
			else
				if(to_integer(unsigned(r_counter)) >= threshold) then
					r_counter <= (others => '0');
					o_clk <= NOT(o_clk);
				else
					r_counter <= r_counter +1;
				end if;
			end if;
		end if;
	end process;
	o_oneHZ_clk <= o_clk;
end RTL;
	
	
					
			