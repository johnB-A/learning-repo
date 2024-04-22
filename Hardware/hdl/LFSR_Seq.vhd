library ieee;
use ieee.std_logic_1164.all;

entity LFSR is
	generic(
		NUM_BITS : integer := 4);
	port(
		h_reset  : in std_logic;
		clk   : in std_logic;
		o_seq    : out std_logic_vector(NUM_BITS-1 downto 0));
end LFSR;

architecture RTL of LFSR is 
	signal r_LFSR : std_logic_vector(NUM_BITS-1 downto 0) ;
	signal r_XNOR : std_logic;
--acting sus because i was treating like an acutal clock then reset
--evn though this clk is produced from an output so rest cant be synchrnous
begin
	process(clk, h_reset)
	begin
		if(h_reset = '1') then
				r_LFSR <= (others => '0');
		elsif(rising_edge(clk)) then
				r_LFSR <=r_LFSR(r_LFSR'left-1 downto 0) & r_XNOR;
		end if;
	end process;	
			o_seq <= r_LFSR;		

	--using generate to generate 3 case, 3,4, 8, 16

g_LFSR_3 : if NUM_BITS = 3  generate
		r_XNOR <= r_LFSR(2) XNOR r_LFSR(0);
end generate;

g_LFSR_4 : if NUM_BITS = 4  generate
		r_XNOR <= r_LFSR(3) XNOR r_LFSR(0);
end generate;

g_LFSR_8 : if NUM_BITS = 8  generate
		r_XNOR <= r_LFSR(7) XNOR r_LFSR(3) XNOR r_LFSR(2) XNOR r_LFSR(1);
end generate;

g_LFSR_16 : if NUM_BITS = 16  generate
		r_XNOR <= r_LFSR(15) XNOR r_LFSR(4) XNOR r_LFSR(2) XNOR r_LFSR(1);
end generate;

end RTL;
	
	
					
			