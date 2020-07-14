-- Comment : 한줄 주석

/*
    여러줄 주석
    SQL 명령을 입력할 때 명령이 끝났다라는 것을 알리기 위해서 ; 붙여준다
    
    Ctrl + Enter : 현재 커서가 있는 곳의 명령문을 DBMS로 보내고 결과를 받기
    
*/
-- 현재 오라클에 접속된 사용자(sys)가 관리하는 table들이 있는데
-- 그중에서 tab이라는 이름의 table정보를 가져와서 나에게 보여달라
-- 오라클의 tab table은 현재 접속된 사용자가 관리하는 DB Object(객체)들의 
-- 정보를 보관하고 있는 table
SELECT *
FROM tab;

-- ALL_ALL_TABLES : 오라클 system 데이터 사전의 자세한 정보를 보관하는 table
SELECT *
FROM all_all_tables;

-- SELECT 키워드는 FROM 절을 포함하는 명령문 형태로 작성을하며
-- DBMS가 보관하고 있는 데이터를 table형식으로 보여달라 라는 명령
-- DBMS의 DML(Database Manupulation Lang)중에서
--      Read(조회)를 수행하는 명령
--      CRUD 중에서 R: Read, Retrive 명령을 수행하는 명령문
SELECT *
FROM 주소록;

-- SQL 명령문을 통해서 DB 객체를 만들고 삭제하고, 데이터를 추가, 변경, 삭제를 수행할텐데
-- sys 사용자로 접속을 하게 되면 중요한 정보를 잘못 삭제, 변경할 우려가 있기 때문에
-- 실습을 위해서 사용자를 생성하여 수행을 할 것이다.

-- 사용자를 추가하는 순서
-- 1. table space : 데이터를 저장할 물리적 공간을 설정
-- 2. user : 사용자를 생성하고, 물리적 저장공간과 연결

-- TableSpace 생성(Create)
-- TableSpace는 오라클에서 Data를 저장할 물리적 공간을 설정하는 것
-- myTS : 앞으로 SQL을 통해서 사용할 TableSpace의 Alias(이름)
-- '.../myTS.dbf' : 저장할 파일 이름
-- Size : 오라클에서는 성능의 효율성을 주기위해 
--        일단 빈 공간을 일정부분 설정하게 된다.
--        크기는 최초에 저장할 데이터의 크기등을 계산하여 설계하고 설정한다.
--        너무 작으면 효율성이 떨어지고 너무 크면 불필요한 공간을 낭비한다.
-- AUTO..NEXT : 만약 초기에 지정한 Size공간에 데이터가 가득하면
--              자동으로 용량을 늘려서 저장할 수 있도록 만들어라.
-- Size의 1M : 기본크기를 1024 * 1024 byte 크기로 지정하라.
--             Size를 지정할 때 1MB라고 하지 않는다
-- Next 500K : 자동으로 확장(늘리기)를 1024 * 500 크기로 설정
--             Next를 지정할 때 500KB라고 하지 않는다.
CREATE TABLESPACE myTS
DATAFILE 'C:/bizwork/workspace/oracle-data/myTS.dbf'
SIZE 1M AUTOEXTEND ON NEXT 500K;

-- 질의작성기에서 코드를 작성할 때 약속
-- DBMS의 SQL문은 특별한 일부 경우를 제외하고 대소문자 구별을 하지 않는다
-- DBMS, SQL, 오라클과 관련된 키워드는 모두 대문자로 작성할 것
-- 변수, 값, 내용 등은 소문자로 사용하며
-- 특별히 대소문자를 구분해야하는 경우는 별도로 공지를 할 것