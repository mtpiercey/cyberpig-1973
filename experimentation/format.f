C THE OLDEN WAY:
C     9138  WRITE(ND,9136) NOWT
C     9136  FORMAT(5X*BREEDING SEASON ON DAY=*I5*, NO BOARS EXIST,*
C          2* SOW RETURNED OPEN*)


C THE NEW WAY:
C   - Using -ffixed-line-length-0 with gfortran
C   - Using single quotes instead of * for strings
C   - Likely need to WRITE to * (stdout) instead of a "tape"

      NOWT = 123
      WRITE(*,9136) NOWT
9136  FORMAT(/5X'BREEDING SEASON ON DAY='I5', NO BOARS EXIST, SOW RETURNED OPEN')
      END


