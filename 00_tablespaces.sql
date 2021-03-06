-- "Set define off" turns off substitution variables
Set define off;

CREATE TABLESPACE UFE_USE DATAFILE 
  '/ufe/datafiles/use.dbf' SIZE 10M REUSE AUTOEXTEND ON NEXT 10M MAXSIZE 200M
LOGGING
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;

CREATE TABLESPACE UFE_LOGVW DATAFILE 
  '/ufe/datafiles/logvw.dbf' SIZE 10M REUSE AUTOEXTEND ON NEXT 10M MAXSIZE 200M
LOGGING
EXTENT MANAGEMENT LOCAL AUTOALLOCATE
BLOCKSIZE 8K
SEGMENT SPACE MANAGEMENT AUTO
FLASHBACK ON;
