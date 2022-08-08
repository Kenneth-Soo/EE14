{
  Project:      EE-14 Lab 1
  Platform:     Parallex Project USB Board
  Revision:     1.1
  Author:       Kenneth
  Date:         24th February 2022
  Log:
        Date:        Description:
        02/24/2022
}


CON
        _clkmode = xtal1 + pll16x                                               'Standard clock mode * crystal frequency = 80 MHz
        _xinfreq = 5_000_000

        ' Creating a Pause()
        _ConClkFreq = ((_clkmode - xtal1) >> 6) * _xinfreq
        _MS_001     = _ConClkFreq / 1_000

VAR


OBJ
        Motor      : "MecanumControl.spin"
        Comm       : "FullDuplexSerial.spin"

PUB Init(commTxPin, commRxPin, commBaud)

        Comm.Start(commTxPin, commRxPin, 0, commBaud)
        Pause(3000)

PUB CommCore(Header, Dir, Spd, Checksum)  |   Check

        repeat
          if (Header == $7A)
            Check := (Dir ^ Spd) ^ $7F   ' Runs check and compare
            if (Check == Checksum)       ' with Checksum to determine right byte
              Motor.Set(Dir, Spd)
              result := 0                ' Returns 0 if no error
            else
              Motor.Set(Dir, Spd)        ' Send Stop Bit
              result := 1                ' Returns 1 if error occurs
          else
            Motor.Set(Dir, Spd)          ' Send Stop Bit
            result := 1

PRI Pause(ms) | t

        t := cnt - 1088
        repeat (ms #> 0)
          waitcnt(t += _MS_001)
        return