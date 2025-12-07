      PROGRAM TH1
        IMPLICIT NONE
        REAL R1,R2,R3
        DATA R1/12.45/
        DATA R2/717.99/
        DATA R3/0.03/
        WRITE(*,200) R1,R2
        WRITE(*,100) R3,R3
        WRITE(*,100) R1,R1
        STOP
100   FORMAT(1P,F10.3)
200   FORMAT(2F10.3)
      END
