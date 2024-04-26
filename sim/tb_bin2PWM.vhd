-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 12.4.2024 07:18:20 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_bin2PWM is
end tb_bin2PWM;

architecture tb of tb_bin2PWM is

    component bin2PWM
        port (clk     : in std_logic;
              rst     : in std_logic;
              angle   : in std_logic_vector (7 downto 0);
              pwm_out : out std_logic);
    end component;

    signal clk     : std_logic;
    signal rst     : std_logic;
    signal angle   : std_logic_vector (7 downto 0);
    signal pwm_out : std_logic;

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : bin2PWM
    port map (clk     => clk,
              rst     => rst,
              angle   => angle,
              pwm_out => pwm_out);

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
        angle <= b"0000_0000";
        wait for 600_000 * TbPeriod;
        angle <= b"1011_0100";
        wait for 22ms;
        angle <= b"0000_0000";
        wait for 20ms;
        angle <= b"0101_1010";           
        wait for 20ms;
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_bin2PWM of tb_bin2PWM is
    for tb
    end for;
end cfg_tb_bin2PWM;