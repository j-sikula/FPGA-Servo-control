-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 12.4.2024 08:51:19 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_Top_level is
end tb_Top_level;

architecture tb of tb_Top_level is

    component Top_level
        port (CA        : out std_logic;
              CB        : out std_logic;
              CC        : out std_logic;
              CD        : out std_logic;
              CE        : out std_logic;
              CF        : out std_logic;
              CG        : out std_logic;
              DP        : out std_logic;
              SW        : in std_logic_vector (7 downto 0);
              BTNC      : in std_logic;
              AN        : out std_logic_vector (7 downto 0);
              CLK100MHZ : in std_logic;
              JA        : out std_logic);
    end component;

    signal CA        : std_logic;
    signal CB        : std_logic;
    signal CC        : std_logic;
    signal CD        : std_logic;
    signal CE        : std_logic;
    signal CF        : std_logic;
    signal CG        : std_logic;
    signal DP        : std_logic;
    signal SW        : std_logic_vector (7 downto 0);
    signal BTNC      : std_logic;
    signal AN        : std_logic_vector (7 downto 0);
    signal CLK100MHZ : std_logic;
    signal JA        : std_logic;

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : Top_level
    port map (CA        => CA,
              CB        => CB,
              CC        => CC,
              CD        => CD,
              CE        => CE,
              CF        => CF,
              CG        => CG,
              DP        => DP,
              SW        => SW,
              BTNC      => BTNC,
              AN        => AN,
              CLK100MHZ => CLK100MHZ,
              JA        => JA);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that CLK100MHZ is really your main clock signal
    CLK100MHZ <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        SW <= (others => '0');
        BTNC <= '0';

        -- Reset generation
        --  EDIT: Replace YOURRESETSIGNAL below by the name of your reset as I haven't guessed it
        
        wait for 100 ns;
        SW <= b"00010111";       
        wait for 20 ms;

        -- EDIT Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_Top_level of tb_Top_level is
    for tb
    end for;
end cfg_tb_Top_level;