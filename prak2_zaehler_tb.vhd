-------------------------------------------------------------------------------
-- Title      : Testbench for design "vhdlbspl"
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
-------------------------------------------------------------------------------

entity prak2zaehler_tb is
-- keine Ein- und Ausgänge
end entity prak2zaehler_tb;

-------------------------------------------------------------------------------

architecture dut of prak2zaehler_tb is

  -- component ports

  signal clk         : std_logic;
  signal async_reset : std_logic;
  signal modus       : std_logic_vector(1 downto 0);
  signal count       : std_logic_vector(7 downto 0);

  begin  -- architecture dut
  -- component instantiation

  DUT: entity work.prak2zaehler
    port map (
      clk         => clk,
      async_reset => async_reset,
      modus       => modus,
      count       => count);

  Clk_Proc: process
  begin
    clk <= '0'; wait for 5 ns;
    clk <= '1'; wait for 5 ns;
  end process Clk_Proc;
  
  
  -- waveform generation
  WaveGen_Proc: process
  begin
    modus <= "00";
    async_reset <= '0' ; wait for 2 ns;
    async_reset <= '1' ; wait for 2 ns;
    async_reset <= '0';  wait for 1000 ns;
    modus <= "01"; wait for 1000 ns;
    modus <= "00"; wait for 1000 ns;
    modus <= "10"; wait for 1000 ns;
    modus <= "01"; wait for 1100 ns;
    modus <= "00"; wait for 1000 ns;
    modus <= "10"; wait for 1000 ns;
    modus <= "01"; wait for 1000 ns;
   

    -- s.  Praktikum2 Aufgabe 2
    -- * 1000 ns lang Modus 00 (Zähler angehalten)
    -- * 1000 ns lang Modus 01 (Zähler zählt bis dezimal 100 = 0x64)
    -- * 1000 ns wieder Zähler anhalten
    -- * 1000 ns Zähler resetten über Modus 10 oder 11 (nicht den async\_reset !)
    -- * 1100 ns (!) weiterzählen
    -- * 1000 ns anhalten 
    -- * 1000 ns resetten (wieder synchron)
    -- * Bis zum Simulationsende weiterlaufen lassen
    -- Überprüfen Sie den Überlauf von 255 auf 0











    
    wait;
  end process WaveGen_Proc;
end architecture dut;

