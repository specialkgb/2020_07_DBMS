-- USER1

create table tbl_images (
i_seq	NUMBER		PRIMARY KEY,
i_bseq	NUMBER	NOT NULL	,
i_org_name	nVARCHAR2(255)	NOT NULL	,
i_file_name	nVARCHAR2(255)	NOT NULL	,
i_down	NUMBER		
);

drop table tbl_images;

create sequence seq_images
start with 1 increment by 1;

select seq_bbs.nextval from dual;

select * from tbl_images;