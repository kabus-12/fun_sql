--0106수업

--게시판(제목, 내용, 작성자, 작성시간, 조회수, 수정시간...)
DROP TABLE board;
CREATE TABLE board(
	board_no NUMBER PRIMARY key
	,title varchar2(100) NOT NULL -- 컬럼명 타입 제약조건
	,content varchar2(1000) NOT NULL -- 내용
	,writer varchar2(50) NOT NULL --작성자
	,write_date DATE DEFAULT sysdate --작성시간
);
--새로운 컬럼 추가
ALTER TABLE board ADD (click_cnt number);
--컬럼명 변경
ALTER TABLE board RENAME COLUMN click_cnt TO view_cnt;
--컬럼 타입 변경
ALTER TABLE board MODIFY writer varchar2(100);
--컬럼 삭제
ALTER TABLE board drop COLUMN click_cnt;

SELECT *
FROM board;
--DML
INSERT INTO board(board_no,title, content, writer)
VALUES (4,'신규회원등록관련','신규회원아이디는 50글자미만으로 작성해주세요','admin');

INSERT INTO board(title, content, writer,write_date)
VALUES ('신규회원등록관련','신규회원아이디는 50글자미만으로 작성해주세요','admin','2026-01-01');

DESC board;

--C(create)R(read)U(update)D(delete) 기능
--등록,수정,삭제,조회

SELECT * FROM dept2;

INSERT INTO dept2  --뒤에 칼럼명을 적지 않으면 테이블 내 모든 칼럼에 데이터를 넣겠다라는 뜻
values('9000','temp_1','1006','temp area');

SELECT * FROM product;

-- (상품코드:999, 상품명: Potato Chip, 가격: 1200)인 데이터를 product에 추가
INSERT INTO PRODUCT
values('999','Potato Chip',1200);

--commit(영구적으로 반영), rollback(취소(마지막으로 커밋한 시점으로 돌아감))

--CTAS =>테이블을 만들면서 카피
CREATE TABLE  professor2
as
select * FROM professor;

SELECT * FROM professor2;

DELETE FROM professor2; --데이터 삭제

-- ITAS => professor의 데이터를 서치하여 professor2테이블에 입력
INSERT INTO professor2
SELECT * FROM professor;

--UPDATE
SELECT * FROM professor2;

-- pay, bonus를 변경
UPDATE PROFESSOR2  --테이블명
SET pay = 650  --추가할 값
,bonus = 200
WHERE profno = 1001; --조건

--DELETE
DELETE FROM professor2 --삭제할 테이블 명
WHERE profno = 1001; --조건(조건이 없으면 전체 삭제)

--board
SELECT * FROM board;

--5번글 ,게시글 연습입니다,신규글 등록합니다.,user01 =>등록
INSERT INTO BOARD (board_no,title,content,writer)
values(5,'게시글 연습입니다','신규글 등록합니다.','user01');

-- 5번글의 제목 : 게시글 수정입니다., 내용: 신규글을 수정합니다 =>수정
UPDATE board
SET title = '게시글 수정입니다.'
,content = '신규글을 수정합니다'
WHERE board_no = 5;

--5번글 삭제
DELETE FROM BOARD 
WHERE board_no = 5;

--student -> student2
CREATE TABLE student2
AS
SELECT *
FROM student
WHERE 1 =2;

--INSERT select
INSERT INTO student2
SELECT * FROM student;

SELECT * FROM student2;
SELECT * FROM professor2;
-- Anthony Hopkins의 담당교수로 Jodie Foster로 지정
UPDATE student2
SET profno = (SELECT profno FROM  professor2 WHERE name = 'Jodie Foster')
WHERE name = 'Anthony Hopkins';

--3학년중에서 2전공이 없는 사람들의 전공을 Computer Engineering 으로 지정
SELECT * FROM student2
WHERE grade = 3;
SELECT * FROM DEPARTMENT;

UPDATE student2
SET deptno2 =(SELECT deptno FROM department WHERE dname = 'Computer Engineering')
WHERE grade = 3 AND deptno2 IS null;