       PROGRAM TRIANG
         IMPLICIT NONE
         REAL SA,SB,SC,AR,AREA
         PRINT *,'ENTER SIDEA,SIDEB,SIDEC'
         READ *,SA,SB,SC
         AR=AREA(SA,SB,SC)
         PRINT *,'THE AREA OF THE TRIANGLE IS ',AR
         STOP
       END

       REAL FUNCTION AREA(A,B,C)
C computes area of a triangle from length of sizes
         REAL S,A,B,C
         S=0.5*(A+B+C)
         AREA = SQRT(S*(S-A)*(S-B)*(S-C))
         RETURN
       END
