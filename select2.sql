SELECT ename,
sal "인상전 급여"
,sal + comm "전체급여"
,(sal + comm)* 1.1 as "인상 후 급여(급여 + 보너스)"
FROM emp
WHERE sal < 3000
AND job = 'SALESMAN' --������(where)�ۼ�
ORDER BY ename desc; 

SELECT *
FROM emp
WHERE sal > 2000
OR job = 'SALESMAN';

--81�⵵�� �Ի��� �������
SELECT *
FROM emp
WHERE hiredate between '81/01/01' AND '81/12/31'
ORDER BY hiredate;
--2000���� 3000������ ���� ���ϴ� ���
--WHERE sal between 2000 AND 3000;
--WHERE sal <= 3000
--AND sal > 2000;

--in(A,B,C)
SELECT *
FROM emp
WHERE deptno in(10, 20)  --deptno >=10 AND deptno <=20; �̰Ŷ� �����ؾ��Ѵ�
AND ename not in ('SMITH','FORD');

-- is null/ is not null
SELECT *
FROM emp
WHERE comm is not null; --''

-- like ( = )
SELECT *
FROM emp
WHERE ename like '_LA%';  -- % => *(���ų� �ѱ��� �̻�)
                          -- _ => �ѱ���(�� ����)

SELECT *
FROM professor
WHERE deptno in(101, 103)
AND position like '%full%';
--AND position = 'a full professor'; -- Primary Key (�ߺ� X)

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

--����, �л� => ����(�л�)��ȣ/ �̸�/ �а�����.
SELECT profno, name, deptno
FROM professor
UNION ALL --�ߺ��� ���� �־ ���; UNION -- �ߺ��� ���� �����ϰ� ���
SELECT studno, name, deptno1
FROM student;

-- UNION ALL (�ߺ��� ���� �������)
-- UNION (�ߺ��� ���� �����ϰ� �������)
-- INTERSECT(�ߺ��� ���� �������)
SELECT studno, name
FROM student
WHERE deptno1 = 101
MINUS
SELECT studno, name
FROM student
WHERE deptno2 = 201
order by 1;
