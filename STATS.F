      SUBROUTINE STATS(COLLECTOR, INDEX, AVERAGE, VARIANCE, STDEV)
      
      COMMON /INIT/ NR, NW, ND, NT7, NT8, NDAT, NS1, NS2

      DIMENSION COLLECTOR(5,1)
      INTEGER INDEX

      XS = COLLECTOR(1, INDEX)
      XSS = COLLECTOR(2, INDEX)
      XN = COLLECTOR(3, INDEX)
      AVERAGE = XS / XN

      IF(XN .LE. 1.0) GO TO 1
      VARIANCE = ((XN * XSS) - (XS * XS)) / (XN * (XN - 1.0))

      IF(VARIANCE) 1, 1, 7
7     STDEV = VARIANCE ** 0.5
      RETURN

1     VARIANCE = 0.0
      STDEV = 0.0

      RETURN
      END
C*********************************************************END OF STATPK**