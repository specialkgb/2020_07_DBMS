-- 여기는 user1 화면

create table tbl_blogs(
bl_seq	NUMBER primary key,
bl_user	nVARCHAR2(20)	not null,
bl_date	VARCHAR2(10)	not null,
bl_time	VARCHAR2(10)	not null,
bl_title	nVARCHAR2(125)	not null,
bl_contents	nVARCHAR2(2000)	not null
);

-- 일련번호 생성
create sequence seq_blog
start with 1 increment by 1;

/*
SQL Developer와 기타 다른 다른 프로그래밍 프로젝트와 연동을 할 때
SQL Developer에서 insert, update, delte를 수행했음에도 불구하고
프로젝트에서 조회되는 데이터에 반영이 안되는 경우가 있다

원인
SQL Developer에서 CUD(insert, update, delete)를 수행하면
실제 로컬스토리지의 data 직접 적용이 안된다.
변경한 데이터는 메모리 기억장소에 저장되어 있을 뿐이다.

프로그래밍 프로젝트에서 반영된 결과를 가져다 사용하려면
commit 명령을 수행해 주어야 한다.
*/
insert into tbl_blogs(bl_seq, bl_user, bl_date, bl_time, bl_title, bl_contents)
values(seq_blog.nextval, '홍길동','2020-08-14','09:47:00','나의 블로그','블로그를 만들자');

insert into tbl_blogs(bl_seq, bl_user, bl_date, bl_time, bl_title, bl_contents)
values(seq_blog.nextval, '이몽룡','2020-08-14','09:47:01','블로그 축하','블로그개설을 축하합니다');

insert into tbl_blogs(bl_seq, bl_user, bl_date, bl_time, bl_title, bl_contents)
values(seq_blog.nextval, '성춘향','2020-08-14','09:47:02','블로그 축하','블로그개설을 축하합니다 :) ');

select * from tbl_blogs;

select * from tbl_blogs
 		order by bl_date desc, bl_time desc;

commit;