-- set
-- UNION (중복데이터는 출력하지 않는다)
-- 회원(member) 테이블에 있는 user_id, 직원(employees)테이블에 있는 employee_id에 원하는 아이디가 있는지 확인하자.
/*
    SELECT
        user_id
    FROM members
    WHERE user_id = 'highland0'
*   UNION
    SELECT
        employee_id
    FROM employees
    WHERE employee_id = 'highland0';
*/

-- 문제) 직원에 있는 사원번호와 직무를 출력하고 직무연역테이블(job_history)에 있는 사원번호와 직무를 출력하시오.
SELECT
    employee_id, job_id
FROM HR.employees e
UNION
SELECT
    employee_id, job_id
FROM HR.job_history j;

-- UNION ALL 중복데이터 포함하여 출력
SELECT
    employee_id, job_id
FROM HR.employees e
UNION ALL
SELECT
    employee_id, job_id
FROM HR.job_history j;

-- 'highland0' 이라는 사용자가 employees와 job_history에 등록된 사용자인지 확인하시오.
SELECT
    employee_id
FROM HR.employees
WHERE employee_id = 'highland0'
UNION
SELECT
    employee_id
FROM HR.job_history
WHERE employee_id = 'highland0';

-- '102' 이라는 사용자가 employees와 job_history에 등록된 사용자인지 확인하시오.
SELECT
    employee_id
FROM HR.employees
WHERE employee_id = 102
UNION
SELECT
    employee_id
FROM HR.job_history
WHERE employee_id = 102;

-- 문제) employees(영화), job_history(상품) 
-- employee_id(구매자)
-- hire_date(구매날짜), start_date(구매날짜)
-- job_id(상품번호)
SELECT
    job_id, hire_date, '영화' "카테고리"
FROM HR.employees
WHERE employee_id = 102
UNION
SELECT
    job_id, start_date, '상품'
FROM HR.job_history
WHERE employee_id = 102;


-- 문제) 직원 테이블에서는 부서번호, 입사일을 출력하고 부서 테이블에서는 부서번호, 지역코드를 출력하시오.
SELECT
    department_id, hire_date, to_number(null) location_id
FROM HR.employees
UNION
SELECT
    department_id, to_date(null), location_id
FROM HR.departments;


desc HR.employees;
desc HR.departments;
desc HR.job_history;

-- 문제) 직원테이블에서 직원번호, 직무, 급여를 출력하는데 직무가 'REP'를 포함하여야 한다.
-- 직무내역 테이블에서는 직원번호 직무를 출력하는데 급여 대신 0을 출력하는데 직무 시작 년도가 '2005'년 이어야 한다.
SELECT
    employee_id, job_id, salary, hire_date, 'employees'
FROM HR.employees
WHERE job_id like '%REP%'
UNION
SELECT
    employee_id, job_id , 0, start_date, 'job_history'
FROM HR.job_history
WHERE to_char(start_date, 'yyyy') = 2002;

