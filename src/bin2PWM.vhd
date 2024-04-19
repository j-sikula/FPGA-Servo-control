----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/05/2024 10:29:09 AM
-- Design Name: 
-- Module Name: bin2PWM - Behavioral
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

entity bin2PWM is
    Port (  clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            angle : in STD_LOGIC_VECTOR (7 downto 0);
            pwm_out : out STD_LOGIC);
end bin2PWM;

architecture Behavioral of bin2PWM is
    component clock_enable
    generic (
                PERIOD : integer := 600_000
            );
        Port (  clk : in STD_LOGIC;
                rst : in STD_LOGIC;
                pulse : out STD_LOGIC);
    end component;
    component angle2pulse
        Port(
                clk : in STD_LOGIC;
                rst : in STD_LOGIC;
                angle : in STD_LOGIC_VECTOR (7 downto 0);
                pulse : out STD_LOGIC);
    end component;
    signal sig_r_pulse: std_logic;
    signal sig_period_pulse: std_logic;
    signal sig_pwm_out: std_logic := '0';
begin
    A2Pulse: angle2pulse
    port map( 
        pulse => sig_r_pulse,
        rst => sig_period_pulse,
        angle(0) => angle(0),
        angle(1) => angle(1),
        angle(2) => angle(2),
        angle(3) => angle(3),
        angle(4) => angle(4),
        angle(5) => angle(5),
        angle(6) => angle(6),
        angle(7) => angle(7),
        clk => clk);
        
    PeriodPulse: clock_enable
    port map(
        pulse => sig_period_pulse,
        clk => clk,
        rst => rst);
        
    process(clk)
    begin
        if rising_edge(clk) then
            if sig_period_pulse = '1' then
                sig_pwm_out <= '1';
            end if;
            if sig_r_pulse = '1' then
                sig_pwm_out <='0';
            end if;           
        end if;
    end process;
        
    pwm_out <= sig_pwm_out;        

end Behavioral;
