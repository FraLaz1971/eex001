      PROGRAM COLON
        IMPLICIT NONE
        REAL A,B
        A=3.5
        B=2.0
        PRINT 100,A,B,A+B
        PRINT 100,A,B,A+B,A*B
        STOP
100   FORMAT('THE SUM OF ',F8.2,' AND ',F8.2,' IS ', F8.2,:,
     & ' THE PRODUCT IS ',F8.2)
      END
