-- 시험 공부 입니다.

CREATE TABLE test_student(
        st_num  NUMBER(5) PRIMARY KEY,
        st_name nVARCHAR2(20) NOT NULL,
        st_tel  VARCHAR2(20),
        st_addr nVARCHAR2(125),
        st_grade NUMBER(1) NOT NULL,
        st_dcode NUMBER(3),
        st_dept nVARCHAR2(10),
        st_prof nVARCHAR2(20)
);

SELECT * FROM test_student;

CREATE TABLE test_dept(
        d_code  NUMBER(3),
        d_name  nVARCHAR2(10),
        d_prof  nVARCHAR2(10)
);

create table test_score(
    sc_num number(5) not null,
    sc_sub nVARCHAR2(20) not null,
    sc_score number(3) default 0
    );

drop table test_score;



create table test_sub(
    s_code char(3),
    s_sub nVARCHAR2(20)
);
drop table test_sub;

INSERT INTO test_sub (s_sub, s_code) VALUES ('국어','S01');
INSERT INTO test_sub (s_sub, s_code) VALUES ('영어','S02');
INSERT INTO test_sub (s_sub, s_code) VALUES ('수학','S03');
INSERT INTO test_sub (s_sub, s_code) VALUES ('음악','S04');
INSERT INTO test_sub (s_sub, s_code) VALUES ('미술','S05');
INSERT INTO test_sub (s_sub, s_code) VALUES ('데이터베이스','S06');
INSERT INTO test_sub (s_sub, s_code) VALUES ('소프트웨어공학','S07');

SELECT *
FROM test_student -- 큰거
     left JOIN test_nscore -- 작은거
        ON st_dcode = nsc_dcode
        order by st_num;
        
SELECT *
FROM test_student -- 큰거
     left JOIN test_nscore -- 작은거
        ON st_num = nsc_num
        order by st_num;
        
Update test_score
SET sc_scode = 'S01'
WHERE sc_sub = '국어';
rollback;

--Update test_score
--SET sc_scode = 'S02'
--WHERE sc_sub = '영어';
--
--Update test_score
--SET sc_scode = 'S03'
--WHERE sc_sub = '수학';
--
--Update test_score
--SET sc_scode = 'S04'
--WHERE sc_sub = '음악';
--
--Update test_score
--SET sc_scode = 'S05'
--WHERE sc_sub = '미술';
--
--Update test_score
--SET sc_scode = 'S06'
--WHERE sc_sub = '데이터베이스';
--commit;
--Update test_score
--SET sc_scode = 'S07'
--WHERE sc_sub = '소프트웨어공학';

UPDATE test_score
SET sc_scode =
(
    SELECT s_code
    FROM test_sub
    WHERE s_sub = sc_sub
);

ALTER TABLE test_score ADD sc_scode CHAR(3);
----------------------------------------------------------------------------------------------------

select st_num, st_name,
       국어,영어, 수학, 음악, 미술, 데이터베이스, 소프트웨어공학,
       (국어+영어+수학+음악+미술+데이터베이스+소프트웨어공학) AS 총점,
       round((국어+영어+수학+음악+미술+데이터베이스+소프트웨어공학) / 7,2) AS 평균
from
(
select * from test_score SC
    LEFT JOIN test_student ST
        on st.st_num = sc.sc_num
)
pivot(
sum(sc_score)
for
sc_sub in ('국어' AS 국어, '영어' AS 영어, '수학' AS 수학, '음악' AS 음악,
            '미술' AS 미술, '데이터베이스' AS 데이터베이스, '소프트웨어공학' AS 소프트웨어공학)
)
order by sc_num;

-----------------------------------------------------------------------------------------------------

SELECT sc.sc_num,
        (국어 + 영어 + 수학 + 음악 + 미술 + 데이터베이스 + 소프트웨어공학) AS 총점,
        ROUND((국어 + 영어 + 수학 + 음악 + 미술 + 데이터베이스 + 소프트웨어공학)/7,2) AS 평균 
FROM
(
SELECT * FROM test_score
PIVOT(
SUM(sc_score)
FOR
sc_sub IN ('국어' AS 국어,'영어' AS 영어,'수학' AS 수학,'음악' AS 음악,
           '미술' AS 미술,'데이터베이스' AS 데이터베이스,
           '소프트웨어공학' AS 소프트웨어공학)
)
) SC
LEFT JOIN test_student ST
    ON SC.sc_num = ST.st_num
order by sc_num;
----------------------------------------------------------------------------------------------------
select * from test_score
order by sc_num;
SELECT ST.st_num,
       SUM(DECoDE(SC.sc_sub,'국어',SC.sc_score,0)) AS 국어, -- 객체의 이름(인스턴스), method의 name이자, 가상 칼럼 명을 표시
       SUM(DECODE(SC.sc_sub,'영어',SC.sc_score,0)) AS 영어,
       SUM(DECODE(SC.sc_sub,'수학',SC.sc_score,0)) AS 수학,
       SUM(DECODE(SC.sc_sub,'음악',SC.sc_score,0)) AS 음악,
       SUM(DECODE(SC.sc_sub,'미술',SC.sc_score,0)) AS 미술,
       SUM(DECODE(SC.sc_sub,'소프트웨어공학',SC.sc_score,0)) AS 소프트웨어공학,
       SUM(DECODE(SC.sc_sub,'데이터베이스',SC.sc_score,0)) AS 데이터베이스,
       
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
FROM test_student ST -- 1-1번
    LEFT JOIN test_score SC --1-2번
        ON ST.st_num = SC.sc_num -- 1-3번
GROUP BY ST.st_num, st.st_name-- 2번
ORDER BY st_num;

    

create table test_nscore
(
    nsc_num char(5) primary key,
    nsc_dcode char(3) not null,
    nsc_kor number(3) default 0,
    nsc_eng number(3) default 0,
    nsc_math number(3) default 0,
    nsc_music number(3) default 0,
    nsc_art number(3) default 0,
    nsc_soft number(3) default 0,
    nsc_db number(3) default 0
);

 -- ST_num와 nsc_num를 비교해서 같으면
 -- nsc_dcode를 st_dcode에 업데이트하라

UPDATE test_student ST
SET st_dcode =
(
    SELECT nsc_dcode
    FROM test_nscore NS
    WHERE st.st_num = ns.nsc_num
);


-- 업데이트된 student 테이블의 dcode와 dname, dprof가 매칭되지 않는다.
-- student 테이블의 dcode를 기준으로 dname, dprof를 업데이트하자.


-- 최신화 된 student의 dcode와 dept테이블의 d_code를 비교해서
-- 일치하면 dept테이블에서 학과명을 가져와 student테이블의 학과명에 넣고
UPDATE test_student ST
SET st_dept =
(
    SELECT dt.d_name
    FROM test_dept DT
    WHERE st.st_dcode = dt.d_code
);

-- 최신화 된 student의 dcode와 dept테이블의 d_code를 비교해서
-- 일치하면 dept테이블에서 교수명을 가져와 student테이블의 교수명에 넣는다
UPDATE test_student ST
set st_prof =
(
    select dt.d_prof
    from test_dept DT
    where st.st_dcode = dt.d_code
);

select *
from test_student;

update test_view
set nsc_dcode = '008'
where nsc_dcode = 11;

ROLLBACK;
commit;

select * 
from test_student ST
    left join test_score SC
        on st.st_num = sc.sc_num
            order by st.st_num;

-- 최신 성적을 제외한 모든 정보의 업데이트가 끝났다.
-- 이제 학번과 학과코드를 primary key로 설정해서 과목별로 업데이트를 수행한 후
-- 총점과 평균을 계산해서 출력하고 끝내자.

select * from test_nscore;
select sc_num, sc_sub, sc_score from test_score
Order by sc_num;

SELECT nsc_num, nsc_dcode, sc_sub, test_nscore
FROM 
test_nscore
UNPIVOT
(
test_nscore
FOR
(sc_sub) IN (nsc_kor AS '국어', nsc_eng AS '영어', nsc_math as '수학', nsc_music as '음악', nsc_art as '미술', nsc_soft as '소프트웨어', nsc_db as '데이터베이스')
);

drop view nscore_view;


-- 성적테이블_칼럼 시트 unPivot view 생성
CREATE VIEW nscore_view
AS
(
SELECT nsc_num, sc_sub, test_nscore
FROM 
test_nscore
UNPIVOT
(
test_nscore
FOR
(sc_sub) IN (nsc_kor AS '국어', nsc_eng AS '영어', nsc_math as '수학', nsc_music as '음악', nsc_art as '미술', nsc_soft as '소프트웨어공학', nsc_db as '데이터베이스')
)
);

select * from decode_view; -- decode로 만든 view

select * from nscore_view; -- 성적테이블 칼럼의 unpivot view
select * from pivot_view;

-- 정규화1 시트 view 생성
create view pivot_view
as
(
SELECT sc_num,
        (국어 + 영어 + 수학 + 음악 + 미술 + 데이터베이스 + 소프트웨어공학) AS 총점,
        ROUND((국어 + 영어 + 수학 + 음악 + 미술 + 데이터베이스 + 소프트웨어공학)/7,2) AS 평균 
FROM
(
SELECT * FROM test_score
PIVOT(
SUM(sc_score)
FOR
sc_sub IN ('국어' AS 국어,'영어' AS 영어,'수학' AS 수학,'음악' AS 음악,
           '미술' AS 미술,'데이터베이스' AS 데이터베이스,
           '소프트웨어' AS 소프트웨어)
)
)
);

-- 제 1정규화 점수를 성적테이블_칼럼 시트의 점수들로 업데이트하기
update test_score TS
set ts.sc_score =
(
    select nv.test_nscore
    from nscore_view NV
    where ts.sc_num = NV.nsc_num and ts.sc_sub = nv.sc_sub
);

-- 출력부
select st_num, st_name, st_dept,
       국어,영어, 수학, 음악, 미술, 데이터베이스, 소프트웨어공학,
       (국어+영어+수학+음악+미술+데이터베이스+소프트웨어공학) AS 총점,
       round((국어+영어+수학+음악+미술+데이터베이스+소프트웨어공학) / 7,2) AS 평균
from
(
select * from test_score SC
    LEFT JOIN test_student ST
        on st.st_num = sc.sc_num
)
pivot(
sum(sc_score)
for
sc_sub in ('국어' AS 국어, '영어' AS 영어, '수학' AS 수학, '음악' AS 음악,
            '미술' AS 미술, '데이터베이스' AS 데이터베이스, '소프트웨어공학' AS 소프트웨어공학)
)
order by sc_num;

commit;