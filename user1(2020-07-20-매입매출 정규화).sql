-- user1 화면입니다
-- tbl_iolist 에는 상품명, 거래처명, 거래처CEO 칼럼의 데이터가 일반 문자열 형태로 저장되어 있다.
 -- 이 데이터는 ㅏㅌ은 칼럼에 중복된 데이터가 있어서 데이터 관리 측면에서 상당히 불편한 상황이다.
 --     만약 어떤 상품의 상품명이 변경이 필요한 경우
 --     상품명을 UPDATE 하여야 하는데, 2개 이상의 레코드를 대상으로 UPDATE 과정이 필요하다.
 --     2개 이상의 레코드를 UPDATE 수행하는 것은 데이터의 무결성을 해칠 수 있는 수행이 된다.
 --     이러한 문제를 방지하기 위해 다음과 같은 정규화를 실행한다.
 
 -- 상품명 정보를 별도의 테이블로 분리하고, 상품정보에 상품 코드를 부여한 후
 --     tbl_iolist와 연동하는 방식으로 정규화를 실행한다.
 
 -- tbl_iolist로 부터 상품명 리스트를 추출하자
 --     상품명 칼럼을 GROUP BY 하여 중복되지 않은 상품명 리스트만 추출한다.
 SELECT io_pname,
        MIN(DECODE(io_inout, '매입',io_price,0)) AS 매입단가,
        MAX(DECODE(io_inout, '매출',io_price,0)) AS 매출단가
 FROM tbl_iolist
 GROUP BY io_pname
 ORDER BY io_pname;
 DROP TABLE TBL_iolist;
 ------------------------------------------------------------
 -- 상품정보 테이블
 ------------------------------------------------------------
 CREATE TABLE tbl_product (
 p_code	CHAR(5)	PRIMARY KEY,
p_name nVARCHAR2(125) NOT NULL,
p_iprice NUMBER,
p_oprice NUMBER,
p_vat CHAR(1) DEFAULT'1'
);

SELECT * FROM tbl_product;

/*
매입매출 테이블에서 상품정보(이름, 단가) 부분을 추출하여 상품정보 테이블을 생성했다.

매입매출 테이블에서 상품이름 칼럼을 제거하고
상품정보 테이블과 JOIN할 수 있도록 설정해야 한다.

현재 매입매출 테이블에는 상품이름이 들어있고
상품정보 테이블에는 상품코드, 상품이름, 매입 매출단가가 들어있다.

매입매출 테이블의 상품이름에 해당하는 상품코드를 매입매출 테이블에 UPDATE하고
매입매출테이블의 상품이름 칼럼을 제거한 후 JOIN을 수행하여 데이터를 확인해야 한다.
*/

-- 1. 매입매출테이블의 상품명과 상품정보 테이블의 상품명을 JOIN해서
--      매입매출 테이블의 상품명이 상품정보에 모두 있는지 확인 하기
SELECT io.io_pname, P.p_name
FROM tbl_iolist IO
    LEFT JOIN tbl_product P
        ON io.io_pname = P.p_name;
        
-- 위 Query를 실행하여 P.p_name 항목에 (null)값이 있다면 상품정보 테이블이 잘못만들어진 것이다.
-- 상품정보 테이블을 삭제하고과정을 다시 수행해야 한다.

-- 쿼리 결과중에 P.p_name 항목의 값이 null인 리스트만 보여라
-- 쿼리 결과가 정상이라면 출력되는 리스트는 한개도 없어야 한다.
SELECT io.io_pname, P.p_name
FROM tbl_iolist IO
    LEFT JOIN tbl_product P
        ON io.io_pname = P.p_name
WHERE P.p_name IS NULL; -- 해당칼럼 값이 NULL이 아니면 출력 : IS NOT NULL

-- 이제 상품데이터가 이상 없음을 알았으니 매입매출 테이블에 상품코드를 저장할 "칼럼을 추가"
-- ALTER TABLE : 테이블의 구조(칼럼 추가, 삭제) 변경, 칼럼의 타입변경 등을 수행하는 명령
-- 상품테이블의 p_code 칼럼과 같은 Type으로 io_pcode 칼럼을 추가
ALTER TABLE tbl_iolist ADD io_pcode CHAR(5);

ALTER TABLE tbl_iolist DROP COLUMN io_pcode;

-- ALTER TABLE을 할 때
-- 이미 많은 데이터가 INSERT되어 있는 상태에서 칼럼을 추가하면
-- 추가하는 칼럼은 당연히 초기값이 NULL이 된다.
-- 이 방식으로 칼럼을 추가하면 절대 칼럼 추가가 안된다.
-- 이 방식은 아직 데이터가 한개도 없을 때만 가능
ALTER TABLE tbl_iolist ADD (io_pcode CHAR(5) NOT NULL);

-- NOT NULL 조건을 추가하기
-- 1. p_code 칼럼을 추가, 기본값으로 문자열이므로 빈칸을 추가(숫자 칼럼이면 0을 추가)
ALTER TABLE tbl_iolist ADD (io_pcode CHAR(5) DEFAULT ' ');

-- 2. p_code 칼럼의 제약조건을 NOT NULL 설정
ALTER TABLE tbl_iolist MODIFY (io_pcode CONSTRAINT io_pcode NOT NULL);

-- 칼럼 추가
ALTER TABLE tbl_iolist ADD (io_pcode CHAR(5) DEFAULT ' ');
-- 칼럼 삭제
ALTER TABLE tbl_iolist DROP COLUMN io_pcode;
-- 칼럼의 NOT NULL 조건 추가하기
ALTER TABLE tbl_iolist MODIFY (io_pcode CONSTRAINT io_pcode NOT NULL);
-- 칼럼의 type 변경하기
ALTER TABLE tbl_iolist MODIFY (io_pcode CHAR(10));
-- 칼럼의 type 변경시 주의 사항
-- 칼럼의 type을 변경할 때
--      문자열 <==> 숫자처럼 type이 완전히 다른 경우는 오류가 발생하거나
--            데이터를 모두 읽을 수 있다.
--      CHAR <==> (n)VARCHAR2
--          문자열의 길이가 같으면 데이터 변환이 이루어 진다.
--          CHAR <==> nVARCHAR2는 저장된 문자열이 UNICODE(한글 등)이면
--          매우 주의를 해야 한다.
--          보통 길이가 다르면 오류가 나지만, 정상적으로 명령이 수행되더라도
--          데이터가 잘리거나, 문자열이 알 수 없는 값으로 변형되는 경우가 발생할 수 있다.


-- 칼럼 이름 변경
-- io_pcode 이름을 io_pcode1 으로
ALTER TABLE tbl_iolist RENAME COLUMN io_pcode TO io_pcode1;

-- 상품정보에서 매입매출장 각 레코드의 상품명과 일치하는 상품코드를 찾아서
-- 매입매출장의 상품코드(io_pcode) 칼럼의 저장해주기

-- UPDATE 명령이 Sub Query를 만나면
-- 1. Sub Query에서 현재 iolist의 io_name 칼럼의 값을 요구하고 있다.
-- 2. tbl_iolist의 레코드를 전체 SELECT를 수행한다.
-- 3. SELECT 된 List에서 io_pname 칼럼 값을 Sub Query로 전달한다.
-- 4. Sub Query는 전달받은 io_pname 값을 tbl_product 테이블에서 조회를 한다.
--      이때 Sub Query는 반드시 1개의 칼럼, 1개의 VO만 추출해야 한다.
-- 5. 그 결과를 현재 iolist의 레코드의 io_pcode 칼럼에 UPDATE를 수행한다.
UPDATE tbl_iolist IO
SET io_pcode =
(
    SELECT p_code
    FROM tbl_product P
    WHERE p_name = IO.io_pname
);

SELECT io_pcode FROM tbl_iolist;

-- iolist에 pcode가 정상적으로 UPDATE 되었는지 검증
SELECT io_pcode, io_pname
FROM tbl_iolist IO
    LEFT JOIN tbl_product P
        ON IO.io_pcode = P.p_code
WHERE p.p_name IS NULL;

-----------------------------
-- 거래처 데이터 정규화
-----------------------------
-- 거래처명, CEO 칼럼이 테이블에 들어 있다.
-- 이 칼럼을 추출하여 거래처 정보를 생성
-- 추출된 데이터 중 거래처명은 같고 CEO가 다르면 다른 회사로 보고
--      거래처 명과 CEO가 같으면 같은 회사로 보고 데이터를 만듦
SELECT io_dname, io_dceo
FROM tbl_iolist
GROUP BY io_dname, io_dceo
ORDER BY io_dname;

CREATE TABLE tbl_buyer (
    b_code CHAR(4) PRIMARY KEY,
    b_name nVARCHAR2(125) NOT NULL,		
    b_ceo nVARCHAR2(50)	NOT NULL,		
    b_tel VARCHAR2(20)			
);

-- b_tel 칼럼의 값이 중복된(2개이상)인 레코드가 있냐
SELECT * FROM tbl_buyer;
SELECT b_tel, count(*) FROM tbl_buyer
GROUP by b_tel
HAVING count(*) > 1;

-- iolist에 저장된 dname,dceo 칼럼으로 거래처 정보에서 데이터를 조회하고
-- iolist에 거래처 코드 칼럼으로 Update를 수행

ALTER TABLE tbl_iolist ADD (io_bcode CHAR(4) DEFAULT ' ');
ALTER TABLE tbl_iolist MODIFY (io_bcode CONSTRAINT io_bcode not NULL);

DESC tbl_iolist;


-- iolist와 buyer 테이블간의 거래처명, 대표자명 칼럼으로 JOIN을 수행하여 데이터 검증
-- 데이터가 한개도 출력 되지 않아야 한다.
SELECT *
FROM tbl_iolist IO
    LEFT JOIN tbl_buyer B
        ON IO.io_dname = B.b_name
WHERE B.b_name IS NULL;

-- iolist에 거래처 코드 UPDATE
-- 지금 생성한 tbl_buyer 테이블에는 거래처명은 같고 대표자가 다른 데이터가 있다.
-- 이 데이터에서 거래처명으로 조회를 하면 출력되는 레코드(row)가 2개 이상인 경우가 발생한다.
-- 따라서 이 쿼리를 실행하면 ORA-01427: single-row subquery returns more than one row 오류가 발생한다.
-- 이 쿼리는 거래처명과 CEO 값을 동시에 제한하여 1개의 row값만 Sub query에서 만들어 지도록 해야 한다.
UPDATE tbl_iolist IO
SET io_bcode =
(
    SELECT b_code
    FROM tbl_buyer B
    WHERE B.b_name = io.io_dname AND B.b_ceo = IO.io_dceo
);

SELECT io_bcode, io_dname, b_code, b_name
From tbl_iolist IO
    LEFT JOIN tbl_buyer B
        ON IO.io_bcode = B.b_code
WHERE b_code Is Null Or b_name Is Null;

-- 데이터를 tbl_product, tbl_buyer 테이블로 분리 했으니
-- tbl_iolist에서 io_pname, io_dname, io_dceo 칼럼은 필요가 없으므로 제거한다.
ALTER TABLE tbl_iolist DROP COLUMN io_pname;
ALTER TABLE tbl_iolist DROP COLUMN io_dname;
ALTER TABLE tbl_iolist DROP COLUMN io_dceo;

SELECT * FROM tbl_iolist;

CREATE VIEW view_iolist
AS
(
SELECT io_seq, io_date,
        io_bcode, b_name, b_ceo, b_tel,
        io_pcode, p_name, p_iprice, p_oprice,
        io_inout,
        DECODE(io_inout, '매입', io_price, 0) AS 매입단가,
        DECODE(io_inout, '매입', io_amt, 0) AS 매입금액,
        DECODE(io_inout, '매출', io_price, 0) AS 매출단가,
        DECODE(io_inout, '매출', io_amt, 0) AS 매출금액
FROM tbl_iolist IO
    LEFT JOIN tbl_product P
        ON IO.io_pcode = P.p_code
    LEFT JOIN tbl_buyer B
        ON IO.io_bcode = B.b_code
);

SELECT * FROM view_iolist
WHERE io_date BETWEEN '2019-01-01' AND '2019-01-02'
ORDER BY io_date;


