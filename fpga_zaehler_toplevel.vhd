library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fpga_zaehler_toplevel is
  port (
    clk_50mhz : in  std_logic;
    SW4       : in  std_logic;
    SW5       : in  std_logic;
    SW6       : in  std_logic;
    SW7       : in  std_logic;
    leds      : out std_logic_vector(7 downto 0);
    pmod1     : out std_logic_vector(7 downto 0));
end fpga_zaehler_toplevel;

-- nicht editieren!

architecture behv of fpga_zaehler_toplevel is

  signal modus_i            : std_logic_vector(1 downto 0);
  signal clkenable, clkstep : std_logic;
  signal count_i            : std_logic_vector(7 downto 0);


  constant teiler         : integer := 12500000;
  signal halb             : integer range 0 to teiler:= teiler/2;
  signal teilercnt        : integer range 0 to teiler;
  signal clk, async_reset : std_logic;
  signal clki             : std_logic;

begin

  prak2zaehler_1 : entity work.prak2zaehler
    port map (
      clk         => clk,
      async_reset => async_reset,
      modus       => modus_i,
      count       => count_i);

  -- modus: sw6 = sync reset
  --        sw7 = anahlten/zählen
  
  modus_i   <= sw6 & sw7; -- sw6 ist MSB

  -- Taster sind active low
  clkenable <= SW5;
  clkstep   <= not SW4;

  leds  <= count_i;  -- Zählausgang auf LEDs
  pmod1 <= count_i;  -- Zählausgang auf Display

  -- POR Resetgenerator
  process(clk_50mhz) is
    variable cnt : unsigned(7 downto 0) := (others => '0');
  begin
    if rising_edge(clk_50mhz) then
      if cnt < 255 then
        cnt         := cnt + 1;
        async_reset <= '1';
      else
        async_reset <= '0';
      end if;
    end if;
  end process;

  -- Taktteiler
  process(clk_50mhz,async_reset) is

  begin
    if async_reset = '1' then
      teilercnt <= 0;
    elsif rising_edge(clk_50mhz) then
      if teilercnt < teiler then
        teilercnt <= teilercnt + 1;
      else
        teilercnt <= 0;
      end if;

      if teilercnt < halb then
        clki <= '0';
      else
        clki <= '1';
      end if;

      if clkenable = '1' then
        clk <= clki or clkstep;
      else
        clk <= '0';
      end if;

    end if;
  end process;


end behv;
