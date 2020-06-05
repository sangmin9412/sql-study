SELECT
    e.employee_id, e.department_id, d.department_name
FROM HR.employees e FULL OUTER JOIN HR.departments d
ON e.department_id = d.department_id
WHERE e.employee_id is null;

SELECT
    distinct manager_id
FROM HR.employees;

SELECT
    e.employee_id, e.last_name, m.employee_id
FROM HR.employees e JOIN  HR.employees m
ON e.employee_id = m.manager_id
WHERE m.employee_id = 101
;

-- 서브쿼리 (SubQuery)

-- 'Abel'의 급여와 같은 사원을 출력하시오.
SELECT
    salary
FROM HR.employees
WHERE last_name = 'Abel';

SELECT
    last_name
FROM HR.employees
WHERE salary = 11000;

SELECT
    *
FROM HR.employees
WHERE salary = (
    SELECT
        salary
    FROM HR.employees
    WHERE last_name = 'Abel'
);

-- 'Abel'의 급여 보다 큰 사원을 출력하시오.
SELECT
    *
FROM HR.employees
WHERE salary >= (
    SELECT
        salary
    FROM HR.employees
    WHERE last_name = 'Abel'
);

-- 120번 사원의 직무와 같고 121번 사원의 급여보다 큰 사원들을 출력하시오.
SELECT
    *
FROM HR.employees
WHERE job_id = (
    SELECT
        job_id
    FROM HR.employees
    WHERE employee_id = 120
)
AND salary < (
    SELECT
        salary
    FROM HR.employees
    WHERE employee_id = 121
)
;

-- 직무에 'SA'를 포함하고 있는 직무의 최저 급여보다 작은 사원을 출력하시오.
SELECT
    *
FROM HR.employees
WHERE salary < (
    SELECT
        min(salary)
    FROM HR.employees
    WHERE job_id like '%SA%'
);

-- 90인 부서의 평균 급여보다 크고 직무가 140번의 직무와 같은 사원들을 출력하시오.
SELECT
    avg(salary)
FROM HR.employees
WHERE department_id = 50;

SELECT
    job_id
FROM HR.employees
WHERE employee_id = 140;

SELECT
    *
FROM HR.employees
WHERE salary > (
    SELECT
        avg(salary)
    FROM HR.employees
    WHERE department_id = 50
) 
AND job_id = (
    SELECT
        job_id
    FROM HR.employees
    WHERE employee_id = 140
);

-- 부서가 없는 직원의 직무와 같은 일을 하는 사원을 출력하시오.
SELECT
    job_id
FROM HR.employees
WHERE department_id is null;

SELECT
    *
FROM HR.employees
WHERE job_id = (
    SELECT
        job_id
    FROM HR.employees
    WHERE department_id is null
);

-- 문제) 이름이 Nancy인 사원의 직무와 같고 커미션이 없는 직원을 출력하시오.
SELECT
    *
FROM HR.employees
WHERE job_id = (
    SELECT
        job_id
    FROM HR.employees
    WHERE first_name = 'Nancy'
)
AND commission_pct is null;

-- 문제) 성이 'Abel'인 직원의 직무와 같지 않은 직원을 출력하시오.
SELECT
    *
FROM HR.employees
WHERE job_id != (
    SELECT
        job_id
    FROM HR.employees
    WHERE last_name = 'Abel'
);

-- 문제) 성이 'Abel'인 직원과 같은 해에 입사한 직원을 출력하시오.
SELECT
    *
FROM HR.employees
WHERE to_char(hire_date, 'yyyy') = (
    SELECT
        to_char(hire_date, 'yyyy')
    FROM HR.employees
    WHERE last_name = 'Abel'
);

-- 문제) 부서명이 'Marketing'인 부서의 사원들을 출력하시오
SELECT
    *
FROM HR.departments
WHERE department_name = 'Marketing'
;
    
SELECT
    *
FROM HR.employees e
WHERE department_id = (
    SELECT
        department_id
    FROM HR.departments
    WHERE department_name = 'Marketing'
);

-- 성이 'Hunold'인 사원의 직무와 같고 이메일이 'JURMAN'인 사원의 부서에 있는 사원을 출력하시오.
SELECT
    *
FROM HR.employees
WHERE last_name = 'Hunold';

SELECT
    *
FROM HR.employees
WHERE email = 'JURMAN';

SELECT
    *
FROM HR.employees
WHERE job_id = (
    SELECT
        job_id
    FROM HR.employees
    WHERE last_name = 'Hunold'
)
AND employee_id = (
    SELECT
        employee_id
    FROM HR.employees
--    WHERE email = 'JURMAN'
    WHERE email = 'AHUNOLD'
);

-- 문제) 부서가 80이면서 직무가 'SA_REP' 사원의 평균 급여보다 큰 사원을 출력하시오.
SELECT
    *
FROM HR.employees
WHERE salary > (
    SELECT
        avg(salary)
    FROM HR.employees
    WHERE department_id = 80
    AND job_id = 'SA_REP'
);

-- 문제) 전 직원의 평균 급여와 직원의 성, 직무, 입사일을 출력하시오.
SELECT
    (SELECT
        trunc(avg(salary), 2)
    FROM HR.employees),
    last_name, job_id, hire_date
FROM HR.employees 
group by last_name, job_id, hire_date;


-- 서브쿼리 여러개의 값이 반환될 때 IN
SELECT
    min(salary)
FROM HR.employees
GROUP BY department_id;

SELECT
    *
FROM HR.employees
WHERE salary in (
    SELECT
        min(salary)
    FROM HR.employees
    GROUP BY department_id
);



-- HAVING 절 에도 서브쿼리를 사용할 수 있다.
-- 문제) 각 부서의 최저급여가 90인 부서의 최저급여보다 작은 부서를 출력하시오.
SELECT
    MIN(salary), department_id
FROM HR.employees
group by department_id;

SELECT
    department_id, MIN(salary) min
FROM HR.employees
GROUP BY department_id
HAVING MIN(salary) < (
    SELECT
        MIN(salary)
    FROM HR.employees
    WHERE department_id = 90
);

-- 문제) 각 부서의 평균 급여가 50인 부서의 최고 급여보다 큰 부서를 출력하시오.
SELECT
    TRUNC(AVG(salary), 2), department_id
FROM HR.employees
GROUP BY department_id
HAVING AVG(salary) > (
    SELECT
        MAX(salary)
    FROM HR.employees
    WHERE department_id = 50
);

-- 문제) 직무의 평균급여가 각 직무의 평균급여에서 제일 작은 급여와 같은 직무를 출력하시오
SELECT
    AVG(salary)
FROM HR.employees
GROUP BY job_id
HAVING AVG(salary) = (
    SELECT
        min(avg(salary))
    FROM HR.employees
    GROUP BY job_id
);

SELECT
    job_id, AVG(salary)
FROM HR.employees
GROUP BY job_id
HAVING AVG(salary) = (
    SELECT
        min(avg(salary))
    FROM HR.employees
    GROUP BY job_id
);

-- 문제) 각 부서에서 최저급여를 가진 사원들을 구하시오.
SELECT
    department_id, MIN(salary)
FROM HR.employees
GROUP BY department_id
HAVING MIN(salary) IN (
    SELECT
        MIN(salary)
    FROM HR.employees
    GROUP BY department_id
);

-- 문제) 'SA_REP'인 직무를 가진 직원의 급여와 같은 급여를 가진 직원들을 출력하시오.
SELECT
    salary
FROM HR.employees
WHERE job_id = 'SA_REP'
;

SELECT
    *
FROM HR.employees
WHERE salary in (
    SELECT
        salary
    FROM HR.employees
    WHERE job_id = 'SA_REP'
)
;

-- 문제) 'SA_REP'인 직무를 가진 직원의 급여와 같은 급여를 가진 직원이면서 커미션이 없는 직원만 출력하시오.
SELECT
    *
FROM HR.employees
WHERE salary in (
    SELECT
        salary
    FROM HR.employees
    WHERE job_id = 'SA_REP'
)
AND commission_pct is null
;

-- 문제) 관리자가 아닌 직원들을 구하시오.
SELECT
    *
FROM HR.employees
WHERE employee_id not in (
    SELECT
        manager_id
    FROM HR.employees
    WHERE manager_id is not null
);

-- 문제) 관리자인 직원들을 구하시오.
SELECT
    *
FROM HR.employees
WHERE employee_id in (
    SELECT
        manager_id
    FROM HR.employees
);

-- 문제) 부서장이 아닌 직원들을 구하시오.
SELECT
    *
FROM HR.employees
WHERE employee_id not in (
    SELECT
        manager_id
    FROM HR.departments
    WHERE manager_id is not null
);

-- 문제) 관리자가 없는 직원들을 구하시오.
SELECT
    *
FROM HR.employees
WHERE employee_id in (
    SELECT
        employee_id
    FROM HR.employees
    WHERE manager_id is null
);



