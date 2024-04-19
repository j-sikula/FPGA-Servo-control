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

entity sw2angle is
    generic (
      PERIOD : integer := 50_000_000   --after 500 ms increment : 50_000_000
    );
    Port ( clk      : in  std_logic;
           sw_up    : in  std_logic;
           sw_down  : in  std_logic;
           angle    : out STD_LOGIC_VECTOR (7 downto 0)
         );
end sw2angle;

architecture Behavioral of sw2angle is

  
  signal sig_angle : std_logic_vector (7 downto 0):= (others => '0');
  signal s_angle : integer range 0 to 180 := 0;
  signal s_counter_period : integer range 0 to PERIOD := 0;
  signal s_increment : integer range 0 to 20 := 0;  
  signal s_n_up_incremented : integer range 0 to 180 := 0;
  signal s_n_down_incremented : integer range 0 to 180 := 0;    
  signal s_is_incrementing : std_logic := '0';
  
  signal s_cc : std_logic := '1'; -- conversion_completed

begin
process(clk)
    begin
  
    if rising_edge(clk) then
        if sw_up = sw_down then
            s_n_up_incremented <= 0;
            s_n_down_incremented <= 0;
            s_counter_period <= 0;
        elsif (s_counter_period > PERIOD-1) then
            s_counter_period <= 0;
        elsif(s_counter_period = 0) then    
            if sw_up = '1' and sw_down = '0' then
            
                s_n_down_incremented <= 0;
                
                if s_n_up_incremented < 4 and s_angle < 180 then
                    s_angle <= s_angle + 1;
                    
                elsif s_n_up_incremented < 10 and s_angle < 175 then
                    s_angle <= s_angle + 5;
                    
                elsif s_n_up_incremented < 25 and s_angle < 170 then
                    s_angle <= s_angle + 10;
                    
                else
                    s_angle <= 180;
                    s_n_up_incremented <= 0;
                end if;
                        
                s_n_up_incremented <= s_n_up_incremented + 1;
              
            elsif sw_up = '0' and sw_down = '1' then
                s_n_up_incremented <= 0;
                
                if s_n_down_incremented < 4 and s_angle > 1 then
                    s_angle <= s_angle - 1;
                elsif s_n_down_incremented < 10 and s_angle > 5 then
                    s_angle <= s_angle - 5;
                elsif s_n_down_incremented < 25 and s_angle > 10 then
                    s_angle <= s_angle - 10;
                else
                    s_angle <= 0;
                    s_n_down_incremented <= 0;
                end if;
                            
                s_n_down_incremented <= s_n_down_incremented + 1;
                           
            end if;
           s_counter_period <= 1;
        else 
           s_counter_period <= s_counter_period +1;                    
        end if;           
    end if; 
   
end process;

angle <= std_logic_vector(to_unsigned(s_angle, angle'length));

end Behavioral;
