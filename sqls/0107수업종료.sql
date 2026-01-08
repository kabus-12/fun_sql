--0107수업

--제약조건 이름과 함께 테이블생성
CREATE TABLE employees(
	emp_no NUMBER(4) CONSTRAINT employees_pk PRIMARY KEY
	,emp_name varchar2(100) CONSTRAINT employees_nn NOT NULL
	,jumin_no char(14) CONSTRAINT emp_jumin_nn NOT NULL 
					 CONSTRAINT emp_jumin_uk UNIQUE
	,deptno number(2) CONSTRAINT emp_dept_fk REFERENCES dept(deptno) --참조
);


INSERT INTO employees (emp_no,emp_name,jumin_no,deptno)
VALUES (1001,'Hong','990101-1234567',40);

SELECT * FROM employees;
SELECT * FROM dept;

DELETE FROM dept
WHERE deptno = 50;

INSERT INTO DEPT 
values(50,'sample','seoul');

--학과별 최대키, 최고몸무게, 학과이름
SELECT d.dname "학교명",s.max_h "최고키",s.max_w "최고몸무게"
FROM (SELECT deptno1, max(height) max_h, max(weight) max_w
FROM STUDENT
GROUP BY deptno1) s
JOIN department d ON s.deptno1 = d.deptno;

--ward 커미션 -> 적은 커미션을 받는 사람들 목록
SELECT * --500
FROM emp
WHERE ename = 'WARD';

SELECT *
FROM emp
WHERE comm < (SELECT comm FROM emp WHERE ename = 'WARD');

--전공
SELECT deptno1
FROM student
WHERE name = 'Anthony Hopkins';

SELECT s.name "stud_name",d.dname "dept_name"
FROM student s
JOIN department d ON s.deptno1 = d.deptno
WHERE deptno1 = (SELECT deptno1 FROM student WHERE name = 'Anthony Hopkins');

SELECT name "PROF_NAME",hiredate,dname "DEPT_NAME"
FROM professor p
JOIN department d ON p.deptno = d.deptno
WHERE hiredate < (SELECT hiredate FROM professor WHERE name = 'Meg Ryan')
ORDER BY hiredate;

SELECT *
FROM department;

--432page
SELECT empno, name, deptno
FROM emp2 e
JOIN dept2 d ON e.deptno= d.DCODE
WHERE deptno in (SELECT dcode FROM dept2 WHERE area = 'Pohang Main Office');  --in: 같은값을 찾는다

SELECT dcode
FROM dept2
WHERE area = 'Pohang Main Office';

--432page exists
SELECT *
FROM dept
WHERE exists(SELECT deptno FROM dept WHERE deptno = &dno);

SELECT *
FROM dept
WHERE exists(SELECT deptno FROM dept WHERE deptno = &dno);

select name,position,to_char(pay,'$999,999,999') "SALARY"
from emp2
where pay >any (select pay from emp2 where position = 'Section head')
order by -pay;

select name, grade, weight
from student
where weight >any (select weight from student where grade = 2);

select *
from student;

--부서별 평균연봉 중 가장 적은 부서의 평균연봉보다 더 적게 받는 사원들
select dname,name,pay
from emp2 e
join dept2 d on e.deptno = d.dcode;


select *
from emp2;
select *
from dept2;