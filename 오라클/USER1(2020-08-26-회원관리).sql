-- User1 화면

create table tbl_member (
    M_USERID	nVARCHAR2(50)		PRIMARY KEY,
    M_PASSWORD	VARCHAR2(125)	not null	,
    M_NAME	nVARCHAR2(30)	not null	,
    M_TEL	VARCHAR2(20)		,
    M_ADDRESS	nVARCHAR2(255)	,	
    M_ROLL	VARCHAR2(20)		

);

select * from tbl_member;