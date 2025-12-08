      PROGRAM SCSU
        IMPLICIT NONE
        INTEGER I,N,NM,NF,N18P,UL18,UM45
        INTEGER TM,TF
        REAL AL18,AM45,SM,SF,SL18,SM45,FFEM,MFEM,BUF
        CHARACTER*80 IFNAM
        CHARACTER*10 TEMP
        CHARACTER*4 TEMPM
        CHARACTER*4 TEMPF
        CHARACTER*4 TEMP45
        CHARACTER*6 TEMPSM
        PARAMETER(N=2004)
        CHARACTER*20 NAME(N)
        INTEGER SEX(N),JS(N),AGE(N)
C NMU=NUMBER OF MONTHS UNEMPLOYED
C NWC=NON WORKING CODE
        INTEGER NMU(N),NWC(N)
        DATA IFNAM/'jobsurvey001.txt'/
        I=1
        OPEN(11,FILE=IFNAM,ERR=9000)
        NM=0
        NF=0
        N18P=0
C FFEM: N. OF FEMALES 18+
        FFEM=0.0
C MFEM: N. OF MALES 18+
        MFEM=0.0
        AL18=0.0
        AM45=0.0
        SL18=0
        SM45=0
        UL18=0
        UM45=0
        TM=0
        TF=0
        SM=0
        SF=0
10      READ(11,105,ERR=9100,END=80) NAME(I),SEX(I),JS(I),TEMP
C        PRINT *,'NAME:',NAME(I)
        IF (SEX(I).EQ.9) GOTO 90
        IF (SEX(I).EQ.0) TM=TM+1
        IF (SEX(I).EQ.1) TF=TF+1
        WRITE(TEMPM,'(I4)')TM
        WRITE(TEMPF,'(I4)')TF
C        PRINT *,TM,' MEN ',TF,' WOMEN'
        IF(JS(I).EQ.1) THEN
            IF (SEX(I).EQ.1) THEN
                NF=NF+1
                READ(TEMP,'(I2)') AGE(I)
                IF(AGE(I).GE.18) FFEM = FFEM + 1.0
            ELSE IF((SEX(I).EQ.0)) THEN
                NM=NM+1
                READ(TEMP,'(I2)') AGE(I)
                IF(AGE(I).GE.18) MFEM = MFEM + 1.0
                BUF = MFEM
            END IF
        ELSE IF(JS(I).EQ.4) THEN
          READ(TEMP,'(I2,2X,I3)') AGE(I),NMU(I)
          IF(AGE(I).LT.18) THEN
            UL18 = UL18 + 1
            SL18 = SL18 + NMU(I)
          ELSE IF(AGE(I).GT.45) THEN
            UM45 = UM45 + 1
            SM45 = SM45 + NMU(I)
            WRITE(TEMP45,'(I4)')UM45
          END IF
        ELSE IF(JS(I).EQ.5) THEN
          READ(TEMP,'(I2,1X,I1)') AGE(I),NWC(I)
          IF(NWC(I).EQ.1) SM=SM+1.0
          WRITE(TEMPSM,'(F6.2)')SM
        ELSE
            CONTINUE
        END IF
        I = I + 1
        GOTO 10
80      PRINT *,'END OF FILE REACHED'
90      CLOSE(11)
        READ(TEMPM,'(I4)')TM
        READ(TEMPF,'(I4)')TF
        READ(TEMP45,'(I4)')UM45
        READ(TEMPSM,'(F6.2)')SM
        PRINT *,'THERE ARE ',TM,' MEN AND ',TF,' WOMEN'
C WRITE THE PERCENTAGE FOR EACH SEX OF PEOPLE IN FULL EDUCATION WITH AGE>=18
        PRINT 170,BUF,NM,FFEM,NF
        IF((NM.GT.0).AND.(NF.GT.0))PRINT 190,BUF*100/(NM),FFEM*100/(NF)
C WRITE THE AVERAGE LENGTH OF UNEMPLOYEMENT FOR THOSE <18 AND THOSE >45
        PRINT *,'SL18: ',SL18,' UL18: ',UL18
        PRINT *,'SM45: ',SM45,' UM45: ',UM45
        IF((UL18.GT.0).AND.(UM45.GT.0)) PRINT 180,SL18/UL18,SM45/UM45
C WRITE THE PERCENTAGE OF MAN WHO STAY AT HOME TO LOOK AFTER THE CHILDREN
        PRINT *,'SM: ',SM
        PRINT *,'TM: ',TM
        PRINT 200,100*SM/TM
        GOTO 9999
105   FORMAT(A20,2X,I1,1X,I1,2X,A)
170   FORMAT('N. M. STUD. 18+: ',F6.2,' vs ',I4,
     & ' N. F. STUD. 18+: ',F6.2,' vs ',I4)
180   FORMAT('AVG U. LEN FOR <18',
     &   F6.2,' AVG U. LEN FOR >45',F6.2)
190   FORMAT('MALE: ',F6.2,'%'
     & ,' FEMALE: ',F6.2,'%')
200   FORMAT('MEN WHO LOOK AFTER THE CHILDREN ',F6.2,' %')
9000    PRINT *,'ERROR IN OPENING INPUT FILE'
        GOTO 9999
9100    PRINT *,'ERROR IN READING DATA'
        GOTO 9999
9999    STOP
      END
