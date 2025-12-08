        REAL FUNCTION ROUND(X,N)
          IMPLICIT NONE
          REAL X
          INTEGER N,I
          CHARACTER D(9),NUM*20
          DATA D/'1','2','3','4','5','6','7','8','9'/
C CHECK THE VALUE OF N AND SET I TO A VALID N
          IF(N.LT.1) THEN
            I=1
          ELSE IF(N.GT.9) THEN
            I=9
          ELSE
            I=N
          END IF
C USE CHARACTER EXPRESSION AS FORMAT FOR OUTPUT ON INTERNAL FILE NUM
          WRITE(NUM,'(F20.'//D(I)//')') X
          PRINT *,'NUM = ',NUM
C USE STANDARD INPUT FORMAT TO READ FROM THE INTERNAL FILE
          READ(NUM,'(F20.'//D(I)//')') ROUND
          RETURN
        END
        PROGRAM INTER
          IMPLICIT NONE
          CHARACTER D(9)
          DATA D/'1','2','3','4','5','6','7','8','9'/
          REAL X,RO,ROUND
          INTEGER N
          PRINT *,'ENTER A REAL AND N. OF DECIMALS'
          READ *,X,N
          IF(N.LT.1) THEN
            N=1
          ELSE IF(N.GT.9) THEN
            N=9
          ELSE
            CONTINUE
          END IF
          RO=ROUND(X,N)
          PRINT '(A,F20.'//D(N)//')','ROUND=',RO
        END
