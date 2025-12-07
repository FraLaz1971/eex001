C PROGRAM HANDLING SALES DATA
C DATA ARE ORGANISED IN RECORDS:
C Columns 1 - 4   department code (4 characters)
C Columns 11-14   goods code (4 characters)
C Columns 21-26   price (6 characters ddd.cc)
C Columns 31-36   amount tendered by costumer (6 characters ddd.cc)
C Columns 41-46   change given (6 characters ddd.cc)
C The departments are in 4 groups (Hardware, Electrical, Furnishing, Clothing)
C The first letter of the department codes will be H,E,F,C as appropriate
C Data is terminated by a record consisting of the word END in columns 1-3
C and otherwise blank
      PROGRAM SALES
        IMPLICIT NONE
        CHARACTER*80 DFN,RFN
        DFN='sales001.txt'
        RFN='results001.txt'
C        CALL WD
        CALL CD(DFN)
        CALL RDS(RFN)
        STOP
      END
C
C WRITE RECORDS DATA ON A FILE
      SUBROUTINE WD
        IMPLICIT NONE
C DFN: Data File name
        CHARACTER*80 DFN
        CHARACTER*4 DC,GC
        REAL PRICE, AMOUN, CHANGE
        DFN='sales001.txt'
        OPEN(11,FILE=DFN,ERR=9000)
C RECORD 1
        DC='H001'
        GC='1240'
        PRICE = 20.60
        AMOUN = 21.00
        CHANGE = 0.40
        WRITE(11,100,ERR=9100)DC,GC,PRICE,AMOUN,CHANGE
C RECORD 2
        DC='E003'
        GC='0077'
        PRICE = 78.00
        AMOUN = 80.00
        CHANGE = 2.00
        WRITE(11,100,ERR=9100)DC,GC,PRICE,AMOUN,CHANGE
C RECORD 3
        DC='F002'
        GC='0999'
        PRICE = 33.15
        AMOUN = 35.00
        CHANGE = 1.85
        WRITE(11,100,ERR=9100)DC,GC,PRICE,AMOUN,CHANGE
C RECORD 4
        DC='C103'
        GC='0007'
        PRICE = 99.20
        AMOUN = 100.00
        CHANGE = 0.80
        WRITE(11,100,ERR=9100)DC,GC,PRICE,AMOUN,CHANGE
        WRITE(11,110) ' '
        CLOSE(11)
        GOTO 9999
100     FORMAT(2(A4,6X),2(F6.2,4X),F6.2)
C END RECORD
110     FORMAT('END',42X,A1)
9000    PRINT *,'ERROR IN OPENING SALES DATA FILE'
        GOTO 9999
9100    PRINT *,'ERROR IN WRITING SALES RECORD'
9999    STOP
      END

      SUBROUTINE FILE(DC,GC,PRICE)
        CHARACTER*4 DC,GC
        REAL PRICE
        WRITE(12,300) DC,GC,PRICE
300   FORMAT(A4,1X,A4,1X,F6.2)
      END
C CHECK DATA TAKES IN INPUT THE DATA FILE
      SUBROUTINE CD(DFN)
        IMPLICIT NONE
        LOGICAL DEBUG
        CHARACTER*80 DFN,RFN
        CHARACTER*4 DC,GC
        INTEGER CNT
        REAL PRICE, AMOUN, CHANGE
        RFN='results001.txt'
        DEBUG = .FALSE.
        CNT=1
        OPEN(11,FILE=DFN,ERR=9000)
        OPEN(12,FILE=RFN,ERR=9100)
80      READ(11,100,END=90) DC,GC,PRICE,AMOUN,CHANGE
        IF (DEBUG) PRINT 110,AMOUN,PRICE,(AMOUN-PRICE)
        IF (DEBUG) PRINT 120,CHANGE
        IF (DC(1:3).EQ.'END') GOTO 90
        IF(ABS((AMOUN-PRICE-CHANGE)).GT.0.01) THEN
          PRINT *,'ERROR FOUND IN RECORD ',CNT
        ELSE
          PRINT *,'RECORD N.',CNT,' IS CORRECT'
          CALL FILE(DC,GC,PRICE)
        END IF
          CNT = CNT + 1
        GOTO 80
90      CLOSE(11)
        CLOSE(12)
100     FORMAT(2(A4,6X),2(F6.2,4X),F6.2)
110     FORMAT(F6.2,'-',F6.2,'=',F6.2)
120     FORMAT('CHANGE=',F6.2)
        GOTO 9999
9000    PRINT *,'ERROR IN OPENING SALES DATA FILE FOR READING'
        GOTO 9999
9100    PRINT *,'ERROR IN OPENING SALES DATA FILE FOR WRITING'
        GOTO 9999
9999    CONTINUE
      END

C REPORT DEPARTMENT SALES
      SUBROUTINE RDS(RFN)
        CHARACTER*80 RFN
        CHARACTER*4 DC,GC
        REAL PRICE,HTOT,ETOT,FTOT,CTOT
        OPEN(12,FILE=RFN,ERR=9000)
80      READ(12,300,END=90) DC,GC,PRICE
        IF (DC(1:1).EQ.'H') THEN
          HTOT = HTOT + PRICE
        ELSE IF (DC(1:1).EQ.'E') THEN
          ETOT = ETOT + PRICE
        ELSE IF (DC(1:1).EQ.'F') THEN
          FTOT = FTOT + PRICE
        ELSE IF (DC(1:1).EQ.'C') THEN
          CTOT = CTOT + PRICE
        END IF
        GOTO 80
90      CONTINUE
        PRINT 310,HTOT
        PRINT 320,ETOT
        PRINT 330,FTOT
        PRINT 340,CTOT
        CLOSE(12)
        GOTO 9999
300     FORMAT(A4,1X,A4,1X,F6.2)
310     FORMAT('HARDWARE TOT. SALES:   ',F6.2)
320     FORMAT('ELECTRICAL TOT. SALES: ',F6.2)
330     FORMAT('FURNISHING TOT. SALES: ',F6.2)
340     FORMAT('CLOTHING TOT. SALES:   ',F6.2)
9000    PRINT *,'ERROR IN OPENING RESULTS DATA FILE FOR READING'
        GOTO 9999
9100    PRINT *,'END OF FILE REACHED'
        GOTO 9999
9999    CONTINUE
      END
