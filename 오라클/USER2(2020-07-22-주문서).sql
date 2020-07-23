-- 여기는 USER2 화면입니다.

/*
주문번호, 고객번호, 상품코드, 상품명, 판매가격, 수량, 합계
O0001     C0032     P00001
O0001     C0032     P00002
O0001     C0032     P00003
*/

SELECT * FROM tbl_주문서원장
ORDER BY 주문번호;

--------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE tbl_order(
        O_SEQ	NUMBER		PRIMARY KEY,
        O_NUM	CHAR(6)	NOT NULL,	
        O_DATE	CHAR(10)	NOT NULL,
        O_CNUM	CHAR(5)	NOT NULL,
        O_PCODE	CHAR(6)	NOT NULL,	
        O_PNAME	nVARCHAR2(125),		
        O_PRICE	NUMBER,		
        O_QTY	NUMBER,		
        O_TOTAL	NUMBER		
);
drop table tbl_order;
/*
tbl_order Table 을 만들면서 여기에 추가될 데이터들 중에 1개의 칼럼으로는 PK를 만들 수 없어서
임의의 일련번호 칼럼을 하나 추가하고 이 칼럼을 PK 선언했다.
이 상황에 되면 데이터를 추가할 때 O_SEQ 칼럼에 저장된 데이터들을 하나하나 살펴보고
등록되지 않은 숫자를 만든다음 그 값으로 SEQ을 정하고 INSERT를 수행해야 한다.
이런방식은 코드를 매우 불편하게 만드는 결과를 낳게 된다.

이러한 불편을 방지하기 위해 SEQUENCE 라는 객체를 사용하여, 자동으로 일련번호를 만드는 방법을 사용한다.
*/

CREATE SEQUENCE seq_order
START WITH 1 INCREMENT BY 1;

-- 표준 SQL에서 간단한 계산을 할 때
-- (MySQL)SELECT 3+4; 라고 코딩을 하면 3+4의 결과를 확인할 수 있다.
-- 그런데 오라클에서는 SELECT 명령문에 FROM [table] 절이 없으면 문법오류가 난다.
-- 이러한 코드가 필요할 때 시스템에 이미 준비되어있는 DUAL이라는 DUMMY 테이블을 사용해서 코딩을 한다.
SELECT 3+4 FROM DUAL;

-- seq_order 객체의 NEXTVAL 이라는 모듈(함수역할)을 호출하여
-- 변화되는 일련번호를 보여달라 라는 코드
SELECT SEQ_ORDER.NEXTVAL FROM DUAL;

-- 이 seq_order의 NEXTVAL 모듈을 사용하여 INSERT를 수행할 때 일련번호를 자동으로 부여할 수 있다.
/* 
주문번호, 고객번호, 상품코드, 상품명, 판매가격, 수량, 합계
O00001     C0032     P00001
O00001     C0032     P00002
O00001     C0032     P00003

지금 tbl_order 테이블에 위와 같은 데이터가 있을 때
O00001     C0032     P00001 이러한 데이터를 추가한다면 아무런 제약없이 값이 추가되어버릴 것이다.
*/

INSERT INTO tbl_order(o_seq, o_date, o_num, o_cnum, o_pcode) 
    VALUES (seq_order.NEXTVAL, '2020-07-22', 'O00001', 'C0032', 'P00001');
INSERT INTO tbl_order(o_seq, o_date, o_num, o_cnum, o_pcode) 
    VALUES (seq_order.NEXTVAL, '2020-07-22', 'O00001', 'C0032', 'P00002');
INSERT INTO tbl_order(o_seq, o_date, o_num, o_cnum, o_pcode)
    VALUES (seq_order.NEXTVAL, '2020-07-22', 'O00001', 'C0032', 'P00003');
    
SELECT o_num, o_cnum, o_pcode FROM tbl_order;

-- 주문번호, 고객번호, 상품코드 이 3개의 칼럼묶음에 값이 중복되면 INSERT가 되지 않도록 제약조건을 설정
-- UNIQUE : 칼럼에 값이 중복되어서 INSERT가 되는 것을 방지하는 제약조건
-- 주문테이블에 UNIQUE 제약조건을 추가하자
ALTER TABLE tbl_order
    ADD CONSTRAINT UQ_ORDER
        UNIQUE (o_num, o_cnum, o_pcode);
-- UNIQUE를 추가하는데 이미 UNIQUE 조건에 위배는 값이 있으면 제약조건이 추가되지 않는다.
-- duplicate keys found : PK, UNIQUE로 설정된 칼럼에 값을 추가하거나,
--                        이미 중복된 값이 있는데 PK, UNIQUE를 설정하려 할 때 발생한다.

-- 후보키 중에 단일 칼럼으로 PK를 설정할 수 없는 상황이 발생을 하면
-- 복수의 칼럼으로 PK를 설정하는데
-- UPDATE, DELETE 수행할 때 where 칼럼1 = 값 and 칼럼2 = 값 and 칼럼3 = 값... 과 같은 조건을 부여해야 한다.
-- 이것은 데이터 무결성을 유지하는데 매우 좋지 않은 환경이다
-- 이럴때 데이터와 상관없는 seq칼럼을 만들어 pk로 설정하자

SELECT * FROM tbl_order;
rollback;
INSERT INTO tbl_order(o_seq, o_date, o_num, o_cnum, o_pcode) 
    VALUES (seq_order.NEXTVAL, '2020-07-23', 'O00008', 'C0032', 'P00008');
