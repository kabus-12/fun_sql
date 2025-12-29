SELECT *
FROM tab;

SELECT *
FROM employees;
--WHERE job_id = 'IT_PROG'
--WHERE employee_id = 103;

SELECT *
FROM jobs;

SELECT *
FROM departments;

SELECT *
FROM employees
WHERE 1=1 
--AND department_id = 50
--급여가 10000초과하는 사람들 조회
AND salary + salary*nvl(commission_pct , 0) > 10000;
--급여가 10000초과하는 사람들 조회 --위랑 같은 뜻
--AND (salary *commission_pct) + salary > 10000
--OR salary > 10000;


