library ieee;
use ieee.std_logic_1164.all;

entity dff8 is
  port (
    D           : in  std_logic_vector(7 downto 0);
    clk         : in  std_logic;
    async_reset : in  std_logic;
    Q           : out std_logic_vector(7 downto 0));
end dff8;

architecture behv of dff8 is
  signal internes_Q : std_logic_vector(7 downto 0);
begin

  process (clk, async_reset) is
  begin
    if async_reset = '1' then
      internes_Q <= "00000000";
    elsif clk'event and clk = '1' then
      internes_Q <= D;
    end if;
  end process;

  Q  <= internes_Q;

end behv;
