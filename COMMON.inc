C MTP: THIS MESSY "GLOBAL" COMMON FILE WAS MY ATTEMPT AT GETTING ALL THE COMMONS INTO ONE PLACE
C IT AT LEAST ALLOWED THE PROGRAM TO COMPILE, BUT I MUST HAVE BEEN MISSING SOMETHING, BECAUSE
C IT DIDN'T SOLVE THE INFINITE LOOP ISSUE

C COMMON/INIT/NR,NW,DUMY,NT7,NT8,NDAT,NS1,NS2,NOWD (IN OUT, BUT RENAMED LOCAL ND TO ND1 IN OUT)
      COMMON/INIT/NR, NW, ND, NT7, NT8, NDAT, NS1, NS2, NOWD

C MTP: RRN(54) HERE, BECAUSE USED IN RANUM, BUT REFERENCES TO IRN(54) THROUGHOUT OTHER COMMON BLOCKS
      COMMON/RAN/RRN(54), KRANUM, RLIMIT, NRNOPT, ITAPE

      COMMON/STAT/SUM1(5,20), SUM2(5,10), SUM3(5,10), SUM4(5,10), SUM5(5,10)

      COMMON/GEN/ITOT, ISIZE, NOWT, NOWY, NDAYS, NRUNS, IATRIB(18), ATRIB(4)

      COMMON/HOUSE/NH(6), N1, N2, N3, N4, N5, N6, NXTFAR, MX1, MX2, MX3, MX4, X1, X2, X4

      COMMON/SALES/MDSELL, WTS, NXTSAL, NSLD(4), WTSLD(4), VSLD(4), PRIH, PRIS

      COMMON/SALE2/NSLDP(4), WTSLDP(4), VSLDP(4), DIS

      COMMON/SCH/KS(2,500), IPT, IEVT, KODE, IWE, IWN(45), NKT

      COMMON/CULL/NGLTS, MXSRV, MXAGS, PCULG, PCULS, PSSR, PRGT, MXBOR, LDP

      COMMON/SKIP/ISTOP4, ISTOP5, ISTOP6, ISTOP7, MAXSKP

      COMMON/SURVIV/PW1, PW23, PSRT, PSFIN, PSOWS, PBORS, PBORS1, MDEAD(8), PSRT2

      COMMON/BIRTH/BRNM, BRNS, BMIN, BMAX, BWTM, BWTS, BWMIN, BWMAX, NOBRN

C MTP: HAD TO ADD IFAR2(30) TO THE END HERE; USED IN EVNTS AND FAROW
      COMMON/BRED/LBREED, NBREED, IFAR(6,5), IDB(30), KAGEW, LGTHW, NAGEM, IFAR2(30)

      COMMON/BRED2/ABNORG, GESM, GESS, GMIN, GMAX, ESTM, ESTS, EMIN, EMAX

      COMMON/BRED3/PTRM1, PTRM2, PTRM16, PCON1, PCON2, ADJ1, ADJ2

      COMMON/BRED4/KBRD, KSWGT(4), NONB(4), NONBK(4)

      COMMON/CLEAN/NDPREV, NH4CLN, LOSSL, SWTLP, SSLP, KL4

      COMMON/BOAR/MXSDY, MXSWY, MXSDM, MXSWM, NPUR, IPDAT, KAGE, WTPB, IBS

      COMMON/MG3/NHH(6), MDEADH(8), NHP(6), MDP(6), KCALL, KPRET, KNSLD4, KPREP

      COMMON/KRS/KRS1, KRS2, KRS3, KRS4, KRS5, KRS6, KRS7, KPRT

      COMMON/RPT1/ISMYP, ISMB, ISMBG, ISMF, ISMW, ISMS, ISMM

      COMMON/RPT2/ISMYC, ISMCS, ISMCH, ISML, ISMSS, ISMSH, ISMGR

      COMMON/RPT3/MJEV, ISALS, IFARS, IBRDS

      COMMON/RPT4/IDCS, IDCE, IDCN, IDCF, IDCM, IDCB, IDCFS, IDCFP, IOFLW

      COMMON/RPT5/IAAS, IAAE, IAAN, IAAFN, IAAM, IAAB, IAAFR

C MTP: SELL SAYS IT WANTS THIS, PROB NOT NECESSARY:
C 3 /COST/FCS,FCB,CLAB,TFAR,TNUR,TSOW,TFIN
C 4  ,VAR(3),FEED(2,5),ABOR(2,10)

      COMMON/COST/FCS, FCB, CLAB, TFAR, TNUR, TSOW, TFIN, VAR(3), COST(30)

      COMMON/WRT1/KW

      COMMON/GAIN/GW1, GW23, GSRT, GFIN1, GFIN2, GSOWM, GSOWL, SDP, SSOWM, SSOWL

      COMMON/GAIN2/SOP(6), HOP(6), SSLD(6), HSLD(6), SEND(6), HEND(6)