SELECT name,tel
,decode(substr(tel,1,instr(tel,')',1)-1),'02','SEOUL',
'031','GYEONGGI',
'051','BUSAN',
'052','ULSAN',
'055','GYEONGNAM','ETC') as "LOC"
--case when 援щЦ WHEN 議곌굔1 THEN 異쒕젰1 援щЦ
,CASE substr(tel,1,instr(tel,')',1)-1) WHEN '02' THEN 'SEOUL'
									   WHEN '031' THEN 'GYEONGGI'
									   WHEN '051' THEN 'BUSAN'
									   WHEN '052' THEN 'ULSAN'
									   WHEN '055' THEN 'GYEONGNAM'
									   ELSE 'ETC'    -- ELSE = �굹癒몄��씪�뒗 �쑜
									   END "Loc2"    -- END = 留덈Т由�
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

-- case 援щЦ�쓣 �솢�슜 議곌굔�쓽 踰붿쐞瑜� 吏��젙
-- 01 ~ 03 => 1/4, 04 ~ 06 => 2/4, 07 ~ 09 => 3/4, 10 ~ 12 4/4
SELECT name, substr(jumin,3,2) AS "MONTH"
,CASE WHEN substr(jumin,3,2) BETWEEN '01' AND '03' THEN '1/4'
	  WHEN substr(jumin,3,2) BETWEEN '04' AND '06' THEN '2/4'
	  WHEN substr(jumin,3,2) BETWEEN '07' AND '09' THEN '3/4'
	  WHEN substr(jumin,3,2) BETWEEN '10' AND '12' THEN '4/4'
	  END "QUARTER"
FROM student;

--123p �댁쫰
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
SELECT deptno, ename, count(*) "�씤�썝" , sum(sal) "遺��꽌蹂� 湲됱뿬"
FROM emp
GROUP BY deptno,ename; --遺��꽌踰덊샇蹂� 洹몃９

SELECT ename, job, hiredate
FROM emp
ORDER BY 1;

--emp �뀒�씠釉�
SELECT deptno,job, count(1) "嫄댁닔", sum(sal + nvl(comm,0)) "吏곷Т蹂� 湲됱뿬�빀怨�"
,round(sum(sal +nvl(comm,0))/count(1)) "吏곷Т蹂� �룊洹좉툒�뿬"
,round(avg(sal + nvl(comm,0))) "吏곷Т蹂� �룊洹좉툒�뿬1"
,min(sal + nvl(comm,0)) "理쒖�湲됱뿬"
,max(sal + nvl(comm,0)) "理쒓퀬湲됱뿬"
--,stddev(sal) "�몴以��렪李�"
--,variance(sal) "遺꾩궛"
FROM emp
GROUP BY deptno, job;

-- 吏곷Т蹂� 洹몃９
SELECT job
	   ,sum(sal)
	   ,round(avg(sal + nvl(comm,0))) "吏곷Т蹂� �룊洹좉툒�뿬"
FROM emp
--WHERE sal > 1500 -- where �젅 議곌굔臾� 
GROUP BY job								
--HAVING round(avg(sal + nvl(comm,0))) > 1500;-- having �젅 議곌굔臾몄� 援щ텇�빐�빞�븳�떎
UNION ALL  --�쐞 �븘�옒 �뿰寃�
SELECT '�쟾泥�'
      ,sum(sal)
      ,round(avg(sal + nvl(comm,0)))
FROM emp;

--遺��꽌/ 吏곷Т(�뾽)/ �젙蹂댁“�쉶(�룊洹좉툒�뿬, �궗�썝�닔)
--1. 遺��꽌蹂� 吏곷Т蹂� �룊洹좉툒�뿬, �궗�썝�닔
SELECT deptno||'', job, avg(sal), count(1)
FROM emp
GROUP BY deptno, job
UNION all
--2. 遺��꽌蹂� �룊洹좉툒�뿬, �궗�썝�닔
SELECT deptno||'', '�냼怨�', round(avg(sal)), count(1)
FROM emp
GROUP BY deptno
UNION all
--3.�쟾泥� �룊洹좉툒�뿬, �궗�썝�닔
SELECT '�쟾泥�','',round(avg(sal)),count(1)
FROM emp
order BY 1, 2;

-- rollup �븿�닔
SELECT nvl(deptno||'','�쟾泥�') AS "dept"
,decode(deptno, NULL,' ', nvl(job,'�냼怨�')) AS "job"
,round(avg(sal)) AS "avg_sal"
,count(1) AS "cnt_emp"
--,nvl(deptno,1) AS "order_by"
FROM emp
GROUP BY rollup(deptno,job)
ORDER BY nvl(deptno,1),1,2;

--emp, dept �뀒�씠釉�
SELECT empno,ename,e.deptno,dname,loc,d.deptno
FROM emp e  --driving �뀒�씠釉�
JOIN dept d ON e.deptno = d.deptno -- join 湲곗�
WHERE dname = 'ACCOUNTING'  -- ANSI 議곗씤
;

--�삤�씪�겢留� 媛��뒫�븳 諛⑹떇(�쐞�� 媛숈쓬)
SELECT empno,ename,e.deptno,dname,loc,d.deptno
FROM emp e  --driving �뀒�씠釉�
     ,dept d
WHERE e.deptno = d.deptno
AND dname = 'ACCOUNTING';
     
SELECT *
FROM dept;

--�븰�깮, 援먯닔, �븰怨� 議곗씤寃곌낵
--�븰踰�, �씠由�, �떞�떦援먯닔 �씠由�, �븰怨쇰챸
SELECT s.studno "�븰踰�"
,s.name "�븰�깮�씠由�"
,p.name "援먯닔�씠由�"
,d.dname "�븰怨쇰챸"
FROM student s
JOIN professor p ON s.profno = p.profno -- �븰�깮 - 援먯닔 �뀒�씠釉붿쓽 議곗씤 議곌굔
JOIN department d ON s.deptno1 = d.deptno; --�븰�깮 - �븰怨� �뀒�씠釉� 議곗씤

SELECT * 
FROM professor;

SELECT *
FROM department;

--�벑媛�議곗씤(equi join)
--怨좉컼�뀒�씠釉�()
SELECT c.*,g.gname
FROM customer c
JOIN gift g ON c.point BETWEEN g.g_start AND g.g_end;

--�쐞�� 媛숈� �쓽誘�
SELECT c.*,g.gname
FROM customer c
JOIN gift g ON c.point >= g.g_start AND c.point <= g.g_end;

SELECT * 
FROM gift;

--鍮꾨벑媛�議곗씤(Non-equi join)
--�븰�깮, �븰�젏
SELECT s.studno "�븰踰�"
	   ,s.name "�븰�깮�씠由�"
	   ,c.total "�젏�닔"
	   ,h.grade "�븰�젏"
FROM student s
JOIN score c ON s.studno = c.studno
JOIN hakjum h ON c.total >= h.min_point AND h.max_point >= c.total;

SELECT *
FROM score;

SELECT *
FROM hakjum;

--254p 1踰�
--ANSI Join 臾몃쾿
SELECT s.name "STU_NAME"
,s.deptno1 "DEPTNO1"
,d.dname "DEPT_NAME"
FROM  student s
JOIN department d ON s.deptno1 = d.deptno;
--Oracle Join 臾몃쾿
SELECT s.name "STU_NAME"
,s.deptno1 "DEPTNO1"
,d.dname "DEPT_NAME"
FROM student s
    ,department d
WHERE s.deptno1 = d.deptno;

SELECT *
FROM department;

--254p 2踰�
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

--255p 3踰�
SELECT name
,trunc(months_between(sysdate,e2.birthday)/12) "AGE"
,e2.POSITION "CURR_POSITION"
,p.POSITION "BE_POSITION"
FROM emp2 e2
JOIN p_grade p ON  trunc(months_between(sysdate,e2.birthday)/12) BETWEEN p.s_age AND p.e_age;

--�깮�씪 �뜲�씠�꽣 �뒛由ш린
UPDATE emp2
SET birthday = add_months(birthday, -12)
WHERE 1=1;

--outer join(�븘�슦�꽣議곗씤) vs inner join(�씠�꼫 議곗씤) => join留� �벐�뒗 寃�
SELECT s.studno "�븰踰�"
,s.name "�븰�깮�씠由�"
,p.profno "援먯닔�씠由�"
,p.name "援먯닔�씠由�"
FROM student s
full OUTER JOIN professor p ON s.profno = p.profno;
-- left outer => student(from 履�) �뀒�씠釉� 湲곗�, right outer => (join 履�)professor �뀒�씠釉� 湲곗�
-- full outer => �쟾泥� �뀒�씠釉� 湲곗�

--self join(���봽 議곗씤) => �뀒�씠釉� �븯�굹濡� join�븯�뒗 寃�
SELECT e1.empno "�궗�썝踰덊샇"
,e1.ename "�궗�썝�씠由�"
,e2.empno "愿�由ъ옄 踰덊샇"
,e2.ename "愿�由ъ옄 �씠由�"
FROM emp e1
left OUTER JOIN emp e2 ON e1.mgr  = e2.empno;

SELECT count(*) FROM emp;

--p255 4踰�
SELECT *
FROM customer;

SELECT *
FROM gift;

SELECT c.gname "CUST_NAME"
,c.point "POINT"
,'Notebook' "GIFT_NAME"
FROM customer c
JOIN gift g ON c.point between g.g_start and g.g_end
WHERE c.point >= 600000;

--256p 5번 문제
SELECT p1.profno, p1.name
, case when substr(p1.hiredate,1,2) between '27' and '99' then '19'||p1.hiredate
else '20'||p1.hiredate
end hiredate
,count(1)
from professor p1
left outer join professor p2 on p1.name = p2.name
order by p1.hiredate;
--count 추가를 어떻게 하는지 모르겠네

--257p 6번
SELECT e1.empno,e1.ename, e1.hiredate
from emp e1
join emp e2 on e1.ename = e2.ename
order by e1.hiredate;