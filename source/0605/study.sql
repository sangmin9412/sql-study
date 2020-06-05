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

-- �������� (SubQuery)

-- 'Abel'�� �޿��� ���� ����� ����Ͻÿ�.
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

-- 'Abel'�� �޿� ���� ū ����� ����Ͻÿ�.
SELECT
    *
FROM HR.employees
WHERE salary >= (
    SELECT
        salary
    FROM HR.employees
    WHERE last_name = 'Abel'
);

-- 120�� ����� ������ ���� 121�� ����� �޿����� ū ������� ����Ͻÿ�.
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

-- ������ 'SA'�� �����ϰ� �ִ� ������ ���� �޿����� ���� ����� ����Ͻÿ�.
SELECT
    *
FROM HR.employees
WHERE salary < (
    SELECT
        min(salary)
    FROM HR.employees
    WHERE job_id like '%SA%'
);

-- 90�� �μ��� ��� �޿����� ũ�� ������ 140���� ������ ���� ������� ����Ͻÿ�.
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

-- �μ��� ���� ������ ������ ���� ���� �ϴ� ����� ����Ͻÿ�.
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

-- ����) �̸��� Nancy�� ����� ������ ���� Ŀ�̼��� ���� ������ ����Ͻÿ�.
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

-- ����) ���� 'Abel'�� ������ ������ ���� ���� ������ ����Ͻÿ�.
SELECT
    *
FROM HR.employees
WHERE job_id != (
    SELECT
        job_id
    FROM HR.employees
    WHERE last_name = 'Abel'
);

-- ����) ���� 'Abel'�� ������ ���� �ؿ� �Ի��� ������ ����Ͻÿ�.
SELECT
    *
FROM HR.employees
WHERE to_char(hire_date, 'yyyy') = (
    SELECT
        to_char(hire_date, 'yyyy')
    FROM HR.employees
    WHERE last_name = 'Abel'
);

-- ����) �μ����� 'Marketing'�� �μ��� ������� ����Ͻÿ�
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

-- ���� 'Hunold'�� ����� ������ ���� �̸����� 'JURMAN'�� ����� �μ��� �ִ� ����� ����Ͻÿ�.
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

-- ����) �μ��� 80�̸鼭 ������ 'SA_REP' ����� ��� �޿����� ū ����� ����Ͻÿ�.
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

-- ����) �� ������ ��� �޿��� ������ ��, ����, �Ի����� ����Ͻÿ�.
SELECT
    (SELECT
        trunc(avg(salary), 2)
    FROM HR.employees),
    last_name, job_id, hire_date
FROM HR.employees 
group by last_name, job_id, hire_date;


-- �������� �������� ���� ��ȯ�� �� IN
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



-- HAVING �� ���� ���������� ����� �� �ִ�.
-- ����) �� �μ��� �����޿��� 90�� �μ��� �����޿����� ���� �μ��� ����Ͻÿ�.
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

-- ����) �� �μ��� ��� �޿��� 50�� �μ��� �ְ� �޿����� ū �μ��� ����Ͻÿ�.
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

-- ����) ������ ��ձ޿��� �� ������ ��ձ޿����� ���� ���� �޿��� ���� ������ ����Ͻÿ�
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

-- ����) �� �μ����� �����޿��� ���� ������� ���Ͻÿ�.
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

-- ����) 'SA_REP'�� ������ ���� ������ �޿��� ���� �޿��� ���� �������� ����Ͻÿ�.
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

-- ����) 'SA_REP'�� ������ ���� ������ �޿��� ���� �޿��� ���� �����̸鼭 Ŀ�̼��� ���� ������ ����Ͻÿ�.
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

-- ����) �����ڰ� �ƴ� �������� ���Ͻÿ�.
SELECT
    *
FROM HR.employees
WHERE employee_id not in (
    SELECT
        manager_id
    FROM HR.employees
    WHERE manager_id is not null
);

-- ����) �������� �������� ���Ͻÿ�.
SELECT
    *
FROM HR.employees
WHERE employee_id in (
    SELECT
        manager_id
    FROM HR.employees
);

-- ����) �μ����� �ƴ� �������� ���Ͻÿ�.
SELECT
    *
FROM HR.employees
WHERE employee_id not in (
    SELECT
        manager_id
    FROM HR.departments
    WHERE manager_id is not null
);

-- ����) �����ڰ� ���� �������� ���Ͻÿ�.
SELECT
    *
FROM HR.employees
WHERE employee_id in (
    SELECT
        employee_id
    FROM HR.employees
    WHERE manager_id is null
);



