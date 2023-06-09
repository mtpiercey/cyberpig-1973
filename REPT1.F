      SUBROUTINE REPT1(IN,VEN)
      
      COMMON /INIT/ NR, NW, ND, NT7, NT8, NDAT, NS1, NS2, NOWD
      COMMON /RAN/ IRN(54), KRANUM, RLIMIT, NRNOPT, ITAPE
      COMMON /STAT/ SUM(5, 20), SUM2(5, 10), SUM3(5, 10), SUM4(5, 10)
      COMMON /GEN/ ITOT, ISIZE, NOWT, NOWY, NDAYS, NRUNS, IATRIB(18), ATRIB(4)
      COMMON /HOUSE/ NH(6), N1, N2, N3, N4, N5, N6, NXTFAR, MX1, MX2, MX3, MX4
      COMMON /WRT1/ KW
      COMMON /RPT1/ ISMYP, ISMB, ISMBG, ISMF, ISMW, ISMS, ISMM
      COMMON /BRED4/ KBRD, KSWGT(4), NONB(4), NONBK(4)
      COMMON /GAIN2/ SOP(6), HOP(6), SSLD(6), HSLD(6), SEND(6), HEND(6)
      COMMON /SALES/ MDSELL, WTS, NXTSAL, NSLD(4), WTSLD(4), VSLD(4), PRIH, PRIS
      COMMON /CLEAN/ D(5), KL4

C REPORT SUMMARY FOR HERD BASIS
      DIMENSION IN(3, 1), VEN(2, 1)

C SEND TO KW TYPE OF REPORT
C       =2 IS FARROWING SEASON REPORT.

      IF(KW-3) 2000, 3000, 40
40    IF(KW-5) 4000, 5000, 60
60    IF(KW-7) 6000, 7000, 4
4     RETURN


C SEASONAL FARROWING REPORT CD. 55 CELL 4 IS ON.
2000  WRITE(ND, 501) NOWT, NOWY, NOWD
501   FORMAT(////5X'SEASONAL FARROWING REPORT ON DAY='I4/5X,95(1H=)/10X'YEAR='I2', DAY OF YEAR='I3', THE FARROWING HOUSE WAS CLEANED TODAY, SEE (1)')
      WRITE(ND, 503)
503   FORMAT(/10X'-------ITEM------- -----MEAN----- ---ST. DEV.--- ---MINIMUM---   ---MAXIMUM---')

C KW=2 IMPLIES SEASONAL FARROWING REPORT IN SUM2()
C       SUM2( ,1)=LITTER SIZE SEASON, NO. OBS.=NO. LITTERS.
C       SUM2( ,2)=DATE OF BIRTH.
C       SUM2( ,3)=PERCENTAGE BLD. IS FILLED.
C       SUM2( ,4)=BIRTH WEIGHTS PIGS.
C       SUM2( ,5)=NO. PIGS LOST FOR BLD. NOT CLEAN.
C       SUM2( ,6)=NO. PIGS LOST FOR EXCEEDING CAPACITY.
      NL = SUM2(3, 1)
      WRITE(ND, 505) NL
505   FORMAT(/6X'FARROWED'I3' LITTERS IN FARROW BLD.')


      IF(NL) 504, 504, 506
504   IF(NOWT-10) 1505, 1505, 530
1505  WRITE(ND, 508)
508   FORMAT(/20X'ZERO OBSERVATIONS, LITTERS WERE BORN BEFORE DAY ZERO OF SIMULATION, REPORT TERMINATED')
      GO TO 530
506   CONTINUE
      CALL STATS(SUM2, 1, ASIZ, VAR, SSIZ)
      MNSIZ = SUM2(4, 1)
      MXSIZ = SUM2(5, 1)
      WRITE(ND,507) ASIZ, SSIZ, MNSIZ, MXSIZ
507   FORMAT(10X'LITTER SIZE ALIVE=  'F13.3, F16.3, 2I16)
      CALL STATS(SUM2, 2, ADAT, VAR, SDAT)
      MNDAT = SUM2(4, 2)
      MXDAT = SUM2(5, 2)
      WRITE(ND, 509) ADAT, SDAT, MNDAT, MXDAT
509   FORMAT(10X'DATE OF BIRTH=     'F13.3, F16.3, 2I16)
      CALL STATS(SUM2, 3, ACAP, VAR, SCAP)
      RNCAP = SUM2(4, 3)
      RXCAP = SUM2(5, 3)
      WRITE(ND, 511) ACAP, SCAP, RNCAP, RXCAP
511   FORMAT(10X'CAPACITY BLD., PCT.='F13.3, F16.3, 2F16.3)
      CALL STATS(SUM2, 4, AWT, VAR, SWT)
      RNWT = SUM2(4, 4)
      RXWT = SUM2(5, 4)
      WRITE(ND, 513) AWT, SWT, RNWT, RXWT
513   FORMAT(10X'BIRTH WEIGHT OF PIGS='F12.3, 3F16.3)
      NL = SUM2(3, 5)
      WRITE(ND, 515) NL
515   FORMAT(/6X'LOST'I3' LITTERS, BLD. NOT CLEANED')
      IF(NL) 520, 520, 516
516   CALL STATS(SUM2, 5, ALOS, VAR, SLOS)
      MNL = SUM2(4, 5)
      MXL = SUM2(5, 5)
      WRITE(ND, 517) ALOS, SLOS, MNL, MXL
517   FORMAT(10X'LITTER SIZE LOST=    'F13.3, F16.3, 2I16)
520   NL = SUM2(3, 6)
      WRITE(ND, 521) NL
521   FORMAT(/6X'LOST'I3' LITTERS, DUE TO BLD. OVERFLOW')
      IF(NL) 530, 530, 523
523   CALL STATS(SUM2, 6, ALOS, VAR, SLOS)
      MNL = SUM2(4, 6)
      MXL = SUM2(5, 6)
      WRITE(ND, 527) ALOS, SLOS, MNL, MXL
527   FORMAT(10X'LITTER SIZE LOST=    'F13.3, F16.3, 2I16)
530   WRITE(ND, 531)
531   FORMAT(/6X'END SEASONAL FARROWING REPORT'65(1H=))

C ZERO COLLECTING ARRAYS FOR NEXT SEASON.
      DO 561 I = 1,6
561   CALL ZROSUM(SUM2, I)
      RETURN


C SEASONAL BREEDING REPORT
C       START SEASON IN SUB. SELECT FOR INVENTORY OF SOWS AVAIL.
C           KBRD IS AVAILABLE= TOTAL NO. EXPOSED (TARGET NO. TO BREED)
C           DURING THE SEASON.
C       KSWGT() 1=OPEN GILTS, 2=OPEN SOWS, 3=OTHERS., 4= DAY
C SUB. BREED COLLECTS STATS FOR CONCEIVING SOWS AND GILTS
C       SUM2( ,7)=AGE OF SOW AT FARROWING.
C       SUM2( ,8)=ASSIGNED LITTER SIZE.
C       SUM2( ,9)=DAY OF CONCEPTION
C       COUNT NON CONCEIVING IN ARRAY NONB()
C       NONB() 1= NO. REFUSED BECAUSE MAX PREVIOUSLY REACHED.
C              2= NO. FOR LACK OF BOARS, 3= NO. FAILING PROB. TEST.
C              4 = DAY TARGET REACHED, -999 IF NOT REACHED.
3000  WRITE(ND, 3501) NOWT, NOWY, NOWD
3501  FORMAT(/////5X'SEASONAL BREEDING REPORT ON DAY='I4/5X,95(1H=)/10X'YEAR='I2', DAY OF YEAR='I3', BREEDING SWITCH TURNED OFF TODAY.')
      ITO = 0
      DO 3505 I = 1,3
3505  ITO = ITO + KSWGT(I)
      WRITE(ND, 3507) ITO, KSWGT(4), KSWGT(1), KSWGT(2), KSWGT(3)
3507  FORMAT(/6X'AFTER GILT SELECTION MAINTENANCE BLD. HAD'I3' FEMALES ON DAY='I5/10X'OPEN GILTS'9X'='I4/10X'OPEN SOWS'10X'='I4/10X'OTHERS, MAINT. BLD.='I4)

C GEST STATS ON BREEDINGS AND PRINT THEM OUT.
      NB = SUM2(3, 7)
      WRITE(ND, 3509) NB
3509  FORMAT(/6X'BREEDINGS RESULTED IN'I4' CONCEPTIONS')
      IF(NB) 3516, 3516, 3510
3510  IF(NONB(4) + 999) 3598, 3592, 3598
3592  WRITE(ND, 3593)
3593  FORMAT(1H+,48X'  TARGET NO. NOT REACHED')
      GO TO 3599
3598  WRITE(ND, 3597) KBRD, NONB(4)
3597  FORMAT(1H+,44X', TARGET NO. EXPOSED='I4' REACHED DAY='I6)
3599  WRITE(ND, 503)
      CALL STATS(SUM2, 7, AAG, VAR, SAG)
      AMN = SUM2(4, 7)
      AMX = SUM2(5, 7)
      WRITE(ND, 3511) AAG, SAG, AMN, AMX
3511  FORMAT(/10X'AGE OF SOW AT FARROWING='F9.3, 3F16.3)
      CALL STATS(SUM2, 8, ALS, VAR, SLS)
      MN = SUM2(4, 8)
      MX = SUM2(5, 8)
      WRITE(ND, 3513) ALS, SLS, MN, MX
3513  FORMAT(10X'ASSIGNED LITTER SIZE='F12.3, F16.3, 2I16)
      CALL STATS(SUM2, 9, ADY, VAR, SDY)
      MN = SUM2(4, 9)
      MX = SUM2(5, 9)
      WRITE(ND, 3515) ADY, SDY, MN, MX
3515  FORMAT(10X'DAY OF BREEDING='F17.3, F16.3, 2I16)

C NON CONCEIVING SECTION, NONB(4)=DAY MAX REACHED.
3516  ITO = 0
      DO 3517 I = 1,3
3517  ITO = ITO + NONB(I)
      WRITE(ND, 1319) ITO, NONB(1), NONB(2), NONB(3)
1319  FORMAT(/6X'SOWS IN HEAT BUT NOT BRED'24X'='I8/6X'  DUE TO- TARGET PREVIOUSLY REACHED'14X'='I8/16X'LACK OF BOARS'26X'='I8/16X'FAILING PROBABILITY OF CONCEPTION TEST ='I8)
      WRITE(ND, 1321)
1321  FORMAT(/5X'END SEASONAL BREEDING REPORT'67(1H=))
      DO 1329 I = 1,3
      NONB(I) = 0
1329  CALL ZROSUM(SUM2, I + 6)
      NONB(4) = -999
      RETURN


C BUILDING USE PERIODIC REPORT.
C  KW=4 CALL,   CALCULATION IS IN SUB. MGT3 WITH OVERFLOW CHECKS.
C     SUM4( ,1)= NURSERY STATS ON PERCENT CAPACITY
C     SUM4( ,2)= FINISHING BUILDING STATS
C     SUM4( ,3)= MAINTENANCE STATS
C     SUM4( ,4)= FARROW CRATES STATS
4000  LDAY = NOWT - ISMYP
      WRITE(NW, 4003) NOWT, LDAY, NOWD, NOWY
4003  FORMAT(/////5X'BUILDING USE PERIODIC REPORT ON DAY='I4/5X,95(1H=)/10X'PREVIOUS REPORT WOULD HAVE BEEN DUE ON DAY'I4', TODAY IS DAY'I4' OF YEAR'I2)
      WRITE(NW, 4005) ISMYP
4005  FORMAT(/20X'(NO.TODAY)'10X'PERCENT OF MAXIMUM CAPACITY OVER'I4' DAYS')
      WRITE(NW, 4007)
4007  FORMAT(21X'-------- '68(1H-))
      WRITE(NW, 503)

C NURSERY
      CALL STATS(SUM4, 1, AVE, VAR, STD)
      RMIN = SUM4(4, 1)
      RMAX = SUM4(5, 1)
      WRITE(NW, 4011) NH(2), AVE, STD, RMIN, RMAX, MX2
4011  FORMAT(/10X'NURSERY      ('I3')='F10.2, 3F16.2/12X'CAPACITY='I4)

C FINISHING
      CALL STATS(SUM4, 2, AVE, VAR, STD)
      RMIN = SUM4(4,2)
      RMAX = SUM4(5,2)
      WRITE(NW, 4015) NH(4), AVE, STD, RMIN, RMAX, MX4
4015  FORMAT(10X'FINISHING    ('I3')='F10.2, 3F16.2/12X'CAPACITY='I4)

C MAINTENANCE
      CALL STATS(SUM4, 3, AVE, VAR, STD)
      RMIN = SUM4(4, 3)
      RMAX = SUM4(5, 3)
      WRITE(NW, 4021) NH(3), AVE, STD, RMIN, RMAX, MX3
4021  FORMAT(10X'MAINTENANCE  ('I3')='F10.2, 3F16.2/12X'CAPACITY='I4)

C FARROWING CRATES
      CALL STATS(SUM4, 4, AVE, VAR, STD)
      RMIN = SUM4(4, 4)
      RMAX = SUM4(5, 4)
      WRITE(NW, 4027) KL4, AVE, STD, RMIN, RMAX, MX1
4027  FORMAT(10X'FARROW CRATES('I3')='F10.2, 3F16.2/12X'CAPACITY='I4)
      WRITE(NW, 4029)
4029  FORMAT(5X'===END BUILDING USE REPORT'69(1H=))

C SET SUM4, 1-4 =ZERO
      DO 4031 I = 1,4
4031  CALL ZROSUM(SUM4, I)
      RETURN


C KW=5 PERIODIC BREEDING REPORT
C   SUM3() 7.8 USED FOR AGE AND LITTER SIZE.
C   NONBK() 1-3 ARE MAX REACHED, LACK BOARS, FAILS PROB.,
C       BUT 4 IS COUNTER FOR NO IN SEASON.
5000  CONTINUE
      WRITE(NW, 5501) NOWT, NOWD, NOWY
5501  FORMAT(///5X'PERIODIC BREEDING REPORT ON DAY='I4/5X, 95(1H=)/10X'TODAY IS DAY'I4' OF YEAR' I2)
      NB = SUM3(3, 7)
      WRITE(NW, 5509) NB
5509  FORMAT(/6X'BREEDINGS RESULTED IN'I8' CONCEPTIONS.')
      IF (NB) 5516, 5516, 5510
5510  WRITE(NW, 503)

C AGE OF SOW
      CALL STATS(SUM3, 7, AAG, VAR, SAG)
      AMN = SUM3(4, 7)
      AMX = SUM3(5, 7)
      WRITE(NW, 3511) AAG, SAG, AMN, AMX

C SIZE OF LITTERS
      CALL STATS(SUM3, 8, ALS, VAR, SLS)
      MN = SUM3(4, 8)
      MX = SUM3(5, 8)
      WRITE(NW, 3513) ALS, SLS, MN, MX
5516  ITO = 0
      DO 5517 I = 1,4
5517  ITO = ITO + NONBK(I)
      WRITE(NW, 1319) ITO, NONBK(1), NONBK(2), NONBK(3)
      WRITE(NW, 5519) NONBK(4)
5519  FORMAT(16X'SEASON CLOSED'26X'='I8)
      WRITE(NW, 5321)
5321  FORMAT(/5X'END PERIODIC BREEDING REPORT'67(1H=))
      DO 5329 I = 1,4
5329  NONBK(I) = 0
      CALL ZROSUM(SUM3, 7)
      CALL ZROSUM(SUM3, 8)
      RETURN


C PERIODIC FARROWING REPORT
C       KW=6, SUM3() WITH AS IN SEASONAL REPORT
6000  WRITE(NW, 6501) NOWT, NOWD, NOWY
6501  FORMAT(1H1, 5X'FARROWING PERIODIC REPORT ON DAY='I5/5X,95(1H=)/10X'TODAY IS DAY'I4' OF YEAR'I2)
      NL = SUM3(3, 1)
      WRITE(NW, 503)
      WRITE(NW, 505) NL

C LITTER SIZE
      IF(NL) 6533, 6533, 6505
6505  CALL STATS(SUM3, 1, ASIZ, VAR, SSIZ)
      MNSIZ = SUM3(4, 1)
      MXSIZ = SUM3(5, 1)
      WRITE(NW, 507) ASIZ, SSIZ, MNSIZ, MXSIZ

C CAPACITY
      CALL STATS(SUM3, 3, ACAP, VAR, SCAP)
      RNCAP = SUM3(4, 3)
      RXCAP = SUM3(5, 3)
      WRITE(NW, 511) ACAP, SCAP, RNCAP, RXCAP

C BIRTH WTS.
      CALL STATS(SUM3, 4, AWT, VAR, SWT)
      RNWT = SUM3(4, 4)
      RXWT = SUM3(5, 4)
      WRITE(NW, 513) AWT, SWT, RNWT, RXWT

C LOST LITTERS
6533  NL = SUM3(3, 5)
      WRITE(NW, 515) NL
      IF (NL) 620, 620, 616
616   CALL STATS(SUM3, 5, ALOS, VAR, SLOS)
      MNL = SUM3(4, 5)
      MXL = SUM3(5, 5)
      WRITE(NW, 517) ALOS, SLOS, MNL, MXL
620   NL = SUM3(3, 6)
      WRITE(NW, 521) NL
      IF (NL) 630, 630, 623
623   CALL STATS(SUM3, 6, ALOS, VAR, SLOS)
      MNL = SUM3(4, 6)
      MXL = SUM3(5, 6)
      WRITE(NW, 527) ALOS, SLOS, MNL, MXL
630   WRITE(NW, 631)
631   FORMAT(/6X'END PERIODIC FARROWING REPORT'65(1H=))
      DO 635 I = 1,6
      CALL ZROSUM(SUM3, I)
635   CONTINUE
      RETURN


C WEIGHT GAINS PERIODIC REPORT, END INVENTORY TAKEN HERE.
C
C       COMMON USED IS  4/GAIN2/...
7000  IF(ISMW .GT. 0) WRITE(NW, 7501) NOWT, NOWD, NOWY
7501  FORMAT(/////5X'WEIGHT GAINS PERIODIC REPORT ON DAY='I4/5X, 95(1H=)/10X'TODAY IS DAY'I4' OF YEAR' I2)

C CALCULATE AN ENDING INVENTORY WT., USE IT,  THEN
C       COPY IT TO OPENING AND ZERO THE COUNTERS OF
C       ARRAY (1)=NO., (2)=WT., (3)=VALUE
C
C SALES ARE ADDED IN SUB. SELL
C ORIGINAL OPENING INVENTORY FOUND IN SUB. OPEN.
      DO 7009 I = 1,ITOT
C MTP: DID SOME MULTIPLICATION TO AVOID TOO BIG OF AN INTEGER
      ICHK = IN(1, I) / (1000000000 * 10)
      IF(ICHK-240) 7001, 7005, 7005

C HOGS AND PIGS .LT. 240 DAYS OF AGE
7001  HEND(1) = HEND(1) + 1.0
      HEND(2) = HEND(2) + VEN(1, I)
      HEND(3) = HEND(3) + VEN(1, I) * PRIH / 100.0
      GO TO 7009

C SOWS AND BOARS OVER 240 DAYS OF AGE
7005  SEND(1) = SEND(1) + 1.0
      SEND(2) = SEND(2) + VEN(1, I)
      SEND(3) = SEND(3) + VEN(1, I) * PRIS / 100.0
7009  CONTINUE

C WT.= END INV. + SALES - OPENING INV.
C   HOGS LESS THAN 240 DAYS
      IF(ISMW) 7077, 7077, 7010
7010  NW1 = HEND(1) + HSLD(1) - HOP(1)
      W2 = HEND(2) + HSLD(2) - HOP(2)
      W3 = HEND(3) + HSLD(3) - HOP(3)
      WRITE(NW, 7011)
      WRITE(NW, 7013)
7011  FORMAT(/6X'PRODUCTION NET OF INVENTORY CHANGE-')
7013  FORMAT(/30X'-------NUMBER-------  ---WEIGHT LBS.----  ----VALUE DOL.----')
      WRITE(NW, 7015) NW1, W2, W3
7015  FORMAT(/10X'HOGS UNDER 240 DAYS ='I11, 2F20.1)

C SOWS I.E. OLDER THAN 239 DAYS OF AGE.
      NW1 = SEND(1) + SSLD(1) - SOP(1)
      W2 = SEND(2) + SSLD(2) - SOP(2)
      W3 = SEND(3) + SSLD(3) - SOP(3)
      WRITE(NW, 7017) NW1, W2, W3
7017  FORMAT(10X'SOWS(ALL 240 AND UP)='I11, 2F20.1)
      WRITE(NW, 7019)
7019  FORMAT(//6X'ENDING INVENTORY-')
      NNHEND = HEND(1)
      WRITE(NW, 7015) NHEND, HEND(2), HEND(3)
      NSEND = SEND(1)
      WRITE(NW, 7017) NSEND, SEND(2), SEND(3)
      WRITE(NW, 7021)
7021  FORMAT(/5X'END WEIGHT GAINS PERIODIC REPORT'63(1H=))


C CALL REPT2 FOR COSTS AND RETURNS SUMMARY.
C     COUNTERS ARE ZEROED THERE.
7077  CALL REPT2(IN, VEN)

      RETURN
      END
