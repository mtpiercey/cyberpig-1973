      SUBROUTINE REPT2(IN, VEN)
      
      COMMON /INIT/ NR, NW, ND, NT7, NT8, NDAT, NS1, NS2, NOWD
      COMMON /STAT/ SUM(5, 20), SUM2(5, 10), SUM3(5, 10), SUM4(5, 10), SUM5(5, 10)
      COMMON /GEN/ ITOT, ISIZE, NOWT, NOWY, NDAYS, NRUNS, IATRIB(18), ATRIB(4)
      COMMON /HOUSE/ NH(6), N1, N2, N3, N4, N5, N6, NXFAR, MX2, MX3, MX4
      COMMON /SALES/ D(15), PRIH, PRIS
      COMMON /COST/ FCS, FCB, CLAB, TFAR, TNUR, TSOW, TFIN, VAR(3), COST(30)
      COMMON /RPT1/ ISMYP
      COMMON /RPT2/ ISMYC, ISMCS, ISMCH, ISML, ISMSS, ISMSH, ISMGR
      COMMON /GAIN2/ SOP(6), HOP(6), SSLD(6), HSLD(6), SEND(6), HEND(6)

C MTP: NOTICED NXFAR IN THE HOUSE UP THERE, THAT'S USUALLY NXTFAR

      DIMENSION IN(3, 1), VEN(2, 1)

C COST AND RETURNS SUMMARY REPORT
C       COLLECTED IN SUB. MGT3, CALLED FROM REPT1 PERIODICALLY.
C       GAINS ARRAY ZEROED HERE.
C COST() 1=T. SOW DAYS, 2=FARROW BLD. MINUTES, 3=NURSERY BLD. MIN.,
C        4=MAINT. BLD + CULL MIN., 5= FINISHING BLD. MIN.

      IF(ISMYC) 898, 898, 801
801   WRITE(NW,803) NOWT, NOWD, NOWY, ISMYP
803   FORMAT(1H1, 5X 'COSTS AND RETURNS PERIODIC REPORT ON DAY='I4/5X,95(1H=)/10X' TODAY IS DAY'I4' OF YEAR'I2'    PERIOD COVERED='I5' DAYS')

C FEED COST SOWS C1
      C1 = COST(1) * FCS
      IF(ISMCS) 8200, 8200, 8100
8100  WRITE(NW, 8105) C1, FCS
8105  FORMAT(/10X'FEED COSTS SOWS='F8.2' DOL. AT'F4.2' PER DAY PER SOW')

C FEED COST PER 100 LBS. HOGS PRODUCED.
8200  G = (HEND(2) + HSLD(2) - HOP(2)) / 100.0
      CH = G * FCB
      IF(ISMCH) 8300, 8300, 8201
8201  WRITE(NW, 8205) CH, FCB
8205  FORMAT(/10X'FEED COSTS HOGS='F8.2' DOL. AT'F6.2' PER 100 LBS. PRODUCED')

C LABOUR COSTS BY BLD.
8300  C2 = COST(2) / 60.0 * CLAB
      IF(ISML) 8400, 8400, 8301
8301  WRITE(NW, 8305) CLAB, C2
8305  FORMAT(/6X'LABOUR COSTS BY BUILDING INCLUDING CULL PEN AT'F5.2' DOL. PER HOUR'/10X'FARROWING='F20.2)
8400  C3 = COST(3) / 60.0 * CLAB
      C4 = COST(4) / 60.0 * CLAB
      C5 = COST(5) / 60.0 * CLAB
      WRITE(NW, 8309) C3, C4, C5
8309  FORMAT(10X'NURSERY='F22.2/10X'SOWS MAINT. +CULLS='F11.2/10X'FINISHING='F20.2)

C VALUE PRODUCED
      S2 = (SEND(2) + SSLD(2) - SOP(2)) / 100.0
      VS2 = S2 * PRIS
      IF(ISMSS) 8500, 8500, 8401
8401  WRITE(NW, 8405) S2, VS2
8405  FORMAT(/6X'SOWS PRODUCED='F12.1' CWT.    AT VALUE OF'F14.2' DOL.')
8500  H2 = (HEND(2) + HSLD(2) - HOP(2)) / 100.0
      VH2 = H2 * PRIH
      IF(ISMSH) 8600, 8600, 8501
8501  WRITE(NW, 8505) H2, VH2
8505  FORMAT(/6X'HOGS PRODUCED='F12.1' CWT.    AT VALUE OF'F14.2' DOL.')

C COSTS AND RETURNS NUTSHELL SUMMARY.
C       USE ABOVE CALCULATIONS FOR TABLE
8600  IF(ISMGR) 8650, 8650, 8601
8601  WRITE(NW, 8603) ISMYP, NOWD, NOWY
8603  FORMAT(///5X'COSTS AND RETURNS SUMMARY OVER A'I5' DAY PERIOD.'/10X'TODAY IS DAY'I4' OF YEAR'I2)
      WRITE(NW, 8605)
8605  FORMAT(/41X'-------SOWS-------  -------HOGS-------  ----TOTAL HERD----'/32X, 3(17X, 3H($)))
      TV2 = VS2 + VH2
      WRITE(NW, 8611) VS2, VH2, TV2
8611  FORMAT(44X'(1)'/10X'PRODUCTION NET OF INVENTORY CHANGE'F9.2, 2F20.2)
      TCF = C1 + CH
      WRITE(NW, 8617) C1, CH, TCF
8617  FORMAT(19X'(2)'/10X'FEED COST'14X, 3F20.2)
      C24 = C2 + C4
      C35 = C3 + C5
      TCL = C24 + C35
      WRITE(NW, 8621) C24, C35, TCL
8621  FORMAT(20X'(3)'/10X'LABOUR COST'13X, 3F20.2)
      RS = VS2 - C1 - C2 - C4
      RH = VH2 - CH - C3 - C5
      GR = TV2 - TCF - TCL
      WRITE(NW, 8631) RS, RH, GR
8631  FORMAT(/10X'RETURN OVER FEED AND LABOUR'F17.2, 2F20.2)
      WRITE(NW, 8641)
8641  FORMAT(6X, 93(1H-) /6X'(1) SOWS INCLUDE ANIMALS 240 DAYS OF AGE AND OVER, OTHERWISE THEY WHERE CLASSED AS HOGS AND PIGS.'/6X'(2) FEED COST FOR SOWS BASED ON DAYS OF MAINTENANCE (INC. CULL PEN) AND LACTATION.'/6X'(3) LABOUR COST BASED ON BUILDING OCCUPANCY, ALL FARROWING HOUSE LABOUR WAS ASSIGNED TO SOWS.')
8650  WRITE(NW, 8651)
8651  FORMAT(5X'===END COSTS AND RETURNS SUMMARIES'61(1H=))

C ZERO COST ARRAY
898   DO 8801 I=1,5
8801  COST(I) = 0.0

C ZERO GAIN ARRAYS.
      DO 899 I=1,3
      HOP(I) = 0.0
      SOP(I) = 0.0
      HSLD(I) = 0.0
      SSLD(I) = 0.0
      HOP(I) = HEND(I)
      SOP(I) = SEND(I)
      HEND(I) = 0.0
899   SEND(I) = 0.0

      RETURN
      END