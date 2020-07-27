create table tbl_student
(
    st_num	char(5)	PRIMARY KEY,
    st_name	nVARCHAR2(20) NOT NULL,	
    st_tel	char(20) NOT NULL,
    st_addr	nVARCHAR2(125),
    st_grade number	NOT NULL,	
    st_dcode char(3)	NOT NULL	
);

CREATE TABLE tbl_dept(
    d_code	number PRIMARY KEY,
    d_name	nvarchar2(10) NOT NULL	unique,
    d_prof	nvarchar2(10)
);

create table tbl_score
(
    sc_num char(5) NOT NULL	,
    sc_sub nVARCHAR2(20) NOT NULL,	
    sc_score number default 0
);


INSERT INTO tbl_student (st_num, st_name, st_tel, st_addr, st_grade, st_dcode) VALUES
                        ('20001','갈한수','010-2217-7851','경남 김해시 어방동 1088-7',3,'008');
                        
INSERT INTO tbl_student (st_num, st_name, st_tel, st_addr, st_grade, st_dcode) VALUES
                        ('20002','강이찬','010-4311-1533','강원도 속초시 대포동 956-5',1,'006');
                        
INSERT INTO tbl_student (st_num, st_name, st_tel, st_addr, st_grade, st_dcode) VALUES
                        ('20003','개원훈','010-6262-7441','경북 영천시 문외동 38-3번지',1,'009');
                        
INSERT INTO tbl_student (st_num, st_name, st_tel, st_addr, st_grade, st_dcode) VALUES
                        ('20004','경시현','010-9794-9856','서울시 구로구 구로동 3-35번지',1,'006');
                        
INSERT INTO tbl_student (st_num, st_name, st_tel, st_addr, st_grade, st_dcode) VALUES
                        ('20005','공동영','010-8811-7761','강원도 동해시 천곡동 1077-3',2,'010');
                        
INSERT INTO tbl_dept (d_code, d_name, d_prof) VALUES (001,'컴퓨터공학','토발즈');
INSERT INTO tbl_dept (d_code, d_name, d_prof) VALUES (002,'전자공학','이철기');
INSERT INTO tbl_dept (d_code, d_name, d_prof) VALUES (003,'법학','킹스필드');

INSERT INTO tbl_score (sc_num, sc_sub, sc_score) VALUES ('20001','데이터베이스',71);
INSERT INTO tbl_score (sc_num, sc_sub, sc_score) VALUES ('20001','수학',63);
INSERT INTO tbl_score (sc_num, sc_sub, sc_score) VALUES ('20001','미술',50);

INSERT INTO tbl_score (sc_num, sc_sub, sc_score) VALUES ('20002','데이터베이스',84);
INSERT INTO tbl_score (sc_num, sc_sub, sc_score) VALUES ('20002','음악',75);
INSERT INTO tbl_score (sc_num, sc_sub, sc_score) VALUES ('20002','국어',52);

INSERT INTO tbl_score (sc_num, sc_sub, sc_score) VALUES ('20003','수학',89);
INSERT INTO tbl_score (sc_num, sc_sub, sc_score) VALUES ('20003','영어',63);
INSERT INTO tbl_score (sc_num, sc_sub, sc_score) VALUES ('20003','국어',70);

select * from tbl_student;

select * from tbl_score
where sc_score < 60;

update tbl_student
set st_addr = '광주광역시 북구 중흥동 경양로 170번'
where st_name = '공동영';

DELETE FROM tbl_student
WHERE st_name = '개원훈';

drop table tbl_student;
drop table tbl_score;
drop table tbl_dept;

select * from tbl_student
    left join tbl_dept
        on st_dcode= D_code;

create view q4
as
(
SELECT sc_num,
       SUM(DECODE(SC.sc_sub,'국어',SC.sc_score,0)
       + DECODE(SC.sc_sub,'영어',SC.sc_score,0)
       + DECODE(SC.sc_sub,'수학',SC.sc_score,0)
       + DECODE(SC.sc_sub,'음악',SC.sc_score,0)
       + DECODE(SC.sc_sub,'미술',SC.sc_score,0)
       + DECODE(SC.sc_sub,'소프트웨어공학',SC.sc_score,0)
       + DECODE(SC.sc_sub,'데이터베이스',SC.sc_score,0)) AS 총점,

       round(SUM(DECODE(SC.sc_sub,'국어',SC.sc_score,0)
       + DECODE(SC.sc_sub,'영어',SC.sc_score,0)
       + DECODE(SC.sc_sub,'수학',SC.sc_score,0)
       + DECODE(SC.sc_sub,'음악',SC.sc_score,0)
       + DECODE(SC.sc_sub,'미술',SC.sc_score,0)
       + DECODE(SC.sc_sub,'소프트웨어공학',SC.sc_score,0)
       + DECODE(SC.sc_sub,'데이터베이스',SC.sc_score,0)) / 7 ,2) AS 평균
FROM tbl_score sc
GROUP BY sc_num
);

select st_num, st_name, st_tel, q.총점, q.평균
from tbl_student
    LEFT join q4 q
        on st_num = sc_num;
        
-- 5 - 1번문제
create view score_view
as
(
SELECT sc_num AS 학번, 국어, 영어, 수학, 음악, 미술, 소프트웨어공학, 데이터베이스,
        (국어 + 영어 + 수학 + 음악 + 미술 + 데이터베이스 + 소프트웨어공학) AS 총점,
        ROUND((국어 + 영어 + 수학 + 음악 + 미술 + 데이터베이스 + 소프트웨어공학)/7,2) AS 평균 
FROM
(
SELECT * FROM tbl_score sc
PIVOT(
SUM(sc_score)
FOR
sc_sub IN ('국어' AS 국어,'영어' AS 영어,'수학' AS 수학,'음악' AS 음악,
           '미술' AS 미술,'데이터베이스' AS 데이터베이스,
           '소프트웨어공학' AS 소프트웨어공학)
)
)
)
order by sc_num;

-- 5-1번 정답 뷰
select * from score_view;

-- 5-2번 시작부터 정답
select st_num AS 학번, st_name AS 이름, st_tel AS 전화번호, st_dcode AS 학과코드,
        국어, 영어, 수학, 음악, 미술, 소프트웨어공학, 데이터베이스, 총점, 평균
from tbl_student
    left join score_view
        on st_num = 학번;
        
-- 5-3 시작
create view view_stdt
as
(
select st_num AS 학번, st_name AS 이름, st_tel AS 전화번호, st_dcode AS 학과코드, d_name AS 학과명
from tbl_student
    left join tbl_dept
        on st_dcode = d_code
);


select * from view_stdt; --  여기에다가 아래처럼 조인

-- 5-3번 정답
select vsd.학번, vsd.이름, vsd.전화번호, vsd.학과코드, vsd.학과명, 국어, 영어, 수학, 음악, 미술, 소프트웨어공학, 데이터베이스, 총점, 평균
from view_stdt VSD
    left join score_view SCV
        on vsd.학번 = scv.학번;