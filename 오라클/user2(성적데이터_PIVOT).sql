-- 여기는 user2 화면입니다.

CREATE table tbl_성적(
    학번 char(5),
    과목명 nvarchar2(20),
    점수 number
);

select * from tbl_성적;

-- 표준 sql 이용한 pivot
-- 1. 어떤 칼럼을 기준칼럼으로 할 것인가 : 학번 칼럼을 기준으로 삼는다.
-- 2. 어떤 칼럼을 group by로 설정을 하게 되면 나지 칼럼은
--    통계함수로 감싸거나, 아니면 group by에 칼럼을 포함해 주어야 한다.

-- 3. 점수를 sum 함수를 묶어주는 이유와 결과
-- 4. 학번을 group by로 묶어서 여러개로 저장된 학번을 1개만 보이도록 하기 위해
--    계산되는 각 과목의 점수를 sum() 묶어준다.
--    현재 테이블 구조에서 한번 + 과목의 점수는 전체 데이터에서 1개의 레코드만 존재한다.
--    따라서 sum()함수는 무언가 합산을 하는 용도가 아니라, 단순히 group by를 사용할 수 있도록 하는 용도일 뿐이다.
select 학번,
    sum(case when 과목명 = '국어' then 점수 else 0 end) as 국어, -- sum을 쓰는 용도는 group by를 할 수 있게 해주는 용도
    sum(case when 과목명 = '영어' then 점수 else 0 end) as 영어,
    sum(case when 과목명 = '수학' then 점수 else 0 end) as 수학
from tbl_성적
group by 학번;


-- 오라클의 decode() 함수를 이용해서
select 학번,
    sum(decode(과목명, '국어', 점수, 0)) AS 국어,
    sum(decode(과목명, '국어', 점수, 0)) AS 영어,
    sum(decode(과목명, '국어', 점수, 0)) AS 수학
from tbl_성적
group by 학번;


-- 오라클 11g 부터 지원하는 PIVOT 기능을 사용하는 방법
-- pivot() : 특정한 카럼을 기준으로 데이터를 pivot view 나타내는 내장함수
-- pivot( sum(값)) : pivot으로 나열할 데이터값이 들어있는 칼럼을 sum()으로 묵어서 표시
-- for 칼럼(칼럼값들) : '칼럼'에 '칼럼값'으로 가로(column)방향 나열하여 가상칼럼으로 만들기
select 학번, 국어, 영어, 수학
from tbl_성적
pivot
(
sum(점수)
for 과목명 in ('국어' as 국어,'영어' as 영어,'수학' as 수학)
) 성적
order by 학번;

create table tbl_학생정보 (
    학번 char(5) primary key,
    학생이름 nvarchar2(30) not null,
    전화번호 varchar2(20),
    주소 nvarchar2(125),
    학년 number,
    학과 char(3)
);


-- ambiguously define 오류는 ALIAS를 지정해서 해결한다.
-- join, subquery를 만들 때 한개의 테이블을 여러번 사용할 경우 반드시 alias를 설정하고
--      명확히 칼럼을 지정해 주어야 한다.

select sc.학번, st.학생이름, st.전화번호,
    sum(decode(sc.과목명, '국어', 점수, 0)) AS 국어,
    sum(decode(sc.과목명, '국어', 점수, 0)) AS 영어,
    sum(decode(sc.과목명, '국어', 점수, 0)) AS 수학
from tbl_성적 SC
    left join tbl_학생정보 ST
        on st.학번 = sc.학번
group by sc.학번,  st.학생이름, st.전화번호;



select 학번, 국어, 영어, 수학
from tbl_성적 SC
pivot
(
sum(sc.점수)
for 과목명 in ('국어' as 국어,'영어' as 영어,'수학' as 수학)
)
order by 학번;

create view view_성적pivot
as
(
select 학번, 국어, 영어, 수학
from tbl_성적 SC
pivot
(
sum(sc.점수)
for 과목명 in ('국어' as 국어,'영어' as 영어,'수학' as 수학)
)
);

select * from view_성적pivot;

select sc.학번, st.학생이름, sc.국어, sc.영어, sc.수학
from view_성적pivot sc
    left join tbl_학생정보 st
        on st.학번 = sc.학번;
        

select sc.학번, st.학생이름, sc.국어, sc.영어, sc.수학
from(
    select 학번, 국어, 영어, 수학
        from tbl_성적
        pivot
(
        sum(점수)
        for 과목명 in ('국어' as 국어,'영어' as 영어,'수학' as 수학)
)
) SC
left join tbl_학생정보 ST
    on st.학번 = sc.학번
    order by sc.학번;
    
    
    
select SC.학번, ST.학생이름, --이렇게 피봇
     sum(decode(SC.과목명, '국어',SC.점수,0)) as 국어,
     sum(decode(SC.과목명, '영어',SC.점수,0)) as 영어,
     sum(decode(SC.과목명, '수학',SC.점수,0)) as 수학,
     
     sum(decode(SC.과목명, '국어',SC.점수,0)
     +decode(SC.과목명, '영어',SC.점수,0)
     +decode(SC.과목명, '수학',SC.점수,0)) AS 총점
     
from tbl_성적 SC
    left join tbl_학생정보 ST
        ON ST.학번 = SC.학번
group by SC.학번,ST.학생이름;