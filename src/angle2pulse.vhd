----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/05/2024 09:50:10 AM
-- Design Name: 
-- Module Name: angle2pulse - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity angle2pulse is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           angle : in STD_LOGIC_VECTOR (7 downto 0);
           pulse : out STD_LOGIC);
end angle2pulse;

architecture Behavioral of angle2pulse is
signal count : integer :=0;
signal counter_angle : integer :=0;

begin

p_angle_2_pulse : process (clk) is
    begin
       
        -- Synchronous proces
        if (rising_edge(clk)) then 
            counter_angle <= 2*555*TO_INTEGER(unsigned(angle)) + 100_000;
            if rst = '1' then
                count <= 0;
                pulse <= '0';
            elsif count = counter_angle - 1 then
                count <= 0;
                pulse <= '1';
            else
                count <= count + 1;
                pulse <= '0';
            end if;
       
            

        end if;

end process p_angle_2_pulse;

end Behavioral;