-- scott 계정공유의 테이블 목록 조회
--  Structured Query Language (SQL)
select * from tab;
-- table/column

--테이블의 구조
desc customer; 

select gno, gname, jumin, point from customer;

--professor 테이블의 전체 목록 조회

select * from professor;

SELECT 'hello, ' || name as "Name"
FROM student;
--""안에 들어간 글자를 칼럼으로 지정할 수 있다. alias(별칭)

SELECT * FROM student;
SELECT name||q'['s ID: ]'|| id || ', WEIGHT is ' || height||'kg' as "ID AND WEIGHT"
FROM student;

SELECT *
FROM department; --학과

SELECT '부서번호는 ' || deptno ||', 이름은 ' || ename as "Name with Dept"
FROM emp
order by ename; --사원

SELECT *
FROM dept; --부서정보

select *
From emp;

SELECT ename||'('||job||'), '||ename||''''||job||'''' as "NAME AND JOB"
FROM emp;
