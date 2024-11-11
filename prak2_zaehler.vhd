library ieee;
use ieee.std_logic_1164.all;

entity prak2zaehler is
  port (
    clk         : in  std_logic;
    async_reset : in  std_logic;
    modus       : in  std_logic_vector(1 downto 0);
    count       : out std_logic_vector(7 downto 0));
end prak2zaehler;

architecture behv of prak2zaehler is

  signal dff_qout : std_logic_vector(7 downto 0);
  signal dff_din: std_logic_vector(7 downto 0);

-- An dieser Datei muss nicht geändert werden. Das große ? steckt im entity prak2_schaltnetz
  
begin

  schaltnetz: entity work.prak2_schaltnetz
    port map (
      selector       => modus,
      current_number => dff_qout,
      next_number    => dff_din);

  dff8_inst: entity work.dff8
    port map (
      D           => dff_din,
      clk         => clk,
      async_reset => async_reset,
      Q           => dff_qout);

 count <= dff_qout;
  
end architecture;
