      PROGRAM ASCII
      CHARACTER*4 A,B,C,D,E
      DATA A/'MEOW'/,B/'ARF'/,C/'1234'/,D/'6789'/
      DATA E/'MEOW'/
      IF (LGT(A,B)) THEN
        PRINT *,A,' IS GT ',B
      ELSE
        PRINT *,B,' IS GT ',A
      END IF
      IF (LLT(C,D)) THEN
        PRINT *,C,' IS LT ',D
      ELSE
        PRINT *,D,' IS LT ',C
      END IF
      IF (A.EQ.E) PRINT *,A,' IS EQ TO ',E
        STOP
      END
