{
  Project:      EE-14 Lab
  Platform:     Parallex Project USB Board
  Revision:     1.1
  Author:       Kenneth
  Date:         18th February 2022
  Log:
        Date:        Description:
        02/18/2022
}


CON
        _clkmode = xtal1 + pll16x                                               'Standard clock mode * crystal frequency = 80 MHz
        _xinfreq = 5_000_000

        ' Creating a Pause()
        _ConClkFreq = ((_clkmode - xtal1) >> 6) * _xinfreq
        _MS_001     = _ConClkFreq / 1_000

        'Pin & Baudrate Assignment
        'RoboClaw 1
        R1S1 = 3
        R1S2 = 2

        'RoboClaw 2
        R2S1 = 5
        R2S2 = 4

        'SimpleSerial
        SSBaud = 57_600

        S1Stop = 64
        S2Stop = 192

VAR


OBJ
        MD1 : "FullDuplexSerial.spin"
        MD2 : "FullDuplexSerial.spin"

PUB Main
        Init

        Pause(5000)
        Set(1,30)
        Pause(2000)
        Set(11,30)
        Pause(1000)
        Set(2,30)
        Pause(2000)
        Set(11,30)
        Pause(1000)
        Set(3,30)
        Pause(2000)
        Set(11,30)
        Pause(1000)
        Set(4,30)
        Pause(2000)
        Set(11,30)
        Pause(1000)
        Set(5,30)
        Pause(2000)
        Set(11,30)
        Pause(1000)
        Set(8,30)
        Pause(2000)
        Set(11,30)
        Pause(1000)
        Set(6,30)
        Pause(2000)
        Set(11,30)
        Pause(1000)
        Set(7,30)
        Pause(2000)
        Set(11,30)
        Pause(1000)
        Set(9,30)
        Pause(3000)
        Set(11,30)
        Pause(1000)
        Set(10,30)
        Pause(3000)
        Set(11,30)

PUB Init
        MD1.Start(R1S2, R1S1, 0, SSBaud)
        MD2.Start(R2S2, R2S1, 0, SSBaud)

PUB Set(DIR, SPD)
        case DIR
          1:
            North(SPD)
          2:
            South(SPD)
          3:
            East(SPD)
          4:
            West(SPD)
          5:
            NE(SPD)
          6:
            NW(SPD)
          7:
            SE(SPD)
          8:
            SW(SPD)
          9:
            LeftTurn(SPD)
          10:
            RightTurn(SPD)
          11:
            Stop

PUB North(Speed)
        MD1.Tx(S1Stop + Speed)
        MD1.Tx(S2Stop + Speed)
        MD2.Tx(S1Stop + Speed)
        MD2.Tx(S2Stop + Speed)

PUB South(Speed)
        MD1.Tx(S1Stop - Speed)
        MD1.Tx(S2Stop - Speed)
        MD2.Tx(S1Stop - Speed)
        MD2.Tx(S2Stop - Speed)

PUB East(Speed)
        MD1.Tx(S1Stop + Speed)
        MD1.Tx(S2Stop - Speed)
        MD2.Tx(S1Stop - Speed)
        MD2.Tx(S2Stop + Speed)

PUB West(Speed)
        MD1.Tx(S1Stop - Speed)
        MD1.Tx(S2Stop + Speed)
        MD2.Tx(S1Stop + Speed)
        MD2.Tx(S2Stop - Speed)

PUB NE(Speed)
        MD1.Tx(S1Stop)
        MD1.Tx(S2Stop + Speed)
        MD2.Tx(S1Stop + Speed)
        MD2.Tx(S2Stop)

PUB NW(Speed)
        MD1.Tx(S1Stop + Speed)
        MD1.Tx(S2Stop)
        MD2.Tx(S1Stop)
        MD2.Tx(S2Stop + Speed)

PUB SE(Speed)
        MD1.Tx(S1Stop - Speed)
        MD1.Tx(S2Stop)
        MD2.Tx(S1Stop)
        MD2.Tx(S2Stop - Speed)

PUB SW(Speed)
        MD1.Tx(S1Stop)
        MD1.Tx(S2Stop - Speed)
        MD2.Tx(S1Stop - Speed)
        MD2.Tx(S2Stop)

PUB LeftTurn(Speed)
        MD1.Tx(S1Stop - Speed)
        MD1.Tx(S2Stop + Speed)
        MD2.Tx(S1Stop - Speed)
        MD2.Tx(S2Stop + Speed)

PUB RightTurn(Speed)
        MD1.Tx(S1Stop + Speed)
        MD1.Tx(S2Stop - Speed)
        MD2.Tx(S1Stop + Speed)
        MD2.Tx(S2Stop - Speed)

PUB Stop
        MD1.Tx(S1Stop)
        MD1.Tx(S2Stop)
        MD2.Tx(S1Stop)
        MD2.Tx(S2Stop)

PRI Pause(ms) | t

        t := cnt - 1088
        repeat (ms #> 0)
          waitcnt(t += _MS_001)
        return