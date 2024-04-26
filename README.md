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
Turning of the motors, describing angle of rotation, is set by switches which represent binary code. Angle can also be set by buttons. Angle of rotation is in range from 0° to 90°. The chosen angle can be seen on on 7-segment display. 
Board creates PWM signal that turns the motor. Binary code from the switches, or buttons, represent length of positive impuls. Length of the positive impuls is in range from 1ms (0°) to 2ms (90°). Period of the signal is 6ms. 

# Hardware description
On FPGA board there are BTNR and BTNL buttons used for controlling first servo, and BTNU and BTND buttons controls second servo. When SW15 is "on" buttons BTNU and BTND are deactivated and motors are controlled with swiches SW0-SW7. 
Button BTNC is used as reset button for reseting segment of 7-segment display.
For connecting board and servos, Pmod ports of the board marked as JA are used. First servo is connected to Pin 1, and second servo to Pin 3. 
![Pinout](/Pmod_pinout.png)
