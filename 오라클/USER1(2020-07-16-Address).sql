-- 여기는 user1 화면
CREATE TABLE tbl_address (
    ad_seq	CHAR(5) PRIMARY KEY,
    ad_name	nVARCHAR2(20) NOT NULL,	
    ad_tel	VARCHAR2(20),
    ad_addr	nVARCHAR2(125)
);

CREATE TABLE tbl_hobby (
    ad_seq CHAR(5)	NOT NULL,
    ho_name	nVARCHAR2(20) NOT NULL

);

SELECT * FROM tbl_address;
SELECT * FROM tbl_hobby;

-------------------------------------------------------
-- 두개의 테이블(주소, 취미)이 1:N(다)의 관계가 있는 상태
-------------------------------------------------------

-- 보조테이블에 있는 데이터가 주 테이블의 PK값을 다수 가지고 있는 경우
-- 두 테이블을 JOIN하면, 보조테이블의 레코드 개수만큼
-- 주테이블의 데이터가 더 추가된 것처럼 보인다.
SELECT *
FROM tbl_address AD
    LEFT JOIN tbl_hobby HO
        ON AD.ad_seq = HO.ad_seq
ORDER BY ad_name;

/*
    등산
    낚시
    여행
    독서
    음악감상
    묵묵부답
    기타
    노래
    음주
    가무
*/



-- Same Code with 'DECODE' In JAVA Language
-- EX.01)
-- if(ho_name == '등산') {
-- return 'O'
-- } else {
--  return " ";
-- }

-- EX.02)
-- str = ho_name == '등산' ? 'O' : ' ';
---- ho_name == '등산'dlaus
-- O문자열을 보여라
-- 아니면 공백 문자열을 보여라(NOT NULL이기 때문에 표시하고 싶지 않으면 공백삽입)
SELECT DECODE( ho_name, '등산','O',' ')
FROM tbl_hobby;

-- 'MAX'는 숫자형태가 아닌 문자형태의 데이터를 합쳐서 보기위한 코드
-- ad_seq 값은 한사람이 여러가지 취미를 가지고 있으면
-- 같은 ad_seq를 가진 레코드가 다수 나타나게 된다.
-- A0001 등산
-- A0001 낚시
-- 이러한 형태의 리스트가 나타날텐데 
-- 우리는 ad_seq값을 그룹으로 묶고
-- 취미부분을 가상의 칼럼으로 변환하여
-- A0001    등산  낚시
-- 형식의 리스트로 보이기 위한 방법
-- 이러한 형식으로 데이터를 리스트업 하는 것을 PIVOT이라고 한다.


CREATE VIEW view_hobby
AS
(
SELECT ad_seq,
    MAX( DECODE( ho_name, '등산','O',' ') ) AS 등산,
    MAX( DECODE( ho_name, '낚시','O',' ') ) AS 낚시,
    MAX( DECODE( ho_name, '여행','O',' ') ) AS 여행,
    MAX( DECODE( ho_name, '독서','O',' ') ) AS 독서,
    MAX( DECODE( ho_name, '음악감상','O',' ') ) AS 음악감상,
    MAX( DECODE( ho_name, '묵묵부답','O',' ') ) AS 묵묵부답,
    MAX( DECODE( ho_name, '기타','O',' ') ) AS 기타,
    MAX( DECODE( ho_name, '노래','O',' ') ) AS 노래,
    MAX( DECODE( ho_name, '음주','O',' ') ) AS 음주,
    MAX( DECODE( ho_name, '가무','O',' ') ) AS 가무
FROM tbl_hobby
WHERE ho_name IS NOT NULL
GROUP BY ad_seq
);

SELECT AD.ad_seq, AD.ad_name, HO.*
FROM tbl_address AD
    LEFT JOIN view_hobby HO
        ON AD.ad_seq = HO.ad_seq;
        
--------------------------------------------------
-- PIVOT을 사용하는 이유
--------------------------------------------------
-- 주소록 테이블에 취미 항목이 필요로 한데
-- 취미는 한 사람이 여러가지 취미를 가질 수 있고
-- 경우에 따라 아무도 가지지 않는 새로운 취미가 필요할 수도 있다

-- 이럴 때, 칼럼을 취미의 갯수만큼 만들어서 사용하면
-- 초기에는 매우 쉽게 table을 만들 수 있다.

-- 하지만 취미가 추가되면 그때마다 table의 물리적 구조를 변경해야 하는데
-- table의 테이블의 물리적 구조를 변경하는 것은 매우 위험하고, 불합리한 방법이다.
-- 데이터의 무결성을 유지하는데는 치명적인 단점이 될 수 있다.

-- 차라리 취미를 담는 table을 만들고
-- 주소록정보와 분리하고 취미정보 테이블에는
-- 주소정보의 값이 취미의 갯수만큼 레코드로 저장되도록 한다.
-- 이 데이터를 리스트업 할 때
-- 주소정보 값 1개에 취미정보가 마치 칼럼으로 구성된 것처럼 데이터를 보이게 한다.
-- 이럴 때 PIVOT 방식으로 데이터를 펼쳐 보아야 한다.






