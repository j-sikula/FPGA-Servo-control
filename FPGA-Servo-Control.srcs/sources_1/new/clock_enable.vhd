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
use ieee.std_logic_unsigned.all; -- Package for arithmetic operations with std_logic_vector
use ieee.math_real.all; -- To calculate the number of bits needed to represent an integer

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clock_enable is
    generic (
        PERIOD : integer := 6
    );
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           pulse : out STD_LOGIC);
end clock_enable;

architecture Behavioral of clock_enable is
    --! Get number for needed bits for PERIOD value
    constant bits_needed : integer := integer(ceil(log2(real(PERIOD + 1))));

    --! Local counter with needed number of bits
    signal sig_count : std_logic_vector(bits_needed - 1 downto 0);
    
    
begin
     --! Generate clock enable signal. By default, enable signal
    --! is low and generated pulse is always one clock long.
    p_clk_enable : process (clk) is
    begin

        -- Synchronous proces
        if (rising_edge(clk)) then
            if rst = '1' then
                sig_count <= (others => '0');-- Clear all bits of local counter
                pulse <= '0'; -- Set output `pulse` to low
                

            elsif sig_count = PERIOD-1 then
                sig_count <= (others => '0');-- Clear all bits of local counter
                pulse <= '1'; -- Set output `pulse` to high

            else
                sig_count <= sig_count +1;
                pulse <= '0';

            end if;
        end if;

    end process p_clk_enable;


end Behavioral;
