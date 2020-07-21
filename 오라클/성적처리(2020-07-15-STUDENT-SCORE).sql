-- 여기는 grade 화면

-------------------------
-- 성적일람표 출력
-------------------------

-- 성적정보 Table(tbl_score)에는 학번과 각 과목별 점수가 저장되어 있다.
-- 학생정보 Table(tbl_student)에는 학번과 이름등이 저장되어 있다.
-- 성적일람표를 보고 싶은데, 학생의 학번과 이름이 포함된 리스트를 보고싶다.
-- 두개 Table, tbl_score, tbl_student를 연동하여 리스트를 조회해야 한다.
-- 이러한 기법을 JOIN 이라고 한다.

SELECT *
FROM tbl_score
WHERE sc_num BETWEEN '20001' AND '20010';


-- 완전 JOIN
--      sc_score table에 있는 학번의 정보는 반드시 st_student에 있다 라는 전제하에
--      결과가 원하는 대로 나온다
--      FROM 다음에 JOIN 할 Table을 나열하고
--      WHERE 절에 두 테이블의 연결점 칼럼을 설정해주면 된다.

-- * 외래키(Foreign key)의 개념을 정확히 알아야 한다.
-- * 예) 회원가입시 아이디('주')와 회원정보('부')로 나뉘는데 '부'를 외래키라 한다.
-- * 두개 이상의 테이블을 JOIN할 때 '부'가 되는 부분이다.
-- * 이는 데이터의 무결성을 보증하는 개념이므로 반드시 체크.
SELECT sc_num, st_name, sc_kor, sc_eng, sc_math, sc_music, sc_art
FROM tbl_score, tbl_student
WHERE
-- sc_num BETWEEN '20001' AND '20010'AND
sc_num = st_num;



-- !OUTER JOIN
-- 성적Table에는 1 ~ 100번까지만 데이터가 있고
-- 학생Table에는 1 ~ 50번까지만 데이터가 있다.
-- 이러한 상황에서 성적리스트를 확인하면서 학생정보와 연동하여 보고 싶을 때
-- EQ JOIN을 사용하게 되면 실제 데이터가 1 ~ 50번까지만 나타나는 현상이 발생한다.
-- 이런 상황에서 성적Table의 데이터는 모두 확인할 수 있으면서
--      학생Table에 있는 정보만 매칭해서 보여주는 방식의 JOIN.
-- * 주목적은 '부'데이터의 검증을 위해 사용하거나
-- * '주'데이터와 '부'데이터의 Input 타임이 다를 때 임시로 사용하기도 한다.
-- * 또한 아직 FK 설정이 되지 않은 table 간에 정보를 리스트 업하는 용도로 사용된다.

-- LEFT JOIN(주로사용), RIGHT(별로 사용하지 않으며 LEFT와 FROM WHERE를 바꾸면 댐)!
-- 1. JOIN 키워드 왼쪽에는 모드 리스트업할 table을 위치시키고
-- 2. 이 table과 연동하여 정보를 보조적으로 가져올 table을 JOIN 다음에 위치
-- 3. 두 table의 연결점(Key)를 ON 키워드 다음에 작성해 준다.

-- JOIN 왼쪽 table의 데이터를 모두 보여주고
-- 키값으로 오른쪽 table에서 값을 찾은 후
--      있으면, PROJECTION에 나열된 칼럼 위치에 값을 표시하고
--      만약 없으면, (null)이라고 표시한다.

DELETE FROM tbl_student
WHERE st_num > '20050';

SELECT * FROM tbl_student;


-- EQ JOIN
SELECT sc_num, st_name, sc_kor, sc_eng, sc_math, sc_music, sc_art
FROM tbl_score, tbl_student
WHERE sc_num = st_num;

-- 겹치는것만 보여줘라
SELECT sc_num, st_name, sc_kor, sc_eng, sc_math, sc_music, sc_art
FROM tbl_score
    INNER JOIN tbl_student
        ON sc_num = st_num;

-- 없는 모드업 데이터는 null로 놔두고 보조 데이터는 모두 보여줘라
SELECT sc_num, st_name, sc_kor, sc_eng, sc_math, sc_music, sc_art
FROM tbl_score -- 연동할 보조 데이터
    LEFT JOIN tbl_student -- 모드업 할 데이터
    ON sc_num = st_num;























