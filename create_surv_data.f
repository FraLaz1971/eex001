      PROGRAM CSD
        CALL CRD
        STOP
      END

      SUBROUTINE INIRAN
  	    CALL RANDOM_SEED()
      END

      INTEGER FUNCTION GRC(I)
	    IMPLICIT NONE
	    INTEGER I
	    REAL R
	    CALL RANDOM_NUMBER(R)
	    GRC = INT(R*I)
      END

      REAL FUNCTION GRCR(I)
	    IMPLICIT NONE
	    INTEGER I
	    REAL R
	    CALL RANDOM_NUMBER(R)
	    GRCR=R*I
      END
C CREATE SURVEY DATA
      SUBROUTINE CRD
        IMPLICIT NONE
        INTEGER GRC
        REAL GRCR
        INTEGER I,MAXDATA
        PARAMETER(MAXDATA=10)
        CHARACTER*20 NAME(MAXDATA)
        CHARACTER*1 SEX(MAXDATA)
C IN YEARS YY
        INTEGER AGE(MAXDATA)
        INTEGER HEIGHT(MAXDATA)
        REAL WEIGHT(MAXDATA)
        CHARACTER*80 SFN
        DATA SFN/'survey001.txt'/
        DATA NAME/'Mary Johns          ','Andrew Richley      ',
     &            'Tony Abbas          ','Lisa Stansfields    ',
     &            'Lory Hammerson      ','Louis Haber         ',
     &            'Tom Hanks           ','Margaret Hamilton   ',
     &            'Luna Andrews        ','Camilla reds        '/
       DATA SEX /'1','0','0','1','1','0','0','1','1','1'/
       DATA AGE/MAXDATA*0/,HEIGHT/MAXDATA*0/,WEIGHT/MAXDATA*0.0/
        OPEN(11,FILE=SFN)
        PRINT 110,'NAME          ','SEX','AGE','HEI.','WEIG.'
        CALL INIRAN
        DO 10 I=1,MAXDATA
          AGE(I)=15+GRC(40)
          IF(SEX(I).EQ.'0') THEN
            HEIGHT(I)=150+GRC(50)
            WEIGHT(I)=55.0+GRCR(39)
          ELSE
            HEIGHT(I)=145+GRC(40)
            WEIGHT(I)=45.0+GRCR(45)
          END IF
          PRINT 100,NAME(I),SEX(I),AGE(I),HEIGHT(I),WEIGHT(I)
          WRITE(11,100,ERR=9000)NAME(I),SEX(I),AGE(I)
     & ,HEIGHT(I),WEIGHT(I)
10      CONTINUE
        CLOSE(11)
        GOTO 9999
100   FORMAT(A20,2X,A1,3X,I2,2X,I3,2X,F5.2)
110   FORMAT(A20,A3,1X,A4,2X,A5,2X,A5)
9000  PRINT *,'ERROR IN WRITING SURVEY DATA'
9999  CONTINUE
      END
