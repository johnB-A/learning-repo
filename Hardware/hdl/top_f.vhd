library ieee;
use ieee.std_logic_1164.all;

entity top_f is
	generic(
		NUM_BITS : integer :=3
		);
	port(
		i_clk    : in std_logic;
		h_reset  : in std_logic;
		o_led    : out std_logic_vector(NUM_BITS downto 0)) ;
end top_f;

architecture RTL of top_f is

	
component onehz_clk is
generic(
	counter_width : integer := 2); --simulation is 
	port(
		i_clk1    : in  std_logic;
		h_reset  : in std_logic;
		o_oneHZ_clk    : out std_logic);
end component;


component LFSR is
	generic(
		NUM_BITS : integer := 4);
	port(
		h_reset  : in std_logic;
		clk   : in std_logic;
		o_seq    :  out std_logic_vector(NUM_BITS-1 downto 0));
end component;

signal o_clk	: std_logic;

begin
	
	uut_clk: onehz_clk PORT MAP(
		i_clk1        => i_clk,   
		h_reset      => h_reset,
		o_oneHZ_clk  => o_clk);
		
		
	uut_LSFR: LFSR PORT MAP(
		h_reset  => h_reset,
		clk   =>  o_clk,
		o_seq    => o_led);

		
end RTL;
	
	
					
			