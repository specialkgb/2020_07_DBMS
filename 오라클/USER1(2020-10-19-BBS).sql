-- BBS 프로젝트
CREATE TABLE tbl_bbs (
    b_seq	NUMBER		PRIMARY KEY,
    b_date	VARCHAR2(10)	NOT NULL	,
    b_time	VARCHAR2(10)	NOT NULL	,
    b_writer	nVARCHAR2(30)	NOT NULL,	
    b_subject	nVARCHAR2(125)	NOT NULL,	
    b_content	nVARCHAR2(2000)	NOT NULL,	
    b_count	NUMBER		,
    b_file	nVARCHAR2(125)		

);

create sequence SEQ_BBS
start with 1 increment by 1;