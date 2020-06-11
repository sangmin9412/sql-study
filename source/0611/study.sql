CREATE TABLE emp
AS
SELECT
    *
FROM employees
WHERE 1=2;

desc emp;

-- 문제 1) 사원테이블에 있는 90인 부서의 사원만 emp에 저장하시오.
INSERT INTO emp(employee_id, last_name, email, hire_date, job_id, department_id)
VALUES ((
    select 
        nvl(max(employee_id), 0)+1 
    from emp
    ), 'LEE', 'SMLEE', sysdate, 'SA_REP', 90
);

--

INSERT INTO emp
SELECT
    *
FROM employees
WHERE department_id = 90;

-- 문제 2) INSERT절에 컬럼리스트를 작성하는 것 대신 서브쿼리를 사용해보자.
INSERT INTO (
    SELECT
        employee_id, last_name, email, hire_date, job_id, department_id
    FROM emp
)
VALUES (99999, 'Taylor', 'DTAYLOR', to_date('07-6월-20', 'DD-MON-RR'), 'ST_CLERK', 90);

-- 문제 3) emp에 90인 부서만 저장될 수 있게 INSERT문을 작성하시오. WHERE and WITH CHECK OPTION 
INSERT INTO (
    SELECT
        employee_id, last_name, email, hire_date, job_id, department_id
    FROM emp
    WHERE department_id = 90
    WITH CHECK OPTION
)
VALUES (100000, 'Taylor', 'DTAYLOR', to_date('07-6월-20', 'DD-MON-RR'), 'ST_CLERK', 80);

-- 문제 4) emp에 있는 입사일의 기본 값을 sysdate로 주자.
ALTER TABLE emp
MODIFY (hire_date default sysdate);

-- 문제 5) emp에 있는 사원들의 입사일을 기본 값으로 변경하시오.
UPDATE emp
SET hire_date = default;

-- MERGE
-- 문제 6) 103인 사원이 있다면 커미션을 0.003을 주고 103인 사원이 없으면 사원 데이터를 입력하시오.
MERGE INTO emp e1
USING (
    SELECT employee_id 
    FROM emp
    WHERE employee_id = 103
) e2
ON (e1.employee_id = e2.employee_id)
WHEN MATCHED THEN
UPDATE SET commission_pct = 0.03
WHEN NOT MATCHED THEN
INSERT (e1.employee_id, e1.last_name, e1.email, e1.hire_date, e1.job_id, e1.department_id)
VALUES (103, 'RHEE', 'SMRHEE', default, 'SA_MAN', 90);

--

MERGE INTO emp e1
USING (
    SELECT employee_id 
    FROM employees
    WHERE employee_id = 105
) e2
ON (e1.employee_id = e2.employee_id)
WHEN MATCHED THEN
UPDATE SET commission_pct = 0.03
WHEN NOT MATCHED THEN
INSERT (e1.employee_id, e1.last_name, e1.email, e1.hire_date, e1.job_id, e1.department_id)
VALUES (105, 'RHEE', 'SMRHEE', default, 'SA_MAN', 90);

--

-- 문제 7) 90인 부서가 있으면 커미션을 0.5로 수정하고 없으면 (105, 'RHEE', 'SMRHEE', default, 'SA_MAN', 90) 를 입력하시오.
-- 장바구니에 제품이 담길 때 제품이 존재하는지 체크 하여 장바구니에 담길 수 있도록 구현하는 알고리즘
MERGE INTO emp e1 -- cart
USING (
    SELECT
        employee_id
    FROM employees
    WHERE employee_id = 105 -- goods_num
) e2 -- goods
ON (e1.employee_id = e2.employee_id)
WHEN MATCHED THEN
UPDATE SET commission_pct = 0.5, hire_date = default
WHEN NOT MATCHED THEN
INSERT (e1.employee_id, e1.last_name, e1.email, e1.hire_date, e1.job_id, e1.department_id)
VALUES (105, 'RHEE', 'SMRHEE', default, 'SA_MAN', 90)
;

-- 문제 8) 105인 사원이 있으면 emp에서 105인 사원을 삭제 하고 없으면 (105, 'RHEE', 'SMRHEE', default, 'SA_MAN', 90) 를 입력하시오.

MERGE INTO emp e1
USING (
    SELECT employee_id 
    FROM employees
    WHERE employee_id = 105
) e2
ON (e1.employee_id = e2.employee_id)
WHEN MATCHED THEN
UPDATE SET commission_pct = 0.03
DELETE WHERE employee_id = 105
WHEN NOT MATCHED THEN
INSERT (e1.employee_id, e1.last_name, e1.email, e1.hire_date, e1.job_id, e1.department_id)
VALUES (105, 'RHEE', 'SMRHEE', default, 'SA_MAN', 90);

-- 문제 9) 107인 사원이 있으면 emp에서 107인 사원을 삭제 하고 없으면 (107, 'RHEE', 'SMRHEE', default, 'SA_MAN', 90) 를 입력하시오.

MERGE INTO emp e1
USING (
    SELECT employee_id 
    FROM employees
    WHERE employee_id = 107
) e2
ON (e1.employee_id = e2.employee_id)
WHEN MATCHED THEN
UPDATE SET commission_pct = 0.03
DELETE WHERE employee_id = 107
WHEN NOT MATCHED THEN
INSERT (e1.employee_id, e1.last_name, e1.email, e1.hire_date, e1.job_id, e1.department_id)
VALUES (107, 'RHEE', 'SMRHEE', default, 'SA_MAN', 90);

-- 문제 10) employees에 있는 사원이 emp에도 있는 경우 emp에서 삭제 하시오.
DELETE FROM emp
WHERE employee_id IN (
    SELECT
        employee_id
    FROM employees
);

-- 문제  11) emp에 있는 102 사원의 job_id를 employees에 있는 평균급여가 높은 직무로 변경하시오.
UPDATE emp
SET job_id = (
    SELECT
        job_id
    FROM employees
    GROUP BY job_id
    HAVING AVG(salary) = (
        SELECT
            MAX(AVG(salary))
        FROM employees
        GROUP BY job_id
    )
)
WHERE employee_id = 102;

-- 문제 12) 179번 사원과 200번 사원의 상사를 가지고 있는 직원이면서 179번 과 200번 사원의 부서와 같은 사원들을 구하시오.

SELECT
    *
FROM employees
WHERE manager_id in (
    SELECT
        manager_id
    FROM employees
    WHERE employee_id in (179, 200)
)
AND department_id in (
    SELECT
        department_id
    FROM employees
    WHERE employee_id in (179, 200)
);

-- 문제 13) 149번의 직무와 부서가 같은 직원을 출력하시오. 149번은 제외
SELECT
    *
FROM employees
WHERE (job_id, department_id) = (
    SELECT
        job_id, department_id
    FROM employees
    WHERE employee_id = 149
)
AND employee_id != 149;

-- 문제 14) 199번과 174번의 상사와 부서가 같은 직원들을 구하시오.
SELECT
    *
FROM employees
WHERE (manager_id, department_id) in (
    SELECT
        manager_id, department_id
    FROM employees
    WHERE employee_id in (199, 174)
) AND employee_id not in (199, 174);

-- 문제 15) 사원번호, 성, 그리고 부서번호를 출력하는데 부서번호가 주소번호 1800에 해당하는 부서인 경우 'KOR'로 출력하고 나머지는 'USA'로 출력하시오
SELECT
    employee_id, last_name, department_id,
    ( 
        SELECT
            'KOR'
        FROM departments
        WHERE location_id = 1800
    ) locations
FROM employees;

SELECT
    employee_id, last_name,
    CASE WHEN department_id = (
        SELECT department_id
        FROM departments
        WHERE location_id = 1800
    ) THEN 'KOR' ELSE 'USA' END location
FROM employees;

SELECT
    *
FROM emp;

INSERT INTO emp(employee_id, last_name, email, hire_date, job_id, department_id)
VALUES (102, 'RHEE', 'SMRHEE', default, 'SA_MAN', 90);


-- INLINE VIEW
-- 문제 ) 부서별 최고 급여를 가진 사원의 상세정보를 출력하시오.
SELECT
    MAX(salary)
FROM employees
GROUP BY department_id;

SELECT
    *
FROM (
    SELECT
        department_id, job_id, last_name || ' ' || first_name name, salary
    FROM employees e
    WHERE salary in (
        SELECT
            MAX(salary)
        FROM employees
        GROUP BY department_id
    )
);

-- 문제 ) 부서별 최대 급여에 해당하는 사원들의 정보를 구하시오.
SELECT
    e.employee_id, e.last_name, e.salary, d.department_id, d.maxsal
FROM employees e, (
    SELECT
        department_id, max(salary) maxsal
    FROM employees
    GROUP BY department_id
) d
WHERE e.department_id = d.department_id
AND e.salary = d.maxsal;

-- 문제 ) 부서에서 최고 급여보다 작은 급여를 받는 직원들만 출력하시오.
SELECT
    e.employee_id, e.last_name, e.salary, d.department_id, d.maxsal
FROM employees e, (
    SELECT
        department_id, MAX(salary) maxsal
    FROM employees
    GROUP BY department_id
) d
WHERE e.department_id = d.department_id
AND e.salary < d.maxsal;

---- TOP - N
-- 문제 ) 최근 입사한 사원 5명까지만 출력하시오.
SELECT
    ROWNUM, employee_id, last_name || ' ' || first_name name, salary, department_id
FROM (
    SELECT
        *
    FROM employees
    ORDER BY employee_id desc
)
WHERE ROWNUM <= 5;

-- PAGING
-- 문제 ) 11번째 부터 20번째까지 출력하시오
SELECT
    *
FROM (
    SELECT
        ROWNUM rn, employee_id, last_name || ' ' || first_name name, salary, department_id
    FROM (
        SELECT
            *
        FROM employees
        ORDER BY employee_id desc
    )
)
WHERE rn >= 11 AND rn <= 20;