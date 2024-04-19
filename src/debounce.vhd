----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/22/2024 09:16:39 AM
-- Design Name: 
-- Module Name: debounce - Behavioral
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

entity debounce is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           en : in STD_LOGIC;
           bouncey : in STD_LOGIC;
           clean : out STD_LOGIC;
           pos_edge : out STD_LOGIC;
           neg_edge : out STD_LOGIC);
end debounce;

architecture Behavioral of debounce is
 -- Define states for the FSM
    type   state_type is (RELEASED, PRE_PRESSED, PRESSED, PRE_RELEASED);
    signal state : state_type;

    -- Define number of periods for debounce counter
    constant DEB_COUNT : integer := 4;

    -- Define signals for debounce counter
    signal sig_count : integer range 0 to DEB_COUNT;

    -- Debounced signal
    signal sig_clean : std_logic;
    
    signal sig_delayed : std_logic;
begin
-- Process implementing a finite state machine (FSM) for
    -- button debouncing. Handles transitions between different
    -- states based on clock signal and bouncey button input.
    p_fsm : process (clk) is
    begin

        if rising_edge(clk) then
            if (rst = '1') then   -- Active-high reset
                state <= RELEASED;
            elsif (en = '1') then -- Clock enable
                case state is     -- Define transitions between states

                    when RELEASED =>
                        -- If bouncey = 1 then clear counter and go to PRE_PRESSED;
                        
                        if (bouncey = '1') then
                            sig_count <= 0;
                            state <= PRE_PRESSED;
                        end if;
                    when PRE_PRESSED =>
                        if (bouncey = '1') then
                            sig_count <= sig_count + 1;
                            if (sig_count = DEB_COUNT -1) then
                                state <= PRESSED;
                            end if;
                        else
                            state <= RELEASED;
                        end if;
                        

                    when PRESSED =>
                        
                        if (bouncey = '0') then
                            sig_count <= 0;
                            state <= PRE_RELEASED;
                        end if;
                        -- If bouncey = 0 then clear counter and go to PRE_RELEASED;

                    when PRE_RELEASED =>
                        
                        if (bouncey = '0') then
                            sig_count <= sig_count + 1;
                            if (sig_count = DEB_COUNT -1) then
                                state <= RELEASED;
                            end if;
                        else
                            state <= PRESSED;
                        end if;
                        -- If bouncey = 0 then increment counter

                            -- if counter = DEB_COUNT-1 go to RELEASED;

                        -- else clear counter and go to PRESSED;

                    -- Prevent unhandled cases
                    when others =>
                        null;
                end case;
            end if;
            if (state = PRESSED) or (state = PRE_RELEASED) then
                sig_clean <= '1';
            else
                sig_clean <= '0';
            end if;
        end if;
        
        
    end process p_fsm;

    -- Set clean signal to 1 when states PRESSED or PRE_RELEASED
     

    -- Assign output debounced signal
    clean <= sig_clean;
    
    p_edge_detector : process (clk) is
    begin
        if rising_edge(clk) then
            if (rst = '1') then
                sig_delayed <= '0';
            else
                sig_delayed <= sig_clean;
            end if;
        end if;
    end process p_edge_detector;
    
    
    pos_edge <= sig_clean and not sig_delayed;
    neg_edge <= not sig_clean and  sig_delayed;
    

end Behavioral;
