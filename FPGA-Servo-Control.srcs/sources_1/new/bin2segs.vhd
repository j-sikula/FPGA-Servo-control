----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/05/2024 10:29:27 AM
-- Design Name: 
-- Module Name: angle2segs - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity angle2segs is
    Port ( clk : in STD_LOGIC;
           clear : in STD_LOGIC;
           angle : in STD_LOGIC_VECTOR (7 downto 0);
           an : out STD_LOGIC_VECTOR (7 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0)
         );
end angle2segs;

architecture Behavioral of angle2segs is

  component bin2seg is
    Port ( clear : in STD_LOGIC;
            bin : in STD_LOGIC_VECTOR (3 downto 0);
            seg : out STD_LOGIC_VECTOR (6 downto 0));
  end component;

  component clock_enable is
    Port ( clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            pulse : out STD_LOGIC);
  end component;

signal sig_current_digit : std_logic_vector (3 downto 0);
signal sig_pulse_digit : std_logic := '0';
signal sig_current_digit_position : integer range 0 to 7 := 0;

  
begin
  display : bin2seg
    port map (
      clear  => clear,
      bin    => sig_current_digit,
      seg    => seg
    );

  pulse_generator : clock_enable
  port map (
    clk  => clk,
    rst    => clear,
    pulse    => sig_pulse_digit
  );

  p_bin2segs : process (clk) is
  begin
    if (rising_edge(clk)) then

      if sig_pulse_digit = '1' then

      end if;

    end if;

  end process p_bin2segs;


end Behavioral;
