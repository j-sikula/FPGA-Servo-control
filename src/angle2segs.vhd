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
    generic (
        PERIOD : integer := 2_000_000
    );
    Port ( clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            pulse : out STD_LOGIC);
  end component;
  
  component bin2bcd is
    Port ( clk : in std_logic;
           angle : in STD_LOGIC_VECTOR (7 downto 0);
           bcd : out STD_LOGIC_VECTOR (11 downto 0);
           conversion_completed : out std_logic);
  end component;

signal sig_current_digit : std_logic_vector (3 downto 0);
signal sig_pulse_digit : std_logic := '0';
signal sig_current_digit_position : integer range 0 to 3 := 0;

signal sig_conversion_completed : std_logic := '1';
signal sig_hide_segment : std_logic := '0';

signal ones : std_logic_vector (3 downto 0);
signal tens : std_logic_vector (3 downto 0);
signal hunderds : std_logic_vector (3 downto 0);

signal sig_an : std_logic_vector (7 downto 0) := (others =>'1');
  
begin
  display : bin2seg
    port map (
      clear  => sig_hide_segment,
      bin    => sig_current_digit,
      seg    => seg
    );

  pulse_generator : clock_enable
  port map (
    clk  => clk,
    rst    => clear,
    pulse    => sig_pulse_digit
  );
  
  bin2bcd_converter : bin2bcd
  port map (
    clk => clk,
    angle => angle,
    conversion_completed => sig_conversion_completed,
    bcd(3 downto 0) => ones,
    bcd(7 downto 4) => tens,
    bcd(11 downto 8) => hunderds
  );
  
  sig_hide_segment <= not sig_conversion_completed;
  an <= sig_an;
  
  p_bin2segs : process (clk) is
  begin
    if (rising_edge(clk)) then

      if sig_pulse_digit = '1' then
         if sig_current_digit_position <3 then   
            sig_current_digit_position <= sig_current_digit_position +1;
         else
            sig_current_digit_position <= 0;
         end if;
      end if;
      
      if sig_conversion_completed = '1' then
        if sig_current_digit_position = 0 then
            sig_current_digit <= b"1010";
            sig_an <= b"1111_1110";
        elsif sig_current_digit_position = 1 then
            sig_current_digit <= ones;
            sig_an <= b"1111_1101";
        elsif sig_current_digit_position = 2 then
            sig_current_digit <= tens;
            sig_an <= b"1111_1011";
        else
            sig_current_digit <= hunderds;
            sig_an <= b"1111_0111";
        end if;
      end if;

    end if;

  end process p_bin2segs;
    

end Behavioral;