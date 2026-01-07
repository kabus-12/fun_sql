-- 1.
select employee_ID, last_name 
,salary 
,department_id 
from employees
where last_name like 'H%' and salary BETWEEN 7000 and 12000;

-- 2.
select employee_id, first_name||' '||last_name "NAME",job_id,salary,department_id
from employees
where department_id between 50 and 60
and salary > 5000;

-- 3.
select first_name||' '||last_name,salary
,CASE WHEN salary BETWEEN 0 and 5000 THEN salary + salary * 0.2
     WHEN salary BETWEEN 5001 and 10000 THEN salary + salary * 0.15
     WHEN salary BETWEEN 10001 and 15000 THEN salary + salary * 0.1
     ELSE salary
     END "salary_bonus"
FROM employees;

-- 4.
select d.department_id,d.department_name,l.city
from departments d
join locations l on d.location_id = l.location_id;

-- 5.
select employee_id,last_name,job_id
from employees
where department_id = 60;

-- 6.
select *
from employees
where job_id = 'ST_CLERK'
and hire_date < '14/01/01';

-- 7.
select last_name,job_id,salary,commission_pct
from employees
where commission_pct > 0
ORDER by -salary;

-- 8.
create table PROF(
PROFNO number(4)
,NAME varchar2(15) not null
,ID varchar2(15) not null
,HIREDATE date
,PAY number(4)
);

SELECT *
from prof;

-- 9.
SELECT *
from prof;

insert into prof
VALUES(1001,'Mark','m1001','07/03/01',800);

insert into prof(profno,name,id,hiredate)
VALUES(1003,'Adam','a1003','11/03/02');

update prof
set pay = 1200
where profno = 1001;

delete from prof
where profno = 1003;

-- 10.
SELECT * from prof;

ALTER table prof ADD CONSTRAINT prof_profno_pk PRIMARY KEY(PROFNO);

ALTER TABLE prof ADD (GENDER CHAR(3));

ALTER TABLE prof MODIFY name varchar2(20);

