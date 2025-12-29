SELECT ename,
sal "인상전 급여"
,sal + comm "총급여"
,(sal + comm)* 1.1 as "인상된 급여(급여 + 보너스)"
FROM emp
WHERE sal < 3000
AND job = 'SALESMAN' --조건절(where)작성
ORDER BY ename desc; 

SELECT *
FROM emp
WHERE sal > 2000
OR job = 'SALESMAN';

--81년도에 입사한 사원정보
SELECT *
FROM emp
WHERE hiredate between '81/01/01' AND '81/12/31'
ORDER BY hiredate;
--2000에서 3000사이의 값을 구하는 방법
--WHERE sal between 2000 AND 3000;
--WHERE sal <= 3000
--AND sal > 2000;

--in(A,B,C)
SELECT *
FROM emp
WHERE deptno in(10, 20)  --deptno >=10 AND deptno <=20; 이거랑 구분해야한다
AND ename not in ('SMITH','FORD');

-- is null/ is not null
SELECT *
FROM emp
WHERE comm is not null; --''

-- like ( = )
SELECT *
FROM emp
WHERE ename like '_LA%';  -- % => *(없거나 한글자 이상)
                          -- _ => 한글자(에 대응)

SELECT *
FROM professor
WHERE deptno in(101, 103)
AND position like '%full%';
--AND position = 'a full professor'; -- Primary Key (중복 X)

SELECT *
FROM professor
WHERE name like '%an';

SELECT *
FROM professor
WHERE (bonus is null and pay >= 300)
OR (pay + bonus >= 300);

SELECT * 
FROM professor
WHERE pay + nvl(bonus, 0) >= 300;

SELECT *
FROM department;

--교수, 학생 => 교수(학생)번호/ 이름/ 학과정보.
SELECT profno, name, deptno
FROM professor
UNION ALL --중복된 값이 있어도 출력; UNION -- 중복된 값은 제거하고 출력
SELECT studno, name, deptno1
FROM student;

-- UNION ALL (중복된 값도 출력해줌)
-- UNION (중복된 값을 제외하고 출력해줌)
-- INTERSECT(중복된 값만 출력해줌)
SELECT studno, name
FROM student
WHERE deptno1 = 101
MINUS
SELECT studno, name
FROM student
WHERE deptno2 = 201
order by 1;
