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

entity top_level is
    port ( CA        : out STD_LOGIC;
           CB        : out STD_LOGIC;
           CC        : out STD_LOGIC;
           CD        : out STD_LOGIC;
           CE        : out STD_LOGIC;
           CF        : out STD_LOGIC;
           CG        : out STD_LOGIC;
           DP        : out STD_LOGIC;
           SW        : in  STD_LOGIC_VECTOR (7 downto 0);
           SW_F      : in  STD_LOGIC;
           BTNC      : in  STD_LOGIC;
           BTNU      : in  STD_LOGIC;
           BTND      : in  STD_LOGIC;
           AN        : out STD_LOGIC_VECTOR (7 downto 0);
           CLK100MHZ : in  STD_LOGIC;
           JA_out        : out STD_LOGIC;
           JB_out        : out STD_LOGIC
    );
end entity top_level;

architecture Behavioral of top_level is
    
    component bin2PWM is
        port (  clk     : in STD_LOGIC;
                rst     : in STD_LOGIC;
                angle   : in STD_LOGIC_VECTOR (7 downto 0);
                pwm_out : out STD_LOGIC
        );            
    end component;
    
    component angle2pulse is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           angle : in STD_LOGIC_VECTOR (7 downto 0);
           pulse : out STD_LOGIC);
    end component;

    component angle2segs is
        port (  clk     : in STD_LOGIC;
                clear   : in STD_LOGIC;
                angle   : in STD_LOGIC_VECTOR (7 downto 0);
                an      : out STD_LOGIC_VECTOR (7 downto 0);
                seg     : out STD_LOGIC_VECTOR (6 downto 0)
        );            
    end component;
    
    component sw2angle is
        port (  clk      : in  std_logic;
                sw_up    : in  std_logic;
                sw_down  : in  std_logic;
                angle    : out STD_LOGIC_VECTOR (7 downto 0)
        );            
    end component;

    signal s_angle_btn : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    signal s_angle : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');


begin
    B2PWM: bin2PWM
    port map(
        clk     =>  CLK100MHZ,
        rst     =>  BTNC,
        angle   =>  s_angle,
        pwm_out =>  JA_out
   );
   
   A2P: angle2pulse
    port map(
        clk     =>  CLK100MHZ,
        rst     =>  BTNC,
        angle   =>  s_angle,
        pulse =>  JB_out
   );

   A2SEGS: angle2segs
    port map(
        clk     => CLK100MHZ,
        clear   => BTNC,
        angle   => s_angle,
        an      => AN,
        seg(6)  => CA,
        seg(5)  => CB,
        seg(4)  => CC,
        seg(3)  => CD,
        seg(2)  => CE,
        seg(1)  => CF,
        seg(0)  => CG
   );
   
    S2ANGLE: sw2angle
    port map(
        clk     =>  CLK100MHZ,
        sw_up   =>  BTNU,
        sw_down =>  BTND,
        angle   =>  s_angle_btn
   );
        
   DP <= '1';
   
   p_mode : process (CLK100MHZ) is
    begin
    if (SW_F = '0') then
        s_angle <= s_angle_btn;
    else
        s_angle <= SW;
    end if;
    
   end process;

end Behavioral;
