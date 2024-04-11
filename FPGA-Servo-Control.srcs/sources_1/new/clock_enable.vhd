----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/08/2024 10:03:44 AM
-- Design Name: 
-- Module Name: clock_enable - Behavioral
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

use IEEE.NUMERIC_STD.ALL;


entity clock_enable is
    generic (
        PERIOD : integer := 6
    );
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           pulse : out STD_LOGIC);
end clock_enable;

architecture Behavioral of clock_enable is
    
    --! Local counter 
    signal sig_count : integer range 0 to (PERIOD - 1);
    
    
begin
     
    p_clk_enable : process (clk) is
    begin

        -- Synchronous proces
        if (rising_edge(clk)) then
            if rst = '1' then
                sig_count <= 0;
                pulse <= '0'; -- Set output `pulse` to low
                

            elsif sig_count = PERIOD-1 then
                sig_count <= 0;
                pulse <= '1'; -- Set output `pulse` to high

            else
                sig_count <= sig_count +1;
                pulse <= '0';

            end if;
        end if;

    end process p_clk_enable;


end Behavioral;
