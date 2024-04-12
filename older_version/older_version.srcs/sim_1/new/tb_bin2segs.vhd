-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 12.4.2024 08:28:41 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_angle2segs is
end tb_angle2segs;

architecture tb of tb_angle2segs is

    component angle2segs
        port (clk   : in std_logic;
              clear : in std_logic;
              angle : in std_logic_vector (7 downto 0);
              an    : out std_logic_vector (7 downto 0);
              seg   : out std_logic_vector (6 downto 0));
    end component;

    signal clk   : std_logic;
    signal clear : std_logic;
    signal angle : std_logic_vector (7 downto 0);
    signal an    : std_logic_vector (7 downto 0);
    signal seg   : std_logic_vector (6 downto 0);

    constant TbPeriod : time := 1000 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : angle2segs
    port map (clk   => clk,
              clear => clear,
              angle => angle,
              an    => an,
              seg   => seg);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        clear <= '0';
        angle <= (others => '0');

        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;
        angle <= b"01111000";
        
        wait for 10000 * TbPeriod;
        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_angle2segs of tb_angle2segs is
    for tb
    end for;
end cfg_tb_angle2segs;