      DIMENSION RR(10)

      OPEN(NEWUNIT=NR, FILE="NR.txt", STATUS="OLD", ACTION="READ")

      READ(NR, *) RR
      WRITE(ND, *) RR

      STOP
      END