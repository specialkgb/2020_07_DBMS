create tablespace grade2Ts
datafile 'C:/bizwork/workspace/oracle-data/grade2Ts.dbf'
SIZE 1M AUTOEXTEND ON NEXT 1K;

CREATE USER grade2 IDENTIFIED BY grade2
DEFAULT TABLESPACE grade2TS;

grant dba to grade2;

