'*****************************
'* Name    : ShiftLight.bas  *
'* Author  : SSh             *
'* MCU     : PIC12F675       *
'* OSC     : Internal        *
'*****************************

@ DEVICE PIC12F675,INTOSC   ' Set oscillator - internal  
DEFINE OSC 4                ' Internal Freq. 4 MHz

TRIGGER_IN  var GPIO.0       ' pin 7 (pic12f675)
TRIGGER_OUT var GPIO.1       ' pin 6 (pic12f675)
SET_CUTOFF  var GPIO.4       ' pin 3 (pic12f675)

HPULSE VAR WORD
LPULSE VAR WORD
PERIOD VAR WORD
STORED VAR WORD

TRISIO = %010001                ' Setup ports for in-out, 0 - oit, 1 - in
ANSEL  = 0                      ' Make all pins digital        
CMCON  = %00000111              ' ??? WTF ??? 

main:
READ 0, STORED.Byte0            ' Put value from EEPROM address '0' into 'STORED.Byte0'
READ 1, STORED.Byte1            ' Put value from EEPROM address '1' into 'STORED.Byte1'

pulsin TRIGGER_IN, 0, LPULSE    ' Measure low pulse on GPIO.0 = pin 7 (pic12f675)
pulsin TRIGGER_IN, 1, HPULSE    ' Measure high pulse on GPIO.0 = pin 7 (pic12f675)
PERIOD = LPULSE+HPULSE          ' Get signal period

IF SET_CUTOFF = 0 THEN          ' IF Button on pin 3 (pic12f675) is pressed
WRITE 0, PERIOD.Byte0           ' save current perriod 'PERIOD.Byte0' into EEPROM address '0'
WRITE 1, PERIOD.Byte1           ' save current perriod 'PERIOD.Byte1' into EEPROM address '1'
ENDIF

IF PERIOD = 0 THEN              ' BLINK TRIGGER_OUT if no TRIGGER_IN signal
TRIGGER_OUT = 0                 ' Cut off trigger / LED is OFF
PAUSE 60                        ' pause im milliseconds
TRIGGER_OUT = 1                 ' Restore trigger / LED is ON
PAUSE 20                        ' pause im milliseconds
GOTO main
ENDIF

IF PERIOD < STORED THEN
' SOUND BIPPER,[120,10] -       ' Bipper
TRIGGER_OUT = 0                 ' Cutoff trigger
PAUSE 17                        ' Cutoff triger timeout
TRIGGER_OUT = 1                 ' Turn it ON - restore trigger output
PAUSE 20                        ' Delay for 'ON' state with  before next cycle
ENDIF
                                ' RPM per min   T, period, ms
                                ' 800               75
                                ' 1000              60
                                ' 2000              30
                                ' 2500              24
                                ' 3000              20
                                ' 4000              15
                                ' 5000              12
                                ' 5500              10,9
                                ' 6000              10
                                ' 6500              9,2
                                ' 7000              8,6

goto main
END
