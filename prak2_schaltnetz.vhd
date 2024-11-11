library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity prak2_schaltnetz is
  port (
    selector       : in  std_logic_vector(1 downto 0);
    current_number : in  std_logic_vector(7 downto 0);
    next_number    : out std_logic_vector(7 downto 0));

end prak2_schaltnetz;

architecture behv of prak2_schaltnetz is
    signal sum : std_logic_vector(7 downto 0);

begin

  sum <= std_logic_vector(to_unsigned(to_integer(unsigned(current_number)) + 1, 8));

  DUT: entity work.mux4
    port map (
      sel       => selector,
      d0        => (current_number),
      d1        => sum,
      d2        => ("00000000"),
      d3        => ("00000000"),
      Y => next_number
    );

  -- Platzhalter, das die Vorgabe kompilierbar ist:
  -- sollte dann gelöscht werden
end architecture;

