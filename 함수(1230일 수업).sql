SELECT * FROM tab;

SELECT empno,ename,sal,nvl(comm,0) AS commission
FROM emp;

SELECT initcap(position) AS "InitCap", upper(POSITION) AS "Uppercase", lower(position) AS "Lowercase"
, length(position) AS "Length_position" -- 문자의 크기 반환 
,lengthb('홍길동') AS "Lengthb" --byte의 크기를 반환
,name
FROM professor
WHERE LENGTH(name) < 10;

SELECT ename ||','|| job AS "Name And Job"
,concat(concat(ename,','),job) AS "Name Job"
,substr(e.job,1,3) AS "short Job"
,e.*
FROM emp e
WHERE substr(e.ename,1,1) = 'J';

SELECT substr('abcde',1,2) -- (abcde, 시작위치, 크기)
,substr('hello, world',-3,3) -- -(마이너스)=뒤에서부터
FROM dual;

SELECT ename
FROM emp e
WHERE substr(e.ename,1,1) = 'J';

--전공1(201) 연락처에(TEL칼럼) ')'위치
SELECT  name
--,instr(tel,')',1) "location of )"
,tel
,instr(tel, ')', 1)+1 AS "from"
,instr(tel,'-',1) AS "to"
,substr(tel, instr(tel, ')', 1)+1,(instr(tel,'-',1)-(instr(tel,')',1)+1))) AS "AREA CODE"
FROM student
WHERE deptno1 = 201
AND substr(tel, 1, instr(tel, ')', 1)-1) = '02';

--lpad(컬럼, 자리수 , 채울값) --부족한 값은 왼쪽부터 채운다 --오른쪽부터 채울려면 rpad
SELECT lpad('abc', 5, '-')
FROM dual;

SELECT studno
,name
,id
,lpad(id,10,'*') AS "Lpad WITH *"
FROM student
WHERE deptno1 = 201;

SELECT lpad(ename,9,'12345678') AS "lpad"
,rpad(ename,9,'-') AS "rpad"
FROM emp
WHERE deptno = 10;

SELECT lengthb(ename) 
,RPAD(ename,9,substr('123456789',lengthb(ename)+1)) AS "rpad"
,substr('123456789',LENGTH(ename)+1) as"rep"
FROM emp
WHERE deptno = 10;

SELECT ltrim('abcde','abc')
,rtrim('abcde','cde')
,rtrim(ltrim(' hello ',' '),' ') --'hello '  --좌우 공백 제거
,replace(' hello ',' ','*') -- 대채한다
FROM dual;

SELECT REPLACE(e.ename, substr(e.ename,1,2),'**') AS "rep"
,replace(e.ename, substr(e.ename,2,2),'**') AS "rap2"
, e.job
, e.*
FROM emp e
WHERE deptno =10;

SELECT name,jumin
,replace(std.jumin, substr(std.jumin,-7,7),'-/-/-/-') AS "REPLACE"
FROM student std
WHERE deptno1 = 101;

SELECT name,tel
,replace(std.tel
	,substr(std.tel,(instr(std.tel,')',1)+1),((instr(std.tel,'-',1))-((instr(std.tel,')',1)+1))))
	,substr('****', 1 ,instr(std.tel,'-',1)-(instr(std.tel,')',1)+1))) AS "REPLACE"  --instr(std.tel,'-',1)-(instr(std.tel,')',1)+1) 크기
FROM student std
WHERE deptno1 = 201;

SELECT name,tel
,replace(std.tel, substr(std.tel,-4,4),'****') AS "REPLACE"
FROM student std
WHERE deptno1 = 101;

--숫자함수.
SELECT round(12.345, 1) --12.3
,round(12.345, 2)  --12.35
,round(12.345, 3)  --12.345
,round(12.345,-1)  --10
,trunc(12.345, 2)  --12.34
,mod(12,5)  --2
,ceil(12/5) --3 < 2.4 < 2 소수점 반올림
,floor(12/5)  --3 < 2.4 < 2 소수점버림
,power(3,3)  --27  3의 3승(3*3*3)
FROM dual; 

--날짜
SELECT ename
,hiredate
,hiredate +1
,sysdate --시스템의 날짜와 시간
,months_between(sysdate, hiredate) --두 시간 사이에 몇달 차
,ADD_MONTHS(sysdate,-1)  --월 정보 추가
,NEXT_DAY(sysdate-7, '수') --다음 요일의 날짜()
,LAST_DAY(add_months(sysdate,-1))
,round(sysdate-(3/24))  --12/30 12시 이후 => 12/31
,trunc(sysdate, 'mm')  --2025/12/30 
FROM emp;


SELECT * 
FROM professor -- 2025 ,1982
WHERE hiredate< sysdate;

UPDATE professor
SET hiredate = ADD_MONTHS(hiredate, -40*12)
WHERE hiredate > sysdate;

--교수번호(profno),이름(name),급여(pay),보너스(bonus)
--근무년수 20년에 넘는 교수. +근무년수(25년)
--근무년수가 10년 이상 20년 미만인 교수의 "15년 3개월"
SELECT profno
,name
,pay ||'만원' AS "pay"
,bonus || '만원' AS "bonus"
,trunc(MONTHS_BETWEEN(sysdate,hiredate)/12)||'년'||  --근무일수 (년)
MOD(trunc(MONTHS_BETWEEN(sysdate,hiredate)),12)||'개월' AS "근무일수" --근무일수 (개월) 12로 나눠서 남은 값이 개월이니깐
FROM professor
WHERE MONTHS_between(sysdate,hiredate) < 20*12
AND MONTHS_between(sysdate,hiredate)>= 10*12
ORDER BY hiredate;

SELECT 2+'2'  "묵시적 형변환"
,2+to_number('2') "명시적 형변환"
FROM dual;

SELECT sysdate --date값 
,to_char(sysdate,'YYYY-MM-DD HH24:MI:SS') "today"--varchar2 값
,to_char(123456789.12,'00,999,999,999.99') "num"--varchar2 값
,to_date('2024-04-05 10:10:10','YYYY-MM-DD HH:MI:SS') "str"-- date 값
FROM dual
WHERE to_date('2025-12-31','YYYY-MM-DD') < sysdate +1;

-- nvl()
SELECT nvl('hello','0')
FROM dual;

SELECT ename
,'급여: '||sal||'원 + 보너스: '||nvl(comm,0)||'원 = '|| (sal + nvl(comm,0))||'원' AS "총급여"
,sal + nvl2(comm,comm,0) AS "전체급여"
,nvl2(comm,sal + comm,sal) AS "토탈급여"
FROM emp;
--WHERE sal + nvl(comm,0) > 2000;

--decode() 함수
SELECT decode(null,'null','같다','다르다')
FROM dual;

/*
101	Computer Engineering
102	Multimedia Engineering
103	Software Engineering
*/
SELECT deptno1 
,decode(deptno1,101,'Computer Engineering',
				102,'Multimedia Engineering',
				103,'Software Engineering','ETC') AS "decode1"
,decode(deptno1,101,'Computer Engineering',
	decode(deptno1,102,'Multimedia Engineering',
		decode(deptno1,103,'Software Engineering','ETC'))) AS "Dept"
FROM student;


SELECT * FROM department;