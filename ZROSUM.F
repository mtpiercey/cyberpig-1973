      SUBROUTINE ZROSUM(COLLECTOR, INDEX)
C**************************************************************************STATPK
C                   ZROSUM(COLLECTOR, INDEX)                   - INITIATION
C                   COLLECT(COLLECTOR, INDEX, X)               - COLLECTION
C                   STATS(COLLECTOR, INDEX, AVE, VAR, STD)     - CALCULATION
C
C   EACH COLUMN -INDEX- WILL HANDLE STATISTICS FOR ONE VARIABLE.
C   DECLARE AN ACTUAL ARRAY LIKE -COLLECTOR()- IN THE CALL PROGRAM TO (5, J) 
C         WHERE     5 IS ABSOLUTE
C                   J = MAXIMUM NUMBER OF VARIABLES FOR COLLECTION.
C
C   INITIATE BY CALLING ZROSUM(COLLECTOR, INDEX) WITH INDEX = 1, 2,...
C   FOR THE FIRST, SECOND, ETC. VARIABLE TO BE INITIATED.
C
C   CALL COLLECT(COLLECTOR, INDEX, X) TO COLLECT THE OBSERVATION -X-.
C   CALL STATS(COLLECTOR, INDEX, AVE, VAR, STD) FOR CALCULATION OF AVE, VAR, STD.
C 
C   MIN, MAX, SUM X'S, SUM SQS, AND NO. OBS ARE IN -COLLECTOR()- ANYTIME.
C********************************************************************************

      DIMENSION COLLECTOR(5, 1)

      COLLECTOR(1, INDEX) = 0.0
      COLLECTOR(2, INDEX) = 0.0
      COLLECTOR(3, INDEX) = 0.0
      COLLECTOR(4, INDEX) = 1.0E25
      COLLECTOR(5, INDEX) = -1.0E25

      RETURN
      END
