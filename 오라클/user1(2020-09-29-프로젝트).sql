-- user1 개인프로젝트

drop table tbl_iolist;
create table tbl_iolist (
        
        io_pcode        NUMBER(5)       primary key,
        io_pname	    nVARCHAR2(30),
        io_date	        VARCHAR2(10)	    not null	,
        io_time	        VARCHAR2(10)	    not null	,
        io_input	    CHAR(1)	not null,
        io_price        NUMBER  DEFAULT 0,
        io_oprice	    NUMBER	default '0',
        io_quan	        NUMBER	default '0',
        io_total	    NUMBER	default '0'


);

CREATE SEQUENCE seq_iolist
START WITH 1 INCREMENT BY 1;

INSERT INTO tbl_iolist (io_pcode, io_pname, io_date, io_time, io_input, io_price, io_oprice, io_quan, io_total)
values (00001, '우레폭풍','2020-09-29','15:33:33','1', 1000, 2000, 5, 0);

INSERT INTO tbl_iolist (io_pcode, io_pname, io_date, io_time, io_input, io_price, io_oprice, io_quan, io_total)
values (00002, '용아비수','2020-09-28','14:32:32','0', 2000, 4000, 1, 0);

INSERT INTO tbl_iolist (io_pcode, io_pname, io_date, io_time, io_input, io_price, io_oprice, io_quan, io_total)
values (00003, '죽음인도자','2020-09-27','12:11:12','1', 3000, 5000, 2, 0);

commit;