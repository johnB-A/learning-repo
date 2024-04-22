 library ieee;
 use ieee.std_logic_1164.all;

entity top_f_tb is
 end top_f_tb;
 
 
 architecture tb  of top_f_tb is
 --inputs
 constant CLK_PERIOD : time := 10 ns ;--100 mhz clock
 
 signal i_clk: std_logic := '0';
 signal h_reset : std_logic := '1';
 --outputs
 signal o_led : std_logic_vector(3 downto 0);
 
 
 component top_f is
	generic(
		NUM_BITS : integer :=3);
	port(
		i_clk    : in std_logic;
		h_reset  : in std_logic;
		o_led    : out std_logic_vector(NUM_BITS downto 0)) ;
end component;

 
 begin
 
 uut_unit : top_f PORT MAP(
	i_clk   => i_clk,
	h_reset => h_reset,
	o_led   => o_led);

clock_process: process
begin
i_clk <= '0';
wait for CLK_PERIOD/2;
i_clk <= '1';
wait for CLK_PERIOD/2;
end process;

stim_proc: process
begin
-- hold reset state for 100 ns.
wait for 40 ns;
h_reset <= '0';
wait for 900 ns;
wait;
end process;
 
END tb;
