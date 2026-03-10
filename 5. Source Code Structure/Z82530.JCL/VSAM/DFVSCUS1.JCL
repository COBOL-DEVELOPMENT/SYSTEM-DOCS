/* ------------------------------------------------------------------
//* FILE NAME: DFVSCUS1, KSDS Cluster Definition for CUSTOMER. 03/09/26
//* ------------------------------------------------------------------
//* This is CUSTOMER Definition to create a KSDS cluster using IDCAMS.
//* The first step is to delete the existing cluster if it exists, and 
//* then define a new cluster with the specified parameters.
//* The second step (commented out) is to copy data from an existing 
//* dataset to the newly created KSDS cluster using the REPRO command.
//* ------------------------------------------------------------------      
//DFVSCUS1   JOB (1),'KSDS',CLASS=A,MSGCLASS=X,NOTIFY=&SYSUID
//S1   EXEC PGM=IDCAMS
//SYSPRINT  DD SYSOUT=*
//SYSIN     DD *,SYMBOLS=CNVTSYS
  DELETE Z82530.T0.CUSTOMER.KSDS CLUSTER
  SET MAXCC=0
 DEFINE CLUSTER -
 (NAME(Z82530.T0.CUSTOMER.KSDS) -
  INDEXED -
  KEYS(19 0) -
  RECORDSIZE(407 407) -
  CYLINDERS(1 1) - 
 DATA (NAME(Z82530.T0.CUSTOMER.KSDS.DATA)) -
 INDEX(NAME(Z82530.T0.CUSTOMER.KSDS.INDEX))
/*
//* /S2   EXEC PGM=IDCAMS
//* //SYSPRINT  DD SYSOUT=*
//* //I1        DD DISP=SHR,DSN=&SYSUID..DATA
//* //O1        DD DISP=SHR,DSN=&SYSUID..T0.CUSTOMER.KSDS
//* //SYSIN     DD *
//*   REPRO INFILE(I1) OUTFILE(O1)
//* /*

