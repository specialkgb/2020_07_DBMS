-- 여기는 관리자 화면

CREATE TABLESPACE blogTS
datafile 'C:/bizwork/oracle_dbms/blog.dbf'
size 1m autoextend on next 1k;

-- user1 사용자 생성
create user user1 identified by user1
default tablespace blogTs;

-- user1 권한 부여
grant dba to user1;