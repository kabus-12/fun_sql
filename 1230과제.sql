--decode ДыБо 1
SELECT *
FROM student;

SELECT name, jumin
,decode(substr(jumin,7,1),'1','MAN',
               '2','WOMAN') as "Gender"
FROM student
WHERE deptno1 = '101';

SELECT substr(jumin,7,1)
FROM student
WHERE deptno1 = '101';

--decode ДыБо 2

SELECT name,tel
,decode(substr(tel,1,instr(tel,')')-1),'02','SEOUL',
'031','GYEONGGI',
'051','BUSAN',
'052','ULSAN',
'055','GYEONGNAM') as "LOC"
FROM student
WHERE deptno1 = '101';


SELECT substr(tel, 1, instr(tel, ')')-1)
FROM student
WHERE deptno1 = '101';

SELECT tel,instr(tel,')',-2)
FROM student
WHERE deptno1 = '101';