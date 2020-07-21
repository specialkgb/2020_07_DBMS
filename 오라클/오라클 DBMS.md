오라클 DBMS
1. 표준 SQL을 사용하는 데이터베이스 소프트웨어
2. 대용량, 분산, 고신뢰성을 보여주는 대표적인 DBMS SW
3. DBMS SW 스키마 : 저장공간 단위, 그룹
4. DBMS마다 기본 스키마를 관리하는 방법이 조금씩 다른데 오라클에서는 사용자 ID가 스키마의 기본 단위가 된다.
5. 로그인(DB접속) 사용자 ID에 따라 관리할 수 있는 DB가 다르게 된다.
6. Table Space : 데이터를 저장하는 기본공간(로컬디스크에 저장되는 물리적 공간)
7. 사용자를 등록하면 사용자 자체가 Schema가 되며, 사용자별로 데이터를 저장하는 물리적 공간을 OS에서 관리하는 파일 단위 개념으로 사용한다.
8. Table Space : DB를 저장하는 논리적인 개념보다는 실제 데이터가 저장되는 파일이라고 보면 된다.
9. 사용자를 등록하기 전에 Table Space를 만들고, 사용자를 등록하면서 생성한 Table Space에 데이터를 저장하도록 연결하는 작업이 필요하다.


### sys 사용자 접속 설정
1. 오라클 DBMS SW를 설치하면 기본적으로 DB Administer 사용자가 등록이 되어 있다.
2. System DBA : 오라클 DBMS을 관리하는 최상위 등급의 사용자
3. id가 sys user : SQL Developer를 통해서 오라클 DBMS에 접속하여 Schema, User, Table 등을 생성하거나 삭제할 수 있는 권한을 가진 사용자
4. sys user는 오라클 DBMS를 설치할 때 설정한 비밀번호로 접속을 할 수 있다.

### 오라클 사용자 생성
1. SYS 로 접속하여 SQL 실습, 개발, 운용을 하는 것은 보안상, 안전상 매우 좋지 않다.
2. 일반적으로 사용자를 등록하고, 그 사용자 ID로 접속하여 명령을 수행하는 것이 좋다.

### 오라클의 사용자 생성 절차
1. 사용자가 사용(관리)할 TableSpace를 생성한다.
2. USER를 생성하면서 TableSpace를 default로 지정해 준다.
3. 오라클에서는 새로운 사용자를 등록하면 아무것도 할 수 없는 상태로 ID만 생성을 한다.
4. 따라서 새로운 사용자가 DB에 접속하여 뭔가 업무를 수행하려면, 관리자(sys)가
새로운 사용자에게 권한을 부여해 주어야 한다.

### NULL 값
* 프로그램 코딩이나, DBMS에서 사용되는 NULL 값
* 문자열형 : 공백, 빈칸처럼 보이지는 않지만 Code 값으로 인식되는
데이터와 구분하기 위해서 사용하는 "아무것도 아닌 값이라는 개념"
* String s = " ";, String s = "";, String s = null;
* DB에서 Null값은 칼럼에 데이터가 추가되지 않은 상태
* insert를 수행하면서 해당 칼럼에 데이터를 지정하지 않았을 때

* DBMS PK로 지정된 칼럼이나, NOT NULL로 지정된 칼럼은 데이터를
지정하지 않은 상태로 INSERT 명령을 수행할 수 없다.

## DataBase Language
1. DB Lang. 에는 DDL, DML, DCL 명령 세트가 있다
2. DDL(Data Definition Lang.) : CREATE, DROP, ALTER
3. DML(Data Manipulation Lang.) : INSERT, SELECT, UPDATE, DELETE
4. DCL(Data Control Lang.) : GRANT, REVOKE, COMMIT, ROLLBACK