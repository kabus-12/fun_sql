SELECT name,tel
,decode(substr(tel,1,instr(tel,')',1)-1),'02','SEOUL',
'031','GYEONGGI',
'051','BUSAN',
'052','ULSAN',
'055','GYEONGNAM','ETC') as "LOC"
--case when 구문 WHEN 조건1 THEN 출력1 구문
,CASE substr(tel,1,instr(tel,')',1)-1) WHEN '02' THEN 'SEOUL'
									   WHEN '031' THEN 'GYEONGGI'
									   WHEN '051' THEN 'BUSAN'
									   WHEN '052' THEN 'ULSAN'
									   WHEN '055' THEN 'GYEONGNAM'
									   ELSE 'ETC'    -- ELSE = 나머지라는 뜻
									   END "Loc2"    -- END = 마무리
FROM student
WHERE deptno1 = '201';

SELECT name, jumin
,decode(substr(jumin,7,1),'1','MAN',
               '2','WOMAN') as "Gender"
--case
,CASE substr(jumin,7,1) WHEN '1' THEN 'MAN'
						WHEN '2' THEN 'WOMAN'
						END "Gender2"
FROM student
WHERE deptno1 = '101';

-- case 구문을 활용 조건의 범위를 지정
-- 01 ~ 03 => 1/4, 04 ~ 06 => 2/4, 07 ~ 09 => 3/4, 10 ~ 12 4/4
SELECT name, substr(jumin,3,2) AS "MONTH"
,CASE WHEN substr(jumin,3,2) BETWEEN '01' AND '03' THEN '1/4'
	  WHEN substr(jumin,3,2) BETWEEN '04' AND '06' THEN '2/4'
	  WHEN substr(jumin,3,2) BETWEEN '07' AND '09' THEN '3/4'
	  WHEN substr(jumin,3,2) BETWEEN '10' AND '12' THEN '4/4'
	  END "QUARTER"
FROM student;

--123p 퀴즈
SELECT empno,ename,sal
,CASE WHEN sal BETWEEN '1' AND '1000' THEN 'LEVEL 1'
	  WHEN sal BETWEEN '1001' AND '2000' THEN 'LEVEL 2'
	  WHEN sal BETWEEN '2001' AND '3000' THEN 'LEVEL 3'
	  WHEN sal BETWEEN '3001' AND '4000' THEN 'LEVEL 4'
	  ELSE 'LEVEL 5'
	  END "LEVEL"
FROM emp
ORDER BY sal DESC;

--group
SELECT deptno, ename, count(*) "인원" , sum(sal) "부서별 급여"
FROM emp
GROUP BY deptno,ename; --부서번호별 그룹

SELECT ename, job, hiredate
FROM emp
ORDER BY 1;

--emp 테이블
SELECT deptno,job, count(1) "건수", sum(sal + nvl(comm,0)) "직무별 급여합계"
,round(sum(sal +nvl(comm,0))/count(1)) "직무별 평균급여"
,round(avg(sal + nvl(comm,0))) "직무별 평균급여1"
,min(sal + nvl(comm,0)) "최저급여"
,max(sal + nvl(comm,0)) "최고급여"
--,stddev(sal) "표준편차"
--,variance(sal) "분산"
FROM emp
GROUP BY deptno, job;

-- 직무별 그룹
SELECT job
	   ,sum(sal)
	   ,round(avg(sal + nvl(comm,0))) "직무별 평균급여"
FROM emp
--WHERE sal > 1500 -- where 절 조건문 
GROUP BY job								
--HAVING round(avg(sal + nvl(comm,0))) > 1500;-- having 절 조건문은 구분해야한다
UNION ALL  --위 아래 연결
SELECT '전체'
      ,sum(sal)
      ,round(avg(sal + nvl(comm,0)))
FROM emp;

--부서/ 직무(업)/ 정보조회(평균급여, 사원수)
--1. 부서별 직무별 평균급여, 사원수
SELECT deptno||'', job, avg(sal), count(1)
FROM emp
GROUP BY deptno, job
UNION all
--2. 부서별 평균급여, 사원수
SELECT deptno||'', '소계', round(avg(sal)), count(1)
FROM emp
GROUP BY deptno
UNION all
--3.전체 평균급여, 사원수
SELECT '전체','',round(avg(sal)),count(1)
FROM emp
order BY 1, 2;

-- rollup 함수
SELECT nvl(deptno||'','전체') AS "dept"
,decode(deptno, NULL,' ', nvl(job,'소계')) AS "job"
,round(avg(sal)) AS "avg_sal"
,count(1) AS "cnt_emp"
--,nvl(deptno,1) AS "order_by"
FROM emp
GROUP BY rollup(deptno,job)
ORDER BY nvl(deptno,1),1,2;

--emp, dept 테이블
SELECT empno,ename,e.deptno,dname,loc,d.deptno
FROM emp e  --driving 테이블
JOIN dept d ON e.deptno = d.deptno -- join 기준
WHERE dname = 'ACCOUNTING'  -- ANSI 조인
;

--오라클만 가능한 방식(위와 같음)
SELECT empno,ename,e.deptno,dname,loc,d.deptno
FROM emp e  --driving 테이블
     ,dept d
WHERE e.deptno = d.deptno
AND dname = 'ACCOUNTING';
     
SELECT *
FROM dept;

--학생, 교수, 학과 조인결과
--학번, 이름, 담당교수 이름, 학과명
SELECT s.studno "학번"
,s.name "학생이름"
,p.name "교수이름"
,d.dname "학과명"
FROM student s
JOIN professor p ON s.profno = p.profno -- 학생 - 교수 테이블의 조인 조건
JOIN department d ON s.deptno1 = d.deptno; --학생 - 학과 테이블 조인

SELECT * 
FROM professor;

SELECT *
FROM department;

--등가조인(equi join)
--고객테이블()
SELECT c.*,g.gname
FROM customer c
JOIN gift g ON c.point BETWEEN g.g_start AND g.g_end;

--위와 같은 의미
SELECT c.*,g.gname
FROM customer c
JOIN gift g ON c.point >= g.g_start AND c.point <= g.g_end;

SELECT * 
FROM gift;

--비등가조인(Non-equi join)
--학생, 학점
SELECT s.studno "학번"
	   ,s.name "학생이름"
	   ,c.total "점수"
	   ,h.grade "학점"
FROM student s
JOIN score c ON s.studno = c.studno
JOIN hakjum h ON c.total >= h.min_point AND h.max_point >= c.total;

SELECT *
FROM score;

SELECT *
FROM hakjum;

--254p 1번
--ANSI Join 문법
SELECT s.name "STU_NAME"
,s.deptno1 "DEPTNO1"
,d.dname "DEPT_NAME"
FROM  student s
JOIN department d ON s.deptno1 = d.deptno;
--Oracle Join 문법
SELECT s.name "STU_NAME"
,s.deptno1 "DEPTNO1"
,d.dname "DEPT_NAME"
FROM student s
    ,department d
WHERE s.deptno1 = d.deptno;

SELECT *
FROM department;

--254p 2번
SELECT e2.name
,e2.position
,e2.pay
,p.s_pay "Low Pay"
,p.e_pay "High Pay"
FROM emp2 e2
JOIN p_grade p ON e2.POSITION = p.position;

SELECT *
FROM emp2;

SELECT *
FROM p_grade;

--255p 3번
SELECT name
,trunc(months_between(sysdate,e2.birthday)/12) "AGE"
,e2.POSITION "CURR_POSITION"
,p.POSITION "BE_POSITION"
FROM emp2 e2
JOIN p_grade p ON  trunc(months_between(sysdate,e2.birthday)/12) BETWEEN p.s_age AND p.e_age;

--생일 데이터 늘리기
UPDATE emp2
SET birthday = add_months(birthday, -12)
WHERE 1=1;

--outer join(아우터조인) vs inner join(이너 조인) => join만 쓰는 것
SELECT s.studno "학번"
,s.name "학생이름"
,p.profno "교수이름"
,p.name "교수이름"
FROM student s
full OUTER JOIN professor p ON s.profno = p.profno;
-- left outer => student(from 쪽) 테이블 기준, right outer => (join 쪽)professor 테이블 기준
-- full outer => 전체 테이블 기준

--self join(셀프 조인) => 테이블 하나로 join하는 것
SELECT e1.empno "사원번호"
,e1.ename "사원이름"
,e2.empno "관리자 번호"
,e2.ename "관리자 이름"
FROM emp e1
left OUTER JOIN emp e2 ON e1.mgr  = e2.empno;

SELECT count(*) FROM emp;

--p255 4번
SELECT *
FROM customer;

SELECT *
FROM gift;

SELECT c.gname "CUST_NAME"
,c.point "POINT"
,g.gname "GIFT_NAME"
FROM customer c
JOIN gift g ON c.point >  

