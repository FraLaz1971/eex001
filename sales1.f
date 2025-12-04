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
        CALL WD
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
        PRINT *,'DEP. CODE','GOOD CODE','PRICE'
        PRINT *,DC,GC,PRICE
      END
