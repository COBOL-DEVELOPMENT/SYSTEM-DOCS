```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. MGTCRUDCICS.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01  WS-RESP                    PIC S9(8) COMP VALUE 0.
       01  WS-RESP2                   PIC S9(8) COMP VALUE 0.

       01  WS-MESSAGE                 PIC X(70) VALUE SPACES.
       01  WS-EXIT-SW                 PIC X VALUE 'N'.

       01  WS-SCREEN-DATA.
           05 SCR-FUNCTION            PIC X.
           05 SCR-EMP-ID              PIC X(10).
           05 SCR-FIRSTNAME           PIC X(50).
           05 SCR-LASTNAME            PIC X(50).
           05 SCR-DEPARTMENT          PIC X(50).
           05 SCR-JOBTITLE            PIC X(50).
           05 SCR-HIREDATE            PIC X(10).
           05 SCR-SALARY-IN           PIC X(9).
           05 SCR-CONFIRM             PIC X.

       01  WS-EMPLOYEE-REC.
           05 EMP-ID                  PIC X(10).
           05 EMP-FIRSTNAME           PIC X(50).
           05 EMP-LASTNAME            PIC X(50).
           05 EMP-DEPARTMENT          PIC X(50).
           05 EMP-JOBTITLE            PIC X(50).
           05 EMP-HIREDATE            PIC X(10).
           05 EMP-SALARY              PIC 9(9).

       01  WS-SALARY                  PIC 9(9) VALUE 0.

       01  WS-DATE-CHECK.
           05 WS-YYYY                 PIC X(4).
           05 WS-DASH1                PIC X(1).
           05 WS-MM                   PIC X(2).
           05 WS-DASH2                PIC X(1).
           05 WS-DD                   PIC X(2).

       01  WS-CAREA.
           05 CA-STEP                 PIC X(2).
           05 CA-FUNCTION             PIC X.
           05 CA-EMP-ID               PIC X(10).
           05 CA-FIRSTNAME            PIC X(50).
           05 CA-LASTNAME             PIC X(50).
           05 CA-DEPARTMENT           PIC X(50).
           05 CA-JOBTITLE             PIC X(50).
           05 CA-HIREDATE             PIC X(10).
           05 CA-SALARY               PIC 9(9).
           05 CA-MESSAGE              PIC X(70).

       01  WS-COMMAREA-LEN            PIC S9(4) COMP VALUE 254.

       COPY DFHAID.
       COPY DFHBMSCA.
       COPY EMPSET.

       LINKAGE SECTION.
       01  DFHCOMMAREA.
           05 LK-CA-STEP              PIC X(2).
           05 LK-CA-FUNCTION          PIC X.
           05 LK-CA-EMP-ID            PIC X(10).
           05 LK-CA-FIRSTNAME         PIC X(50).
           05 LK-CA-LASTNAME          PIC X(50).
           05 LK-CA-DEPARTMENT        PIC X(50).
           05 LK-CA-JOBTITLE          PIC X(50).
           05 LK-CA-HIREDATE          PIC X(10).
           05 LK-CA-SALARY            PIC 9(9).
           05 LK-CA-MESSAGE           PIC X(70).

       PROCEDURE DIVISION.
       MAIN-PARA.

           EXEC CICS HANDLE AID
                CLEAR(EXIT-RTN)
                PF3(EXIT-RTN)
           END-EXEC

           IF EIBCALEN = 0
               PERFORM INIT-COMMAREA
               MOVE '01' TO CA-STEP
               MOVE 'ENTER FUNCTION A/I/U/D.' TO CA-MESSAGE
               PERFORM SEND-MAIN-SCREEN
               PERFORM RETURN-WITH-COMMAREA
           END-IF

           PERFORM LOAD-COMMAREA

           EVALUATE CA-STEP
               WHEN '01'
                   PERFORM RECEIVE-MAIN-SCREEN
                   PERFORM PROCESS-FIRST-REQUEST
               WHEN 'U1'
                   PERFORM RECEIVE-MAIN-SCREEN
                   PERFORM PROCESS-UPDATE-CONFIRM
               WHEN 'D1'
                   PERFORM RECEIVE-DELETE-SCREEN
                   PERFORM PROCESS-DELETE-CONFIRM
               WHEN OTHER
                   PERFORM INIT-COMMAREA
                   MOVE 'INVALID SESSION STATE.' TO CA-MESSAGE
                   MOVE '01' TO CA-STEP
                   PERFORM SEND-MAIN-SCREEN
                   PERFORM RETURN-WITH-COMMAREA
           END-EVALUATE

           PERFORM RETURN-WITH-COMMAREA.

       INIT-COMMAREA.
           MOVE SPACES TO WS-CAREA
                          WS-SCREEN-DATA
                          WS-EMPLOYEE-REC
                          WS-MESSAGE
           MOVE 0      TO WS-SALARY
                          CA-SALARY.

       LOAD-COMMAREA.
           MOVE DFHCOMMAREA TO WS-CAREA.

       SAVE-COMMAREA.
           MOVE WS-CAREA TO DFHCOMMAREA.

       RETURN-WITH-COMMAREA.
           PERFORM SAVE-COMMAREA
           EXEC CICS RETURN
                TRANSID('EMPC')
                COMMAREA(DFHCOMMAREA)
                LENGTH(WS-COMMAREA-LEN)
           END-EXEC.

       EXIT-RTN.
           EXEC CICS RETURN END-EXEC.

       RECEIVE-MAIN-SCREEN.
           MOVE SPACES TO WS-SCREEN-DATA
           EXEC CICS RECEIVE
                MAP('EMPMAP1')
                MAPSET('EMPSET')
                INTO(EMPMAP1I)
                RESP(WS-RESP)
                RESP2(WS-RESP2)
           END-EXEC

           IF WS-RESP = DFHRESP(MAPFAIL)
               MOVE 'INPUT REQUIRED.' TO CA-MESSAGE
               MOVE '01' TO CA-STEP
               PERFORM SEND-MAIN-SCREEN
               PERFORM RETURN-WITH-COMMAREA
           END-IF

           PERFORM GET-MAP1-INPUT.

       RECEIVE-DELETE-SCREEN.
           MOVE SPACES TO WS-SCREEN-DATA
           EXEC CICS RECEIVE
                MAP('EMPMAP2')
                MAPSET('EMPSET')
                INTO(EMPMAP2I)
                RESP(WS-RESP)
                RESP2(WS-RESP2)
           END-EXEC

           IF WS-RESP = DFHRESP(MAPFAIL)
               MOVE 'CONFIRM INPUT REQUIRED.' TO CA-MESSAGE
               MOVE 'D1' TO CA-STEP
               PERFORM SEND-DELETE-SCREEN
               PERFORM RETURN-WITH-COMMAREA
           END-IF

           PERFORM GET-MAP2-INPUT.

       GET-MAP1-INPUT.
           MOVE M1FUNCI TO SCR-FUNCTION
           MOVE M1EIDI  TO SCR-EMP-ID
           MOVE M1FNI   TO SCR-FIRSTNAME
           MOVE M1LNI   TO SCR-LASTNAME
           MOVE M1DPI   TO SCR-DEPARTMENT
           MOVE M1JTI   TO SCR-JOBTITLE
           MOVE M1HDI   TO SCR-HIREDATE
           MOVE M1SLI   TO SCR-SALARY-IN

           INSPECT SCR-FUNCTION REPLACING ALL LOW-VALUES BY SPACES
           INSPECT SCR-EMP-ID REPLACING ALL LOW-VALUES BY SPACES
           INSPECT SCR-FIRSTNAME REPLACING ALL LOW-VALUES BY SPACES
           INSPECT SCR-LASTNAME REPLACING ALL LOW-VALUES BY SPACES
           INSPECT SCR-DEPARTMENT REPLACING ALL LOW-VALUES BY SPACES
           INSPECT SCR-JOBTITLE REPLACING ALL LOW-VALUES BY SPACES
           INSPECT SCR-HIREDATE REPLACING ALL LOW-VALUES BY SPACES
           INSPECT SCR-SALARY-IN REPLACING ALL LOW-VALUES BY SPACES.

       GET-MAP2-INPUT.
           MOVE M2CFMI TO SCR-CONFIRM
           INSPECT SCR-CONFIRM REPLACING ALL LOW-VALUES BY SPACES.

       PROCESS-FIRST-REQUEST.
           MOVE SPACES TO CA-MESSAGE
           INSPECT SCR-FUNCTION CONVERTING 'aiud' TO 'AIUD'

           EVALUATE SCR-FUNCTION
               WHEN 'A'
                   PERFORM PREPARE-SCREEN-TO-REC
                   PERFORM ADD-EMPLOYEE
                   MOVE '01' TO CA-STEP
                   PERFORM SEND-MAIN-SCREEN

               WHEN 'I'
                   MOVE SCR-EMP-ID TO EMP-ID
                   PERFORM INQUIRE-EMPLOYEE
                   MOVE '01' TO CA-STEP
                   PERFORM SEND-MAIN-SCREEN

               WHEN 'U'
                   MOVE SCR-EMP-ID TO EMP-ID
                   PERFORM FETCH-FOR-UPDATE
                   IF CA-MESSAGE = SPACES
                       MOVE 'U1' TO CA-STEP
                   ELSE
                       MOVE '01' TO CA-STEP
                   END-IF
                   PERFORM SEND-MAIN-SCREEN

               WHEN 'D'
                   MOVE SCR-EMP-ID TO EMP-ID
                   PERFORM FETCH-FOR-DELETE
                   IF CA-MESSAGE = SPACES
                       MOVE 'D1' TO CA-STEP
                       PERFORM SEND-DELETE-SCREEN
                   ELSE
                       MOVE '01' TO CA-STEP
                       PERFORM SEND-MAIN-SCREEN
                   END-IF

               WHEN OTHER
                   MOVE 'INVALID FUNCTION. USE A/I/U/D.' TO CA-MESSAGE
                   MOVE '01' TO CA-STEP
                   PERFORM SEND-MAIN-SCREEN
           END-EVALUATE.

       PROCESS-UPDATE-CONFIRM.
           PERFORM PREPARE-SCREEN-TO-REC
           PERFORM UPDATE-EMPLOYEE
           MOVE '01' TO CA-STEP
           PERFORM SEND-MAIN-SCREEN.

       PROCESS-DELETE-CONFIRM.
           INSPECT SCR-CONFIRM CONVERTING 'yn' TO 'YN'

           IF SCR-CONFIRM = 'Y'
               MOVE CA-EMP-ID TO EMP-ID
               PERFORM DELETE-EMPLOYEE
           ELSE
               MOVE 'DELETE CANCELLED.' TO CA-MESSAGE
           END-IF

           MOVE '01' TO CA-STEP
           PERFORM SEND-MAIN-SCREEN.

       PREPARE-SCREEN-TO-REC.
           MOVE SCR-EMP-ID      TO EMP-ID
           MOVE SCR-FIRSTNAME   TO EMP-FIRSTNAME
           MOVE SCR-LASTNAME    TO EMP-LASTNAME
           MOVE SCR-DEPARTMENT  TO EMP-DEPARTMENT
           MOVE SCR-JOBTITLE    TO EMP-JOBTITLE
           MOVE SCR-HIREDATE    TO EMP-HIREDATE

           IF SCR-SALARY-IN NUMERIC
               MOVE SCR-SALARY-IN TO EMP-SALARY
           ELSE
               MOVE 0 TO EMP-SALARY
           END-IF.

       VALIDATE-INPUT.
           MOVE SPACES TO CA-MESSAGE

           IF EMP-ID = SPACES
               MOVE 'EMPLOYEE ID IS REQUIRED.' TO CA-MESSAGE
               EXIT PARAGRAPH
           END-IF

           IF EMP-LASTNAME = SPACES
               MOVE 'LAST NAME IS REQUIRED.' TO CA-MESSAGE
               EXIT PARAGRAPH
           END-IF

           IF EMP-HIREDATE = SPACES
               MOVE 'HIRE DATE IS REQUIRED.' TO CA-MESSAGE
               EXIT PARAGRAPH
           END-IF

           MOVE EMP-HIREDATE TO WS-DATE-CHECK
           IF WS-DASH1 NOT = '-' OR WS-DASH2 NOT = '-'
               MOVE 'HIRE DATE FORMAT MUST BE YYYY-MM-DD.' TO CA-MESSAGE
               EXIT PARAGRAPH
           END-IF

           IF WS-YYYY NOT NUMERIC OR
              WS-MM   NOT NUMERIC OR
              WS-DD   NOT NUMERIC
               MOVE 'HIRE DATE MUST BE NUMERIC YYYY-MM-DD.' TO CA-MESSAGE
               EXIT PARAGRAPH
           END-IF

           IF SCR-SALARY-IN = SPACES
               MOVE 'SALARY IS REQUIRED.' TO CA-MESSAGE
               EXIT PARAGRAPH
           END-IF

           IF SCR-SALARY-IN NOT NUMERIC
               MOVE 'SALARY MUST BE NUMERIC.' TO CA-MESSAGE
               EXIT PARAGRAPH
           END-IF

           IF EMP-SALARY <= 0
               MOVE 'SALARY MUST BE GREATER THAN ZERO.' TO CA-MESSAGE
               EXIT PARAGRAPH
           END-IF.

       ADD-EMPLOYEE.
           PERFORM VALIDATE-INPUT
           IF CA-MESSAGE NOT = SPACES
               EXIT PARAGRAPH
           END-IF

           EXEC CICS READ
                FILE('EMPFILE')
                INTO(WS-EMPLOYEE-REC)
                RIDFLD(EMP-ID)
                RESP(WS-RESP)
                RESP2(WS-RESP2)
           END-EXEC

           IF WS-RESP = DFHRESP(NORMAL)
               MOVE 'EMPLOYEE ID ALREADY EXISTS.' TO CA-MESSAGE
               EXIT PARAGRAPH
           END-IF

           IF WS-RESP NOT = DFHRESP(NOTFND)
               MOVE 'READ ERROR DURING ADD.' TO CA-MESSAGE
               EXIT PARAGRAPH
           END-IF

           EXEC CICS WRITE
                FILE('EMPFILE')
                FROM(WS-EMPLOYEE-REC)
                RIDFLD(EMP-ID)
                RESP(WS-RESP)
                RESP2(WS-RESP2)
           END-EXEC

           IF WS-RESP = DFHRESP(NORMAL)
               MOVE 'ADD SUCCESS.' TO CA-MESSAGE
               PERFORM MOVE-REC-TO-CA
           ELSE
               MOVE 'ADD FAILED.' TO CA-MESSAGE
           END-IF.

       INQUIRE-EMPLOYEE.
           MOVE SPACES TO CA-MESSAGE

           IF EMP-ID = SPACES
               MOVE 'EMPLOYEE ID IS REQUIRED.' TO CA-MESSAGE
               EXIT PARAGRAPH
           END-IF

           EXEC CICS READ
                FILE('EMPFILE')
                INTO(WS-EMPLOYEE-REC)
                RIDFLD(EMP-ID)
                RESP(WS-RESP)
                RESP2(WS-RESP2)
           END-EXEC

           IF WS-RESP = DFHRESP(NORMAL)
               MOVE 'INQUIRE SUCCESS.' TO CA-MESSAGE
               PERFORM MOVE-REC-TO-CA
           ELSE
               MOVE 'EMPLOYEE NOT FOUND.' TO CA-MESSAGE
               PERFORM CLEAR-CA-DATA
               MOVE EMP-ID TO CA-EMP-ID
           END-IF.

       FETCH-FOR-UPDATE.
           MOVE SPACES TO CA-MESSAGE

           IF EMP-ID = SPACES
               MOVE 'EMPLOYEE ID IS REQUIRED.' TO CA-MESSAGE
               EXIT PARAGRAPH
           END-IF

           EXEC CICS READ
                FILE('EMPFILE')
                INTO(WS-EMPLOYEE-REC)
                RIDFLD(EMP-ID)
                UPDATE
                RESP(WS-RESP)
                RESP2(WS-RESP2)
           END-EXEC

           IF WS-RESP = DFHRESP(NORMAL)
               MOVE 'UPDATE MODE. CHANGE DATA AND PRESS ENTER.'
                 TO CA-MESSAGE
               PERFORM MOVE-REC-TO-CA
           ELSE
               MOVE 'EMPLOYEE NOT FOUND FOR UPDATE.' TO CA-MESSAGE
           END-IF.

       UPDATE-EMPLOYEE.
           PERFORM VALIDATE-INPUT
           IF CA-MESSAGE NOT = SPACES
               EXIT PARAGRAPH
           END-IF

           MOVE EMP-ID TO CA-EMP-ID

           EXEC CICS READ
                FILE('EMPFILE')
                INTO(WS-EMPLOYEE-REC)
                RIDFLD(EMP-ID)
                UPDATE
                RESP(WS-RESP)
                RESP2(WS-RESP2)
           END-EXEC

           IF WS-RESP NOT = DFHRESP(NORMAL)
               MOVE 'EMPLOYEE NOT FOUND FOR UPDATE.' TO CA-MESSAGE
               EXIT PARAGRAPH
           END-IF

           MOVE SCR-FIRSTNAME  TO EMP-FIRSTNAME
           MOVE SCR-LASTNAME   TO EMP-LASTNAME
           MOVE SCR-DEPARTMENT TO EMP-DEPARTMENT
           MOVE SCR-JOBTITLE   TO EMP-JOBTITLE
           MOVE SCR-HIREDATE   TO EMP-HIREDATE
           MOVE EMP-SALARY     TO EMP-SALARY

           EXEC CICS REWRITE
                FILE('EMPFILE')
                FROM(WS-EMPLOYEE-REC)
                RESP(WS-RESP)
                RESP2(WS-RESP2)
           END-EXEC

           IF WS-RESP = DFHRESP(NORMAL)
               MOVE 'UPDATE SUCCESS.' TO CA-MESSAGE
               PERFORM MOVE-REC-TO-CA
           ELSE
               MOVE 'UPDATE FAILED.' TO CA-MESSAGE
           END-IF.

       FETCH-FOR-DELETE.
           MOVE SPACES TO CA-MESSAGE

           IF EMP-ID = SPACES
               MOVE 'EMPLOYEE ID IS REQUIRED.' TO CA-MESSAGE
               EXIT PARAGRAPH
           END-IF

           EXEC CICS READ
                FILE('EMPFILE')
                INTO(WS-EMPLOYEE-REC)
                RIDFLD(EMP-ID)
                RESP(WS-RESP)
                RESP2(WS-RESP2)
           END-EXEC

           IF WS-RESP = DFHRESP(NORMAL)
               MOVE 'CONFIRM DELETE. ENTER Y OR N.' TO CA-MESSAGE
               PERFORM MOVE-REC-TO-CA
           ELSE
               MOVE 'EMPLOYEE NOT FOUND FOR DELETE.' TO CA-MESSAGE
           END-IF.

       DELETE-EMPLOYEE.
           EXEC CICS DELETE
                FILE('EMPFILE')
                RIDFLD(EMP-ID)
                RESP(WS-RESP)
                RESP2(WS-RESP2)
           END-EXEC

           IF WS-RESP = DFHRESP(NORMAL)
               MOVE 'DELETE SUCCESS.' TO CA-MESSAGE
               PERFORM CLEAR-CA-DATA
               MOVE SPACES TO CA-EMP-ID
           ELSE
               MOVE 'DELETE FAILED.' TO CA-MESSAGE
           END-IF.

       MOVE-REC-TO-CA.
           MOVE EMP-ID         TO CA-EMP-ID
           MOVE EMP-FIRSTNAME  TO CA-FIRSTNAME
           MOVE EMP-LASTNAME   TO CA-LASTNAME
           MOVE EMP-DEPARTMENT TO CA-DEPARTMENT
           MOVE EMP-JOBTITLE   TO CA-JOBTITLE
           MOVE EMP-HIREDATE   TO CA-HIREDATE
           MOVE EMP-SALARY     TO CA-SALARY.

       CLEAR-CA-DATA.
           MOVE SPACES TO CA-FIRSTNAME
                          CA-LASTNAME
                          CA-DEPARTMENT
                          CA-JOBTITLE
                          CA-HIREDATE
           MOVE 0      TO CA-SALARY.

       SEND-MAIN-SCREEN.
           MOVE CA-MESSAGE    TO M1MSGO
           MOVE CA-FUNCTION   TO M1FUNCO
           MOVE CA-EMP-ID     TO M1EIDO
           MOVE CA-FIRSTNAME  TO M1FNO
           MOVE CA-LASTNAME   TO M1LNO
           MOVE CA-DEPARTMENT TO M1DPO
           MOVE CA-JOBTITLE   TO M1JTO
           MOVE CA-HIREDATE   TO M1HDO
           MOVE CA-SALARY     TO M1SLO

           MOVE -1 TO M1FUNCIL

           EXEC CICS SEND
                MAP('EMPMAP1')
                MAPSET('EMPSET')
                FROM(EMPMAP1O)
                ERASE
                CURSOR
           END-EXEC.

       SEND-DELETE-SCREEN.
           MOVE CA-MESSAGE    TO M2MSGO
           MOVE CA-EMP-ID     TO M2EIDO
           MOVE CA-FIRSTNAME  TO M2FNO
           MOVE CA-LASTNAME   TO M2LNO
           MOVE CA-DEPARTMENT TO M2DPO
           MOVE CA-JOBTITLE   TO M2JTO
           MOVE CA-HIREDATE   TO M2HDO
           MOVE CA-SALARY     TO M2SLO

           MOVE -1 TO M2CFMIL

           EXEC CICS SEND
                MAP('EMPMAP2')
                MAPSET('EMPSET')
                FROM(EMPMAP2O)
                ERASE
                CURSOR
           END-EXEC.
```
