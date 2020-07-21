--------------------------------------------------------
--  파일이 생성됨 - 화요일-7월-21-2020   
--------------------------------------------------------
USE myDB;
-- 만약 tbl_dept가 있으면 삭제하라.
DROP TABLE IF EXISTS tbl_dept;

CREATE TABLE IF NOT EXISTS tbl_dept(
	d_code CHAR(4) primary key,
	d_name VARCHAR(30) NOT NULL,
	d_prof VARCHAR(30)
);
Insert into TBL_DEPT (D_CODE,D_NAME,D_PROF) values ('D001','관광정보학','홍길동');
Insert into TBL_DEPT (D_CODE,D_NAME,D_PROF) values ('D002','국어국문','이몽룡');
Insert into TBL_DEPT (D_CODE,D_NAME,D_PROF) values ('D003','법학','성춘향');
Insert into TBL_DEPT (D_CODE,D_NAME,D_PROF) values ('D004','전자공학','임꺽정');
Insert into TBL_DEPT (D_CODE,D_NAME,D_PROF) values ('D005','컴퓨터공학','장영실');
Insert into TBL_DEPT (D_CODE,D_NAME,D_PROF) values ('D006','무역학','장길산');
SELECT * FROM tbl_dept;