-- 문제 ) 사원번호, 이름, 직무, 급여, 입사일을 출력하는 데 입사한 년도 가 윤년인지 아닌지 출력하시오.
-- 4년마다는 윤년이고 100년마다는 윤년이 아니다 그러나 400년마다 윤년이 된다.
SELECT
    employee_id, last_name, job_id, salary, hire_date, to_char(hire_date, 'yyyy'),
    CASE WHEN MOD(to_char(hire_date, 'yyyy') , 4) = 0 
        AND MOD(to_char(hire_date, 'yyyy') , 100) != 0 
        OR MOD(to_char(hire_date, 'yyyy') , 400) = 0
        THEN '윤년'
        ELSE '윤년아님' END YEAR
FROM employees;

SELECT
    employee_id, last_name, job_id, salary, hire_date, to_char(hire_date, 'yyyy')
FROM employees;

-- 문제 ) 직원이 입사한 날의 요일 번호와 그 달의 마지막 날과 요일을 출력하시오.

SELECT
    employee_id, first_name, job_id, salary, last_day(hire_date) "달의 마지막 날", to_char(hire_date, 'day') "요일", to_char(hire_date, 'd') "요일 Number"
FROM employees;

SELECT
    1 || 1 + 10
FROM dual;

-- 문제 ) 사원번호, 이름, 직무, 급여, 입사일을 출력하는데 날짜를 세기년-월-일-시:분:초 로 출력하시오.
SELECT
    employee_id, first_name, job_id, salary, to_char(hire_date, '  yyyy-mm-dd hh24 : mi : ss am')
FROM employees;

-- 문제 ) 사원번호, 이름, 직무, 입사일, 급여를 3자리마다 콤마를 찍고 우리나라의 통화와 마이너스(-)가 있는 경우 뒤에 "-"를 붙이도록 한다.
SELECT
    employee_id, first_name, job_id, hire_date, trim(to_char(salary, 'L999,999,999MI')) salary
FROM employees;

-- 문제 ) 사원번호, 이름, 직무, 급여, 입사일을 출력하는데 날짜를 2020년 5월 20일 12시:분:초 오전으로 출력하시오.
SELECT
    employee_id, first_name, job_id, salary, to_char(hire_date, ' yyyy"년" mm"월" dd"일" | hh12 : mi : ss am') "년 월 일 붙이기"
FROM employees;

-- 문제 ) 2002년도 이후에 입사한 사원들을 출력하시오.
SELECT
    employee_id, first_name, job_id, salary, hire_date
FROM employees
WHERE to_char(hire_date, 'yyyy') > 2002 ;

-- 중첩 함수
-- 문제 ) 각 부서별 평균급여 중 최대 값을 출력하시오.
SELECT
    MAX(AVG(salary))
FROM employees
GROUP BY department_id;

SELECT
    department_id, AVG(salary)
FROM employees
GROUP BY department_id
HAVING AVG(salary) = (
    SELECT
        MAX(AVG(salary))
    FROM employees
    GROUP BY department_id
);

-- 문제 ) 성 이름의 급여는 3000이고 커미션은 0.03 입니다. 를 출력하는데 (concat을 사용)
SELECT
    CONCAT(last_name, CONCAT(first_name, CONCAT('의 급여는 ', CONCAT(salary ,CONCAT('이고 커미션은 ', CONCAT(nvl(commission_pct,0), '입니다')))))) "머지"
FROM employees;

-- 문제 ) 성과 상사를 출력하는데 상사가 없으면 'No Manager'로 출력되게 하자.
SELECT
    last_name, nvl(to_char(manager_id), 'No Manager')
FROM employees;

-- 문제 ) 커미션을 포함한 급여의 연봉을 구하시오.
SELECT
    (salary + (salary * nvl(commission_pct, 0))) * 12 yearsal
FROM employees;

-- 문제 ) 급여가 12000이상이면 '이사'
--              10000 이상이면 '부장'
--              7000 이상이면 '차장'
--              4000 이상이면 '과장'
--              3000 이상이면 '대리'
--              그 외 '사원'
SELECT
    last_name, job_id, salary,
    CASE 
        WHEN salary >= 12000 THEN '이사'
        WHEN salary >= 10000 THEN '부장'
        WHEN salary >= 7000 THEN '차장'
        WHEN salary >= 4000 THEN '과장'
        WHEN salary >= 3000 THEN '대리'
    ELSE '사원' END "직급"
FROM employees;

-- 문제 ) departments 에서 사원이 있는 부서의 수를 구하시오. 조인제외
SELECT
    COUNT(manager_id)
FROM departments;

SELECT
--    to_char(salary, 'fm$999,999,000'), trim(to_char(salary, '$999,999,00'))
    rpad(last_name, 8) || ' ' || rpad(' ', salary/1000+1, '*'), salary
FROM employees;

-- 

SELECT
    e.department_id, e.last_name, c.last_name
FROM employees e JOIN employees c
ON (e.department_id = c.department_id)
WHERE e.employee_id <> c.employee_id
ORDER BY e.department_id, e.last_name, c.last_name













