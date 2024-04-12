-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 11.4.2024 17:20:28 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_bin2bcd is
end tb_bin2bcd;

architecture tb of tb_bin2bcd is

    component bin2bcd
        port (clk   : in std_logic;
              angle : in std_logic_vector (7 downto 0);
              bcd   : out std_logic_vector (11 downto 0);
              conversion_completed : out std_logic);
    end component;

    signal clk   : std_logic;
    signal angle : std_logic_vector (7 downto 0);
    signal bcd   : std_logic_vector (11 downto 0);

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';
    signal conversion_completed : std_logic := '0';
begin

    dut : bin2bcd
    port map (clk   => clk,
              angle => angle,
              bcd   => bcd,
              conversion_completed => conversion_completed);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        angle <= (others => '0');

        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;
        angle <= b"11110011";
        wait for 100 * TbPeriod;
        
        angle <= b"01111000";
        wait for 100 * TbPeriod;
        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_bin2bcd of tb_bin2bcd is
    for tb
    end for;
end cfg_tb_bin2bcd;