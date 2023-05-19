# Cyberpig 1973

This project aims to resurrect a FORTRAN IV swine farm simulator from 1973.

Why attempt such a thing? No reason, and many reasons (to gain practical context on the development of programming languages,
to partly relive what it was like to program back then, in honour of its original author, as an effort of software preservation, for fun?).

This program was originally developed by Jay Loren Strom, PhD (February 1, 1937 - October 23, 2020). It was included as part of his
PhD dissertation in Agricultural Economics (from Purdue University) in 1973.

The author of this preservation project, Matthew Piercey, unfortunately only found out about this program while reading 
[Jay's obituary](https://www.tributearchive.com/obituaries/18729054/Jay-Strom) in early 2021. What he wouldn't have given to have found about it sooner.
But through a series of strange events, and undoubtedly due to a sense of boredom/frustration brought on by the pandemic, Matthew decided
to take on the effort of attempting to make this program run again.

The original program was written on a CDC 6500 mainframe

## Current Status

The program **compiles**! This was a major breakthrough, that required a lot of research, troubleshooting, and experimentation. But technically, while it
most certainly doesn't conform to any modern specification (although let's face it, it never did), `gfortran` will compile it into a static binary!

However, this project is not out of the woods, yet, because it's **currently stuck in an infinite loop** when running. The loop appears to be limited to
limited to the `EVNTS` and `MGT2`. The potential causes for this probably come down to an issue with the `COMMON` statements, some of which do not seem to
make much sense. Typos and input data problems have likely been ruled out, but are not impossible culprits.

It would have been great to have this program up and properly running in time for its 50th anniversary (May 2023), but at least it is up on GitHub in a more
modern, future-proof state, and is now much less likely to be completely lost to time.

## Changes from Original

- Changed SUM in stat functions to COLLECTOR, and JVARBL to INDEX
- Changed SUM in STAT common to SUM1 to avoid conflict with built-in
- Renamed OPEN to OPEN_NDAT to avoid conflict with built-in
- Retrofitted CDC FORTRAN IV built-ins like DATE and RANF
- Retrofitted CDC FORTRAN IV quirks like true/false if statement and EOF-based if statement
- Got around integer size limitations by multiplying by powers of ten
- Commented out a few lines that did not appear to do anything necessary, but were bugging the compiler
- Removed references to IDENT ("free-form identification card number") that was only cosmetic and that the compiler didn't like
- Removed a few seemingly unnecessary line labels
- Modified FORMAT strings, replacing asterisks with quotes
- Turned into a proper VS Code project with GDB-based step-through debugging and a compilation script
- Using the `-ffixed-line-length-0` flag with `gfortran` allowed me to remove "continuation lines"
- Add input data (`NR.txt` and `NDAT.txt`) to regular text files

- Added "MTP:" comments wherever I noticed something weird, or had to make a change

## Documentation Folder

- `Simulation of a Swine Breeding Herd - Jay Loren Strom.pdf` (original dissertation) 
- `OCR.pdf` (original dissertation, with OCR)
- `FORTRAN Program.pdf` (just the program and its input data)
- `OCR - FORTRAN Program.pdf` (just the program and its input data, with OCR)
  - Also has *PDF bookmarks* so you can easily 
- `CDC FORTRAN Manual.pdf` (Downloaded from <http://bitsavers.trailing-edge.com/pdf/cdc/cyber/lang/fortran/60305600A_FTN_Extd_V4_Oct71.pdf>)
- `OCR - CDC FORTRAN MANUAL.pdf` (The OCR on this wasn't bad, because it was a well-scanned, printed documented to begin with)
  - Very helpful for identifying certain quirks of CDC FORTRAN IV that `gfortran` didn't know what to do with
  - See also <https://wiki.livingcomputers.org/doku.php?id=cdc6500_survival_guide>
  - As an aside, the Living Computers Museum + Labs has Purdue's CDC 6500 - *the* machine used to write this program - in their collection (unfortunately the future of the museum appears to be in doubt)
- `input_data.ods` (the LibreOffice spreadsheet used to enter the input data before putting it in `NR.txt` and `NDAT.txt`)

- *Note the the OCR quality on the dissertation is dubious - especially on the code - because this is an old scan of a microfilm of a typewritten document from the '70s*

- Special thanks to [Bitsavers](http://www.bitsavers.org/) and the [livingcomputers.org wiki](https://wiki.livingcomputers.org/doku.php?id=start)

## Input Data Files

- NDAT.txt
- NR.txt

## Compilation

- Run `./compile.sh`
- The binary will be created at `build/cyberpig_1973`
- The binary must be launched as `build/cyberpig_1973` from the root of the repository, because it depends on `NR.txt` and `NDAT.txt`
- Unfortunately it's currently stuck in an infinite loop, but at least it all seems to compile

## Output Data Files

- fort.13 (input data checking, error log)
- fort.60 (should be the main output file, but currently isn't written to because of the infinite loop)
  - Commenting out the call to `EVNTS` in `MGT` at least allows the program to finish and print its log
  - Although most of the actual simulation logic is skipped over, when `EVNTS` is not called
- fort.130 (main debug file, although format is effectively indecipherable)

## Things that didn't fix the infinite loop

- Attempted change from IFAR2(30) to IFAR(30) with common to IDB(30)
- Attempted change from SUM1 back to SUM

## Tapes

- READ
  - NR (INITN)     - 2  (READ)
  - NR5 (INITN)    - 5
  - NDAT (OPEN)    - 15 (BASE HERD DATA TYPE)
  - ITAPE (RANUM)  - 50 (RANDOM NUMBERS)

- WRITE
  - ND (BREED, CLEAN4. EVNTS, FAROW, FILEM, FIND, INITN, MGT2, MGT3, REMOV, REPT1, SELECT, UPDATE) - 13 (DIAGNOSTIC)
  - ND1 (OUT) - 13 (SAME AS ND)
  - NT7 (CLEAN4, INITN, OUT) - 13 (MAY SET TO 8 FOR JUNKING VIA CARD 56)
  - NW (FILEM, INITN, MGT, REPT1, REPT2)   - 6 (WRITE)
  - IJK (SELL)