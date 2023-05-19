gfortran -ffixed-line-length-0 -g -w -c BREED.F -o build/BREED.o
gfortran -ffixed-line-length-0 -g -w -c CLEAN4.F -o build/CLEAN4.o
gfortran -ffixed-line-length-0 -g -w -c COLLECT.F -o build/COLLECT.o
gfortran -ffixed-line-length-0 -g -w -c EVNTS.F -o build/EVNTS.o
gfortran -ffixed-line-length-0 -g -w -c FAROW.F -o build/FAROW.o
gfortran -ffixed-line-length-0 -g -w -c FILEM.F -o build/FILEM.o
gfortran -ffixed-line-length-0 -g -w -c FIND.F -o build/FIND.o
gfortran -ffixed-line-length-0 -g -w -c INITN.F -o build/INITN.o
gfortran -ffixed-line-length-0 -g -w -c MGT.F -o build/MGT.o
gfortran -ffixed-line-length-0 -g -w -c MGT2.F -o build/MGT2.o
gfortran -ffixed-line-length-0 -g -w -c MGT3.F -o build/MGT3.o
gfortran -ffixed-line-length-0 -g -w -c OPEN_NDAT.F -o build/OPEN_NDAT.o
gfortran -ffixed-line-length-0 -g -w -c OUT.F -o build/OUT.o
gfortran -ffixed-line-length-0 -g -w -c RANUM.F -o build/RANUM.o
gfortran -ffixed-line-length-0 -g -w -c REMOV.F -o build/REMOV.o
gfortran -ffixed-line-length-0 -g -w -c REPT1.F -o build/REPT1.o
gfortran -ffixed-line-length-0 -g -w -c REPT2.F -o build/REPT2.o
gfortran -ffixed-line-length-0 -g -w -c RNORM.F -o build/RNORM.o
gfortran -ffixed-line-length-0 -g -w -c SELECT.F -o build/SELECT.o
gfortran -ffixed-line-length-0 -g -w -c SELL.F -o build/SELL.o
gfortran -ffixed-line-length-0 -g -w -c STATS.F -o build/STATS.o
gfortran -ffixed-line-length-0 -g -w -c UPDATE.F -o build/UPDATE.o
gfortran -ffixed-line-length-0 -g -w -c ZROSUM.F -o build/ZROSUM.o

gfortran -ffixed-line-length-0 -g EXECUT.F \
build/BREED.o \
build/CLEAN4.o \
build/COLLECT.o \
build/EVNTS.o \
build/FAROW.o \
build/FILEM.o \
build/FIND.o \
build/INITN.o \
build/MGT.o \
build/MGT2.o \
build/MGT3.o \
build/OPEN_NDAT.o \
build/OUT.o \
build/RANUM.o \
build/REMOV.o \
build/REPT1.o \
build/REPT2.o \
build/RNORM.o \
build/SELECT.o \
build/SELL.o \
build/STATS.o \
build/UPDATE.o \
build/ZROSUM.o \
-o build/cyberpig_1973