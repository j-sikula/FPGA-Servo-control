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
      PERIOD : integer := 20_000_000;   -- after 500 ms increment : 50_000_000
      MAX_ANGLE : integer := 90
    );
    Port ( clk      : in  std_logic;
           sw_up    : in  std_logic;
           sw_down  : in  std_logic;
           angle    : out STD_LOGIC_VECTOR (7 downto 0)
         );
end sw2angle;

architecture Behavioral of sw2angle is

  component clock_enable is
    generic (
        PERIOD : integer := PERIOD        
    );
    Port ( clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            pulse : out STD_LOGIC);
  end component;
  
  signal s_angle : integer range 0 to MAX_ANGLE := 0;
  signal s_period : std_logic := '0';
  signal s_rst_clk_en : std_logic := '0';
  signal s_n_up_incremented : integer range 0 to MAX_ANGLE := 0;
  signal s_n_down_incremented : integer range 0 to MAX_ANGLE := 0;    

  
 

begin

pulse_generator : clock_enable
  port map (
    clk  => clk,
    rst    => s_rst_clk_en,
    pulse    => s_period
  );
  
  
process(clk)
    begin
  
    if rising_edge(clk) then
        if s_rst_clk_en = '1' then
            s_rst_clk_en <= '0';
        end if;
        
        if (sw_up = '1' and sw_down = '1') or (sw_up = '0' and sw_down = '0') then
            s_n_up_incremented <= 0;
            s_n_down_incremented <= 0;
        end if; 
        
        if s_n_up_incremented = 0 and sw_up = '1' and sw_down = '0' then    --incrementing up when pressed btn_up
            s_rst_clk_en <= '1';
            if s_angle + 1 < MAX_ANGLE then
                s_angle <= s_angle + 1;
            end if;
            s_n_up_incremented <= 1;
        end if;
        
        if s_period = '1' and sw_up = '1' and sw_down = '0' then    --incrementing up when hold btn_up
            
            s_n_down_incremented <= 0;
            
            if s_n_up_incremented + s_angle + 1 < MAX_ANGLE then
                s_angle <= s_n_up_incremented + s_angle + 1;                      
            else
                s_angle <= MAX_ANGLE;
                s_n_up_incremented <= 0;
            end if;
                    
            s_n_up_incremented <= s_n_up_incremented + 1;
        end if;
        
        if s_n_down_incremented = 0 and sw_up = '0' and sw_down = '1' then    --incrementing up when pressed btn_down
            s_rst_clk_en <= '1';
            if s_angle - 1 > 0 then
                s_angle <= s_angle - 1;
            end if;
            s_n_down_incremented <= 1;    
        end if;
          
        if s_period = '1' and sw_up = '0' and sw_down = '1' then    --incrementing down when hold btn_down
            
            s_n_up_incremented <= 0;
            
            if s_angle - s_n_down_incremented > 0 then
                s_angle <= s_angle - s_n_down_incremented;
            else
                s_angle <= 0;
                s_n_down_incremented <= 0;
            end if;
                        
            s_n_down_incremented <= s_n_down_incremented + 1;
                       
        end if;
                          
                   
    end if; 
   
end process;

angle <= std_logic_vector(to_unsigned(s_angle, angle'length));

end Behavioral;
