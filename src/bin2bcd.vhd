----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.04.2024 18:37:13
-- Design Name: 
-- Module Name: bin2bcd - Behavioral
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
use ieee.numeric_std.ALL;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bin2bcd is
    Port ( clk                  : in  std_logic;
           angle                : in  STD_LOGIC_VECTOR (7 downto 0);
           bcd                  : out STD_LOGIC_VECTOR (11 downto 0);
           conversion_completed : out std_logic);
end bin2bcd;

architecture Behavioral of bin2bcd is

signal sig_bcd      : std_logic_vector (11 downto 0) := (others => '0');
signal sig_angle    : std_logic_vector (7 downto 0)  := (others => '0');
signal s_counter    : integer range 0 to 7           := 0;
signal s_last_shift : std_logic                      := '0';
signal s_cc         : std_logic                      := '1'; -- conversion_completed

begin
process(clk)
  begin
  
  if rising_edge(clk) then
      if sig_angle /= angle then
        sig_angle <= angle;
        s_counter <= 0;
        s_cc <= '0';
        sig_bcd <= (others => '0');
      elsif s_cc = '0' then  --conversion
          if unsigned(sig_bcd(3 downto 0)) > 4 and s_last_shift = '0' then
            sig_bcd <= sig_bcd + 3;
            s_last_shift <= '1';  
          elsif unsigned(sig_bcd(7 downto 4)) > 4 and s_last_shift = '0' then
            sig_bcd <= sig_bcd + 48;
            s_last_shift <= '1';
          elsif unsigned(sig_bcd(11 downto 8)) > 4 and s_last_shift = '0' then
            sig_bcd <= sig_bcd + 768;
            s_last_shift <= '1';
          else
        
              sig_bcd <= sig_bcd(10 downto 0) & sig_angle(7-s_counter);
              
              
              
              if s_counter < 7 then 
                s_counter <= s_counter + 1;
              else
                s_cc <= '1';
              end if;  
              s_last_shift <= '0';
          end if;
      else  -- after conversion is completed
        s_counter <= 0;
    end if;
    
   end if; 
   
  end process;
bcd <= sig_bcd;
conversion_completed <= s_cc;
end Behavioral;
