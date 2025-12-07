      PROGRAM SALES
        IMPLICIT NONE
        INTEGER IMAX,I,IOS
        CHARACTER*64 RFILE
        CHARACTER*4 DEP,GOODS,GROUP*1
C .TRUE. IN CASE OF ERROR
        REAL PRICE,CASH,CHANGE
        REAL SUMC,SUME,SUMF,SUMH
        LOGICAL ERRC,ERRE,ERRF,ERRH
C        PARAMETER(IMAX=10000)
        PARAMETER(IMAX=100)
        DATA SUMC,SUME,SUMF,SUMH/4*0.0/
        DATA ERRC,ERRE,ERRF,ERRH/4*.FALSE./
        RFILE='result001.txt'
        OPEN(12,FILE=RFILE)
        DO 10,I=1,IMAX
          READ(*,101,IOSTAT=IOS)DEP,GOODS,PRICE,CASH,CHANGE
          WRITE(*,*)'IOS=',IOS
          IF(DEP(1:2).EQ.'EN') GOTO 11
          GROUP=DEP
          IF(ABS(CASH-PRICE-CHANGE).LT.0.01) THEN
            CALL FILE(DEP,GOODS,PRICE)
            IF (GROUP.EQ.'C') THEN
              SUMC = SUMC + PRICE
            ELSE IF (GROUP.EQ.'E') THEN
              SUME = SUME + PRICE
            ELSE IF (GROUP.EQ.'F') THEN
              SUMF = SUMF + PRICE
            ELSE IF (GROUP.EQ.'H') THEN
              SUMH = SUMH + PRICE
            END IF
C IF THE SALE IS NOT CORRECT
          ELSE
            WRITE(*,201)DEP,GOODS,PRICE,CASH,CHANGE
            IF(GROUP.EQ.'C') THEN
              ERRC=.TRUE.
            ELSE IF(GROUP.EQ.'E') THEN
              ERRE=.TRUE.
            ELSE IF(GROUP.EQ.'F') THEN
              ERRF=.TRUE.
            ELSE IF(GROUP.EQ.'H') THEN
              ERRH=.TRUE.
            ELSE
              CONTINUE
            END IF
          END IF
10      CONTINUE
11      IF (ERRC) THEN
          WRITE(*,202) 'CLOTHING'
        ELSE
          WRITE(*,203) 'CLOTHING',SUMC
        END IF
        IF (ERRE) THEN
          WRITE(*,202) 'ELECTRICAL'
        ELSE
          WRITE(*,203) 'ELECTRICAL',SUME
        END IF
        IF (ERRF) THEN
          WRITE(*,202) 'FURNISHING'
        ELSE
          WRITE(*,203) 'FURNISHING',SUMF
        END IF
        IF (ERRH) THEN
          WRITE(*,202) 'HARDWARE'
        ELSE
          WRITE(*,203) 'HARDWARE',SUMH
        END IF
        CLOSE(12)
        STOP
101     FORMAT(2(A4,6X),3(F6.2,4X))
201     FORMAT('DATA ERROR IN FOLLOWING RECORD:'/
     & ,2(A4,6X),3(F6.2,4X)/)
202     FORMAT('ERROR(S) IN ',A,' DATA')
203     FORMAT(A,' SALES WORTH $',F9.2)
      END
      SUBROUTINE FILE(DC,GC,PRICE)
        CHARACTER*4 DC,GC
        REAL PRICE
        WRITE(*,300) DC,GC,PRICE
        WRITE(12,300) DC,GC,PRICE
300   FORMAT(A4,1X,A4,1X,F6.2)
      END
