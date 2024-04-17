-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 17.4.2024 15:05:37 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_sw2angle is
end tb_sw2angle;

architecture tb of tb_sw2angle is

    component sw2angle
        port (clk     : in std_logic;
              sw_up   : in std_logic;
              sw_down : in std_logic;
              angle   : out std_logic_vector (7 downto 0));
    end component;

    signal clk     : std_logic;
    signal sw_up   : std_logic;
    signal sw_down : std_logic;
    signal angle   : std_logic_vector (7 downto 0);

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : sw2angle
    port map (clk     => clk,
              sw_up   => sw_up,
              sw_down => sw_down,
              angle   => angle);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        sw_up <= '0';
        sw_down <= '0';

        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;
        
        sw_up <= '1';
        
        wait for 5ms;
        
        sw_up <= '0';
        
        wait for 1us;
        
         sw_up <= '1';
        
        wait for 5ms;
        
        sw_down <= '1';
        
        wait for 1ms;
        
        sw_up <= '0';
        
        wait for 10ms;
        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_sw2angle of tb_sw2angle is
    for tb
    end for;
end cfg_tb_sw2angle;