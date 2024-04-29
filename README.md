# FPGA-Servo-control
Team project of controlling servo motor with FPGA Nexys A7-50T board

# Team members
- Josef Šikula (responsible for coordinating project and everything other)
- Ondřej Vlček (responsible for Top Level)
- Marek Smolinský (responsible for bin2PWM block)

# Theory
## Problem
Controlling two servo motors via FPGA board Nexys A7-50T.

## Solution of the problem
Turning of the motors, describing angle of rotation, is set by switches which represent binary code. Angle can also be set by buttons. Angle of rotation is in range from 0° to 90°. The chosen angle can be seen on on 7-segment display.<br> 
Board creates PWM signal that turns the motor. Binary code from the switches, or buttons, represent length of positive impulse. Length of the positive impulse is in range from 1ms (0°) to 2ms (90°). Period of the signal is 6ms. 

# Hardware description
On FPGA board there are BTNR and BTNL buttons used for controlling first servo, and BTNU and BTND buttons controls second servo. When SW15 is "on" buttons BTNU and BTND are deactivated and motors are controlled with swiches SW0-SW7.<br> 
Button BTNC is used as reset button for reseting segment of 7-segment display.<br>
For connecting board and servos, Pmod ports of the board marked as JA are used. First servo is connected to Pin 1, and second servo to Pin 3.<br> 
![Pinout](/images/Pmod_pinout.png)
![Servo](/images/servo_power.png)
# Software description
## Schematic
![Schematic of toplevel](/images/toplevel_scheme.png)
## Components simulation
### angle2segs
[Angle2segs component](src/bin2PWM.vhd) take input from buttons or switches and display value of angle on 7-segment display.
![sim A2S](/images/sim_angle2segs.png)
### angle2pulse
[Component angle2pulse](src/angle2pulse.vhd) used to generate pulse with floating period according to input (angle) with synchronous reset.
![sim A2P](/images/sim_angle2pulse.png)
### bin2PWM
[Component bin2PWM](src/bin2PWM.vhd) create PWM signal. Value of the angle is coded in lenght of positive impulse of PWM signal. Period of PWM signal is 6ms. 
![sim B2PWM](/images/sim_bin2pwm.jpg)
When period pulse is HIGH, resets angle2pulse component and sets pwm_out to HIGH, angle2pulse's pulse sets pwm_out to LOW
![B2PWM schematic](/images/bin2PWM_scheme.jpg)
### sw2angle
[Component sw2angle](src/sw2angle.vhd) create binary code of the angle from two inputs representing two buttons - up and down. When button hold, incrementing every period 1 degree more. When released and pushed again, stars incrementing from 2.
![sim SW2A](/images/sim_sw2angle.png)

### bin2bcd
[Bin2BCD component](src/bin2bcd.vhd) is implementing Double dabble algorithm describend in [`2. reference`](#references)
![sim B2bcd](/images/sim_bin2bcd.png)


# Instructions
Our video link [here](https://www.youtube.com/)

# References

1. Tomas Fryza [VHDL course](https://github.com/tomas-fryza/vhdl-course/)

2. Wikipedia [Double dabble algorithm](https://en.wikipedia.org/wiki/Double_dabble)

3. Bertrand Gros [Online VHDL Testbench template generator](https://vhdl.lapinoo.net/testbench/)

4. Blog WOKWI [Learn ti Control Servo using PWM](https://blog.wokwi.com/learn-servo-motor-using-wokwi-logic-analyzer/)

5. [Markdown Guide](https://www.markdownguide.org/basic-syntax/#code)