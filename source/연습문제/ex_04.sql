CREATE TABLE my_employees
AS
SELECT * FROM HR.employees;

CREATE TABLE my_departments
AS
SELECT * FROM HR.departments;

CREATE TABLE my_locations
AS
SELECT * FROM HR.locations;

CREATE TABLE my_jobs
AS
SELECT * FROM HR.jobs;

CREATE TABLE my_job_history
AS
SELECT * FROM HR.job_history;

SELECT
    *
FROM my_employees;

SELECT
    *
FROM my_departments;

SELECT
    *
FROM my_locations;

SELECT
    *
FROM my_job_history;



--문제) 부서정보를 출력할 때 부서가 있는 주소를 출력하자.
--      street_address(부서가 있는 주소)
--      부서번호, 부서명, 위치코드, 주소
SELECT
    d.department_id, d.department_name, d.location_id, l.street_address
FROM my_departments d JOIN my_locations l
ON d.location_id = l.location_id;


--문제) 직원정보를 출력하데 직원 어느 부서에서 근무하는지
--부서명을 출력하시오. 
--성, 직원번호, 부서번호, 부서명, 지역코드
SELECT
    e.last_name, e.employee_id, d.department_id, d.department_name, d.location_id
FROM my_employees e JOIN my_departments d
ON e.department_id = d.department_id;


--문제) 직원의 정보를 출력할 때 부서정보와 그 부서의 주소를 출력하시오.
SELECT
    e.last_name, e.employee_id, d.department_id, d.department_name, d.location_id
FROM my_employees e JOIN my_departments d
ON e.department_id = d.department_id;

--문제) 위 문제에서 부서번호가 90인 직원정보만 출력하시오.
SELECT
    e.last_name, e.employee_id, d.department_id, d.department_name, d.location_id
FROM my_employees e JOIN my_departments d
ON e.department_id = d.department_id
WHERE e.department_id = 90;


--문제) 직무정보 : jobs : job_title(직무내용)
--      직원정보 : employees
--직원 정보를 출력할 그 직원이 하는 역할 대한 정보도 
--출력하시오. 직원번호 성 직무번호 직무내용
SELECT
    e.employee_id, e.last_name, e.job_id, j.job_title
FROM my_employees e JOIN my_jobs j
ON e.job_id = j.job_id;


--문제) 직원정보와 부서정보를 출력하시오.
--직원번호, 성, 부서번호, 부서명
SELECT
    e.employee_id, e.last_name, d.department_id, d.department_name
FROM my_employees e JOIN my_departments d
ON e.department_id = d.department_id;

--문제) 직원정보를 출력할 때 그 직원의 부서정보와 그 직원의 직무내용을 출력하시오.
--      부서번호, 부서명, 직무번호, 직무내용
SELECT
    e.employee_id, e.last_name, d.department_id, d.department_name, j.job_id, j.job_title
FROM my_jobs j JOIN my_employees e
ON j.job_id = e.job_id JOIN my_departments d
ON e.department_id = d.department_id;

--문제) 직무정보 jobs
--      직무기록 job_history
--      사원정보 employees
--직원정보와 직원 어떠한 직무 했는지에 대해서 출력하시오.
--직무히스토리 : 직무번호, start_date와 end_date
--직원정보 : 직원번호 , 성, 
--직무정보 : 직무내용
SELECT
    e.employee_id, e.last_name, j1.job_title, j2.job_id, j2.start_date, j2.end_date
FROM my_employees e JOIN my_jobs j1
ON e.job_id = j1.job_id JOIN my_job_history j2
ON j1.job_id = j2.job_id;

SELECT
    *
FROM my_employees;

--문제) 직원정보와 부서정보를 출력하시오.
-- 직원번호, 성, 부서번호, 부서명 (T-SQL, ansi 모두)
SELECT
    e.employee_id, e.last_name, d.department_id, d.department_name
FROM my_employees e JOIN my_departments d
ON e.department_id = d.department_id;


--문제) 위 문제에서는 부서가 있는 사원만 출력되었다.
--그러므로 부서가 없는 직원 출력이 되지 않았다.
--부서가 없는 직원도 출력되게 하시오.
--직원번호, 성, 부서번호, 부서명
SELECT
    e.employee_id, e.last_name, d.department_id, d.department_name
FROM my_employees e LEFT OUTER JOIN my_departments d
ON e.department_id = d.department_id;

--문제) 직원의 직원정보와 직무내역을 출력하는 직무내역이 없는 직원도 출력하시오.
SELECT
    *
FROM my_employees e LEFT OUTER JOIN my_job_history j
ON e.job_id = j.job_id;

--문제) 직원정보 부서정보도 같이 출력하자. 
--단, 부서가 없는 직원도 출력을하고 직원이 없는 부서도 출력하자.
SELECT
    *
FROM my_employees e FULL OUTER JOIN my_departments d
ON e.department_id = d.department_id;

--문제)부서가 없는 직원 출력
SELECT
    *
FROM my_employees
WHERE employee_id = (
    SELECT
        employee_id
    FROM my_employees
    WHERE department_id is null
);

--문제)직원이 없는 부서를 출력하시오.
SELECT
    department_id
FROM my_employees
WHERE department_id is not null;

SELECT
    *
FROM my_departments;
    
SELECT
    *
FROM my_departments
WHERE department_id not in (
    SELECT
        department_id
    FROM my_employees
    WHERE department_id is not null
)
order by department_id
;

--문제) 성이 Abel이라는 사람의 급여가 있다
SELECT
    *
FROM my_employees
WHERE salary = (
    SELECT
        salary
    FROM HR.employees
    where last_name = 'Abel'
);

--문제) 직원번호가 141인 직원의 직무 같은 직무를 하는 직원들을 출력하시오.
SELECT
    *
FROM my_employees
WHERE job_id = (
    SELECT
        job_id
    FROM my_employees
    WHERE employee_id = 141
);


--문제) 사원번호가 143인 사원 급여보다 큰 급여를 가진 직원을 출력하시오.
SELECT
    salary
FROM my_employees
WHERE employee_id = 143;

SELECT
    *
FROM my_employees
WHERE salary > (
    SELECT
        salary
    FROM my_employees
    WHERE employee_id = 143
)
order by salary;

--문제) 141번 사원의 직무와 같고  143번사원 급여보다 큰 급여를 가진 직원 누구인가?
SELECT
    *
FROM my_employees
WHERE job_id = (
    SELECT
        job_id
    FROM my_employees
    WHERE employee_id = 141
)
AND salary > (
    SELECT
        salary
    FROM my_employees
    WHERE employee_id = 143
)
order by salary;

--문제) 전체 급여에 평균급여보다 큰 직원들을 구하시오.
SELECT
    *
FROM my_employees
WHERE salary > (
    SELECT
        avg(salary)
    FROM my_employees
);


--문제) 이름이 Nancy인 사원의 직무와 같고 커미션이 없는 직원을 하시오.
SELECT
    *
FROM my_employees
WHERE job_id = (
    SELECT
        job_id
    FROM my_employees
    WHERE first_name = 'Nancy'
)
AND commission_pct is null
;

--문제) 커미션이 있고 급여가 Nancy보다 큰 직원은 누구입니까?
SELECT
    *
FROM my_employees
WHERE salary > (
    SELECT
        salary
    FROM my_employees
    WHERE first_name = 'Nancy'
)
AND commission_pct is not null
;

--문제) 성이 'Olsen'인 직원의 직무와 같지 않은 직원을 출력하시오.
SELECT
    *
FROM my_employees
WHERE job_id != (
    SELECT
        job_id
    FROM my_employees
    WHERE last_name = 'Olsen'
);

--문제) 이름이 'Christopher'인 직원과 같은 해에 입사한 직원을 출력하시오.
SELECT
    *
FROM my_employees
WHERE to_char(hire_date, 'yyyy') = (
    SELECT
        to_char(hire_date, 'yyyy')
    FROM my_employees
    WHERE first_name = 'Christopher'
);

--문제) 성이 'Olsen'인 직원의 직무와 같지 않은 직원이면서 이메일이 'TRAJS'인사원보다 급여를 작게 받는 직원은?
SELECT
    *
FROM my_employees
WHERE job_id != (
    SELECT
        job_id
    FROM my_employees
    WHERE last_name = 'Olsen'
)
AND salary < (
    SELECT
        salary
    FROM my_employees
    WHERE email = 'TRAJS'
);

--문제) 부서명이 'IT'인 직원을 출력하시오.
SELECT
    department_id, department_name
FROM my_departments
WHERE department_name = 'IT';

SELECT
    *
FROM my_employees
WHERE department_id in (
    SELECT
        department_id
    FROM my_departments
    WHERE department_name = 'IT'
);

--문제) 60인 부서의 최저 급여와 같은 직원들을 구하시오.
SELECT
    *
FROM my_employees
WHERE salary = (
    SELECT
        MIN(salary)
    FROM my_employees
    WHERE department_id = 60
);

--문제) 각 부서의 최저 급여가 60인 부서의 최저급여보다 큰 부서와 부서의 최저급여를 구하시오.
SELECT
    MIN(salary)
FROM my_employees
WHERE department_id = 60;

SELECT
    department_id, MIN(salary)
FROM my_employees
GROUP BY department_id
HAVING MIN(salary) > (
    SELECT
        MIN(salary)
    FROM my_employees
    WHERE department_id = 60
);

--문제) 50인 부서의 평균급여보다 큰 직원들을 구하시오.
SELECT
    avg(salary)
FROM my_employees
WHERE department_id = 50;

SELECT
    *
FROM my_employees
WHERE salary > (
    SELECT
        avg(salary)
    FROM my_employees
    WHERE department_id = 50
)
order by salary;

--문제) 50부서의 최대급여보다 각 부서의 평균 급여가 더 큰 부서를 구하시오.
SELECT
    MAX(salary)
FROM my_employees
WHERE department_id = 50;

SELECT
    department_id, AVG(salary)
FROM my_employees
GROUP BY department_id
HAVING AVG(salary) > (
    SELECT
        MAX(salary)
    FROM my_employees
    WHERE department_id = 50
);

--문제) 평균 급여가 가장 작은 직무를 찾으시오.
SELECT
    AVG(salary), job_id
FROM my_employees
GROUP BY job_id;

--문제) 각 부서에서 최저 급여를 갖는 직원들을 구하시오.
--
--문제)'IT_PROG'인 직무를 가진 직원의 급여와 같은 급여를 가진 직원들을 구하시오.
--
--문제)'IT_PROG'인 직무를 가진 직원의 급여와 같은 급여를 가진 직원이면서 커미션을 가진 직원만 출력하시오.
--
--문제)  'IT_PROG'인 직무를 가진 직원의 급여에서 최대 급여보다 작은 급여를 받는 직원들 중 직무가 'IT_PROG'인 직원들을 제외한 나머지 직원들을 출력하시오.
--
--
--문제) 'IT_PROG'인 직무를 가진 직원의 급여와 같지 않은 
-- 급여를 받는 직원은?
--
--
--문제) 직원 테이블에서는 부서번호, 입사일을 출력하고
--      부서 테이블에서는 부서번호, 지역코드를 출력하시오.
--
--
--문제) 직원테이블에서는 직원번호, 입사일
--      직무내역테이블에서는 직원번호, 시작일을 출력하시오.
--
--
-----이하 쿼리문을 실행 시켜서 insert를 해 보세요..
--insert into departments (department_id, department_name,manager_id, location_id)
--values (280, 'smrit_404', 100, 1700);
--
--insert into departments (department_name,  location_id,manager_id, department_id)
--values('smrit_405', 1710, 110, 290);
--
--insert into departments (department_id, department_name)
--values (300,'smrit_406');
--
--insert into departments values(310, '유근학실' , 120, 1800);
--
--
--INSERT INTO employees (employee_id, 
--                 first_name, last_name, 
--                 email, phone_number,
--                 hire_date, job_id, salary, 
--                 commission_pct, manager_id,
--                 department_id)
--values(400, 
--       'Louis', 'Popp', 
--       'LPOPP', '123.1234.1234',
--       sysdate, 'AC_ACCOUNT', 6900, 
--       null, 205, 100);
--
--
--insert into departments values(320, '차현지 연구실' , null, null);
--
--
--INSERT INTO employees 
--values (401, 'Den', 'Raphealy',
--        'DRAPHEAL' , '987.987.9874',
--       to_date('05-20-2019','MM-DD-RR'),  
--      'AC_ACCOUNT', 11000, NULL, 100, 30);
--
--INSERT INTO employees 
--values (402, '근학', '유',
--        '차현진' , '987.987.9874',
--        to_date('5월 23, 2019','MON DD, RR'),                   'AC_ACCOUNT', 11000, NULL, 100, 30);
--
