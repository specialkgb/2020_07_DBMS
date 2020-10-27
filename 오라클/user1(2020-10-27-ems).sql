-- ems

CREATE TABLE tbl_ems (
id	NUMBER		PRIMARY KEY,
from_email	nVARCHAR2(30)	NOT NULL	,
to_email	nVARCHAR2(30)	NOT NULL	,
s_date	nVARCHAR2(10)	NOT NULL	,
s_time	nVARCHAR2(10)		,
s_subject	nVARCHAR2(125)	,	
s_content	nVARCHAR2(2000)	,	
s_file1	nVARCHAR2(125)		,
s_file2	nVARCHAR2(125)		
);

create sequence SEQ_EMS
start with 1 increment by 1;

select * from tbl_ems;


create table tbl_eimages (
i_seq	NUMBER		PRIMARY KEY,
i_eseq	NUMBER	NOT NULL	,
i_org_name	nVARCHAR2(255)	NOT NULL	,
i_file_name	nVARCHAR2(255)	NOT NULL	
);

drop table tbl_images;

create sequence seq_eimages
start with 1 increment by 1;

select SEQ_EMS.nextval from dual;

select * from tbl_eimages;