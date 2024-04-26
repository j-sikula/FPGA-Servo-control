-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 5.4.2024 08:13:08 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_angle2pulse is
end tb_angle2pulse;

architecture tb of tb_angle2pulse is

    component angle2pulse
        port (clk   : in std_logic;
              rst   : in std_logic;
              angle : in std_logic_vector (7 downto 0);
              pulse : out std_logic);
    end component;

    signal clk   : std_logic;
    signal rst   : std_logic;
    signal angle : std_logic_vector (7 downto 0);
    signal pulse : std_logic;

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : angle2pulse
    port map (clk   => clk,
              rst   => rst,
              angle => angle,
              pulse => pulse);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        angle <= (others => '0');

        -- Reset generation
        -- EDIT: Check that rst is really your reset signal
        rst <= '1';
        wait for 100 ns;
        rst <= '0';
        wait for 100 ns;
        angle <= b"0010_1101";

        -- EDIT Add stimuli here
        wait for 400_000 * TbPeriod;
        rst <= '1';
        wait for 100 ns;
        rst <= '0';
         wait for 400_000 * TbPeriod;
        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_angle2pulse of tb_angle2pulse is
    for tb
    end for;
end cfg_tb_angle2pulse;