-- grade User로 접속한 화면

-- CONSTRAINTS : 제약조건, 제약사항, Valid Option
-- 데이터를 INSERT 수행할 때 DBMS 차원에서 유효성검사를 하고
-- 통과하지 못하면 INSERT 명령에 오류를 내도록 하는 설정
-- INSERT를 하지 않는다. ==> 데이터의 무결성을 유지한다.
-- PRIMARY KEY : 중복되지 않고, NULL값이 아닌 값만 유효
--               UNIQUE와 NOT NULL을 포함한 제약 조건이 설정
--               SELECT로 조회를 할 때 PK로 설정된 칼럼을 기준으로 오름차순 정렬
--               PK 칼럼으로 기존 INDEX가 설정된다.

-- NOT NULL : NULL값이 아닌 값만 유효
-- UNIQUE : 중복되지 않는 값만 유효, 해당칼럼에 추가하고자하는 데이터가
--          이미 저장되어 있으면 추가로 저장할 수 없다.

-- CHECK : 어떤 값이 해당범위에서 유효한 경우만 추가가능

-- 문자열 칼럼 Type
-- CHAR(자릿수) : 저장하는 데이터의 길이가 모두 일정할 경우 사용하는 Type
--                저장하는 Data가 자릿수가 같지 않으면 부족한 부분을 공백으로 채우는데
--                DB에 따라 문자열의 앞, 뒤에 공백을 추가하여 간혹 조회를 할 때
--                조회가 잘 안될 수도 있다.
-- VARCHAR2(자릿수) : 저장하는 데이터의 길이가 일정하지 않을 경우 사용하는 Type
--                    저장하는 Data가 설정한 자릿수보다 작으면 칼럼의 실제 크기를
--                    줄여서 저장하는데 CHAR보다 다소 지연되지만 별 문제가 없다.
--                    저장할 데이터를 잘 분석하여 자릿수를 데이터의 최대 크기만큼 지정.
--                    저장할 데이터의 길이가 자릿수보다 크면 저장되지 않는다.

-- nVARCHAR2(자릿수) : VARCHAR2(자릿수)와 성질이 같은 Type
--                    영문자 전용이 아닌 한글, 한자 등 알파벳 이외의 문자를 저장할 때 사용
--                    UNICODE 문자열을 위해 특별히 마련된 Type
--                    영문자 1글자와 한글 1글자를 같은 자릿수로 취급한다.
--                    키보드에 기본적으로 있는 문자가 아닌 문자를 저장하는 경우는
--                    무조건 nVARCHAR2()를 사용하자

-- NUMBER(자릿수, 소수점) : 오라클에서는 숫자형일 경우 별도의 Type을 명시하지 않고
--                         NUMBER(자릿수, 소수점) : 형식으로 사용을 한다.
--                         NUMBER(자릿수) : 정수형을 표현
--                         NUMBER(자릿수, 소수점) : 실수형을 표현
--                         자릿수를 생략하면 최대 38자리까지 정수를 저장할 수 있다.


CREATE TABLE tbl_student (
    st_num	CHAR(5) PRIMARY KEY,
    st_name	nVARCHAR2(20) NOT NULL,
    st_dept	nVARCHAR2(10),
    st_grade NUMBER(1) CHECK(st_grade > 0 AND st_grade <= 4),
    st_tel	nVARCHAR2(20),
    st_addr	nVARCHAR2(125),
    st_age	NUMBER(3)
);


DROP TABLE tbl_student CASCADE CONSTRAINTS;

-- 데이터 추가1
INSERT INTO tbl_student (
    ST_NUM,
    ST_NAME,
    ST_DEPT,
    ST_GRADE,
    ST_TEL,
    ST_ADDR,
    ST_AGE
) VALUES (
    '10001',
    '홍길동',
    '컴퓨터공학',
    3,
    '010-111-1111',
    '서울특별시',
    33
);

-- INSERT 수행 후 자주 발생하는 오류들
-- unique constraint (GRADE.SYS_C007018) violated : PK, UNIQUE로 설정된 칼럼에
--                              이미 저장된 값을 또 저장하려고 할 때 발생.

-- 데이터 추가2
INSERT INTO tbl_student (
    ST_NUM,
    ST_NAME,
    ST_DEPT,
    ST_GRADE,
    ST_TEL,
    ST_ADDR,
    ST_AGE
) VALUES (
    '10003',
    '홍길동',
    -- '컴퓨터공학',
    3,
    '010-111-1111',
    '서울특별시',
    33
);

-- INSERT 수행 후 자주 발생하는 오류들
-- not enough values : INTO에 나열한 칼럼에 저장할 데이터가 누락된 경우 발생.
-- 예) 나열된 칼럼 개수 6개인데, Values 데이터는 6개 미만으로 설정된 경우


-- 데이터 추가3
INSERT INTO tbl_student (
    ST_NUM,
    -- ST_NAME,
    ST_DEPT,
    ST_GRADE,
    ST_TEL,
    ST_ADDR,
    ST_AGE
) VALUES (
    '10003',
    -- '홍길동',
    '컴퓨터공학',
    3,
    '010-111-1111',
    '서울특별시',
    33
);

-- INSERT 수행 후 자주 발생하는 오류들
-- cannot insert NULL into ("GRADE"."TBL_STUDENT"."ST_NAME") :
--                          NOT NULL로 설정된 칼럼이 누락된 경우


-- 데이터 추가4
INSERT INTO tbl_student (
    ST_NUM,
    ST_NAME,
    ST_DEPT,
    ST_GRADE,
    ST_TEL,
    ST_ADDR,
    ST_AGE
) VALUES (
    '10004',
    '홍길동',
    '컴퓨터공학',
    '3A',
    '010-111-1111',
    '서울특별시',
    33
);
-- INSERT 수행 후 자주 발생하는 오류들
-- invalid number : 
--      NUMBER로 설정된 칼럼에 문자열을 저장하려고 시도한 경우
--      만약 NUMBER 설정된 칼럼에 숫자를 '2' 따옴표로 묶어서 지정하면
--      내부에서 문자열 > 숫자 형식으로 변환하여 저장한다. : 자동 형변환
--      그런데 문자열 > 숫자 형식으로 자동형변환을 하는데 숫자로 변환할 수 없는
--      문자열이 포함되면 invalid number 오류를 나타낸다.


-- 데이터 추가5
INSERT INTO tbl_student (
    ST_NUM,
    ST_NAME,
    ST_DEPT,
    ST_GRADE,
    ST_TEL,
    ST_ADDR,
    ST_AGE
) VALUES (
    '10004',
    '홍길동',
    '컴퓨터공학',
    '5',
    '010-111-1111',
    '서울특별시',
    33
);
-- INSERT 수행 후 자주 발생하는 오류들
-- check constraint (GRADE.SYS_C007014) violated : 
--      CHECK로 유효성 검사를 설정했는데 범위, Valid를 통과하지 못했을때,



-- INSERT를 수행한 후 데이터 확인
-- INSERT 후 데이터를 확인할 때는 모든 데이터를 조회하는 것보다
-- 현재 입력한 데이터의 PK를 기준으로 조회하는 것이 정확도가 높다
SELECT *
FROM tbl_student
WHERE st_num = '10001';















