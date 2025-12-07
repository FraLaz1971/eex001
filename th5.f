C SURVEY ON OCCUPATION IN A REGION
C THE SURVEY DATA ARE SAVED IN AN ASCII FILE
C WITH THE FOLLOWING FORMAT:
C Columns 1-20    Name
C Column    23    Sex
C                  0 if male
C                  1 if female
C Column    25    job status
C                  1 if in full time education        --> columns 28,29 Age
C                  2 if in full time employement      --> columns 28,31 monthly salary ($)
C                  3 if in part time employement      --> columns 28,31 monthly salary ($)
C                                                         columns 34,37 other monthly income
C                  4 if temporarily unemployed        --> columns 28,29 Age
C                                                         columns 32,34 n. of months unemployed
C                  5 if not working or searching job  --> columns 28,29 Age
C                                                         column  31    Code = 1 if looking after children
C                                                                            = 2 if looking after other relatives
C                                                                            = 3 for any other reason
      PROGRAM CJS
        IMPLICIT NONE
        INTEGER I,N
        INTEGER GRC,GRCV
        PARAMETER(N=10)
        CHARACTER*20 NAME(N)
        CHARACTER*80 SFN
        INTEGER SEX(N),JS(N),AGE(N),SALARY(N),OSAL(N)
C NMU=NUMBER OF MONTHS UNEMPLOYED
C NWC=NON WORKING CODE
        INTEGER NMU(N),NWC(N)
        DATA SFN/'jobsurvey001.txt'/
        DATA NAME/'Mary Johns          ','Andrew Richley      ',
     &            'Tony Abbas          ','Lisa Stansfields    ',
     &            'Lory Hammerson      ','Louis Haber         ',
     &            'Tom Hanks           ','Margaret Hamilton   ',
     &            'Luna Andrews        ','Camilla reds        '/
       DATA SEX /1,0,0,1,1,0,0,1,1,1/
        CALL INIRAN
        OPEN(11,FILE=SFN,ERR=9000)
        DO 10,I=1,N
            JS(I)=GRC(5)+1
            AGE(I)=GRC(40)+15
c            PRINT *,'JS = ',JS(I)
            IF (JS(I).EQ.1) THEN
C              WRITE(11,*,ERR=9100) 'NAME             ','  SEX '
C     &,' JS',' AGE'
              WRITE(11,110,ERR=9100) NAME(I),SEX(I),JS(I),AGE(I)
            ELSE IF (JS(I).EQ.2) THEN
              SALARY(I)=800+GRC(1500)
C              WRITE(11,*,ERR=9100) 'NAME             ','  SEX '
C     &,' JS',' SALARY'
                WRITE(11,120,ERR=9100) NAME(I),SEX(I),JS(I),SALARY(I)
            ELSE IF (JS(I).EQ.3) THEN
              SALARY(I)=500+GRC(1000)
              OSAL(I)=500+GRC(500)
C              WRITE(11,*,ERR=9100) 'NAME             ','  SEX '
C     &,' JS',' SALARY',' OSAL'
                WRITE(11,130,ERR=9100) NAME(I),SEX(I),JS(I),SALARY(I)
     & ,OSAL(I)
            ELSE IF (JS(I).EQ.4) THEN
              NMU(I)=1+GRC(48)
C              WRITE(11,*,ERR=9100) 'NAME             ','  SEX '
C     &,' JS',' AGE',' NMU'
                WRITE(11,140,ERR=9100) NAME(I),SEX(I),JS(I),AGE(I)
     & ,NMU(I)
            ELSE IF (JS(I).EQ.5) THEN
            NWC(I)=1+GRC(3)
C              WRITE(11,*,ERR=9100) 'NAME             ','  SEX '
C     &,' JS',' AGE',' NWC'
                WRITE(11,150,ERR=9100) NAME(I),SEX(I),JS(I),AGE(I)
     & ,NWC(I)
            ELSE
                PRINT *,'ILLEGAL JOB STATUS',JS(I)
            END IF
10      CONTINUE
        WRITE(11,160,ERR=9100) 9,' '
        CLOSE(11)
        GOTO 9999
110   FORMAT(A20,2X,I1,1X,I1,2X,I2)
120   FORMAT(A20,2X,I1,1X,I1,2X,I4)
130   FORMAT(A20,2X,I1,1X,I1,2X,I4,2X,I4)
140   FORMAT(A20,2X,I1,1X,I1,2X,I2,2X,I3)
150   FORMAT(A20,2X,I1,1X,I1,2X,I2,1X,I1)
160   FORMAT(22X,I1,10X,A1)
9000  PRINT *,'ERROR IN OPENING SURVEY DATA FILE',SFN
      GOTO 9999
9100  PRINT *,'ERROR IN WRITING SURVEY DATA'
9999  STOP
      END
