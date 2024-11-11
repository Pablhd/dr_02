library ieee;
use ieee.std_logic_1164.all;

entity mux4 is
  port (
    d0, d1, d2, d3                 : in  std_logic_vector(7 downto 0);-- Dateineingänge
    sel                           : in  std_logic_vector(1 downto 0);-- Selector
    Y                              : out std_logic_vector(7 downto 0));-- Ausgang
end mux4;

architecture verhalten of mux4 is
begin

  Y <= d0 when sel = "00" else  -- 0
       d1 when sel = "01" else  -- 1
       d2 when sel = "10" else  -- 2
       d3 when sel = "11" else  -- 3
       "00000000"; -- sollte nicht eintreten
end verhalten;
