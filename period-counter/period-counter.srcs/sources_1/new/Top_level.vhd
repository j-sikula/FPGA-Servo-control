----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/12/2024 09:49:55 AM
-- Design Name: 
-- Module Name: Top_level - Behavioral
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

entity Top_level is
    Port ( CA : out STD_LOGIC;
           CB : out STD_LOGIC;
           CC : out STD_LOGIC;
           CD : out STD_LOGIC;
           CE : out STD_LOGIC;
           CF : out STD_LOGIC;
           CG : out STD_LOGIC;
           DP : out STD_LOGIC;
           SW : in STD_LOGIC_VECTOR (7 downto 0);
           BTNC : in STD_LOGIC;
           AN : out STD_LOGIC_VECTOR (7 downto 0);
           CLK100MHZ : in STD_LOGIC;
           JA : out STD_LOGIC);
end Top_level;

architecture Behavioral of Top_level is
    component bin2PWM
        
        Port (  clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            angle : in STD_LOGIC_VECTOR (7 downto 0);
            pwm_out : out STD_LOGIC);
            
    end component;


--ADD component bin2segs


begin
    B2PWM: bin2PWM
    port map(
        clk=>CLK100MHZ,
        rst=>BTNC,
        angle=>SW,
        pwm_out=>JA
        );
        



end Behavioral;
