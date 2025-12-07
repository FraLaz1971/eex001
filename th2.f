      PROGRAM TH2
        IMPLICIT NONE
        INTEGER I
        REAL X,Y
        DATA X/147.903/,Y/0.0147903/
        WRITE(*,201)X,X,X,Y,Y,Y
        PRINT *,147.903*10**3
        PRINT *,'ENTER AN INTEGER'
        READ(*,210)I
        PRINT *,'I=',I
        STOP
201   FORMAT(1H 3P,F12.4,E12.4,G12.4)
210   FORMAT(BN,I3)
      END
