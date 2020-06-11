CREATE TABLE emp
AS
SELECT
    *
FROM employees
WHERE 1=2;

desc emp;

-- ���� 1) ������̺� �ִ� 90�� �μ��� ����� emp�� �����Ͻÿ�.
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

-- ���� 2) INSERT���� �÷�����Ʈ�� �ۼ��ϴ� �� ��� ���������� ����غ���.
INSERT INTO (
    SELECT
        employee_id, last_name, email, hire_date, job_id, department_id
    FROM emp
)
VALUES (99999, 'Taylor', 'DTAYLOR', to_date('07-6��-20', 'DD-MON-RR'), 'ST_CLERK', 90);

-- ���� 3) emp�� 90�� �μ��� ����� �� �ְ� INSERT���� �ۼ��Ͻÿ�. WHERE and WITH CHECK OPTION 
INSERT INTO (
    SELECT
        employee_id, last_name, email, hire_date, job_id, department_id
    FROM emp
    WHERE department_id = 90
    WITH CHECK OPTION
)
VALUES (100000, 'Taylor', 'DTAYLOR', to_date('07-6��-20', 'DD-MON-RR'), 'ST_CLERK', 80);

-- ���� 4) emp�� �ִ� �Ի����� �⺻ ���� sysdate�� ����.
ALTER TABLE emp
MODIFY (hire_date default sysdate);

-- ���� 5) emp�� �ִ� ������� �Ի����� �⺻ ������ �����Ͻÿ�.
UPDATE emp
SET hire_date = default;

-- MERGE
-- ���� 6) 103�� ����� �ִٸ� Ŀ�̼��� 0.003�� �ְ� 103�� ����� ������ ��� �����͸� �Է��Ͻÿ�.
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

-- ���� 7) 90�� �μ��� ������ Ŀ�̼��� 0.5�� �����ϰ� ������ (105, 'RHEE', 'SMRHEE', default, 'SA_MAN', 90) �� �Է��Ͻÿ�.
-- ��ٱ��Ͽ� ��ǰ�� ��� �� ��ǰ�� �����ϴ��� üũ �Ͽ� ��ٱ��Ͽ� ��� �� �ֵ��� �����ϴ� �˰���
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

-- ���� 8) 105�� ����� ������ emp���� 105�� ����� ���� �ϰ� ������ (105, 'RHEE', 'SMRHEE', default, 'SA_MAN', 90) �� �Է��Ͻÿ�.

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

-- ���� 9) 107�� ����� ������ emp���� 107�� ����� ���� �ϰ� ������ (107, 'RHEE', 'SMRHEE', default, 'SA_MAN', 90) �� �Է��Ͻÿ�.

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

-- ���� 10) employees�� �ִ� ����� emp���� �ִ� ��� emp���� ���� �Ͻÿ�.
DELETE FROM emp
WHERE employee_id IN (
    SELECT
        employee_id
    FROM employees
);

-- ����  11) emp�� �ִ� 102 ����� job_id�� employees�� �ִ� ��ձ޿��� ���� ������ �����Ͻÿ�.
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

-- ���� 12) 179�� ����� 200�� ����� ��縦 ������ �ִ� �����̸鼭 179�� �� 200�� ����� �μ��� ���� ������� ���Ͻÿ�.

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

-- ���� 13) 149���� ������ �μ��� ���� ������ ����Ͻÿ�. 149���� ����
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

-- ���� 14) 199���� 174���� ���� �μ��� ���� �������� ���Ͻÿ�.
SELECT
    *
FROM employees
WHERE (manager_id, department_id) in (
    SELECT
        manager_id, department_id
    FROM employees
    WHERE employee_id in (199, 174)
) AND employee_id not in (199, 174);

-- ���� 15) �����ȣ, ��, �׸��� �μ���ȣ�� ����ϴµ� �μ���ȣ�� �ּҹ�ȣ 1800�� �ش��ϴ� �μ��� ��� 'KOR'�� ����ϰ� �������� 'USA'�� ����Ͻÿ�
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
-- ���� ) �μ��� �ְ� �޿��� ���� ����� �������� ����Ͻÿ�.
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

-- ���� ) �μ��� �ִ� �޿��� �ش��ϴ� ������� ������ ���Ͻÿ�.
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

-- ���� ) �μ����� �ְ� �޿����� ���� �޿��� �޴� �����鸸 ����Ͻÿ�.
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
-- ���� ) �ֱ� �Ի��� ��� 5������� ����Ͻÿ�.
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
-- ���� ) 11��° ���� 20��°���� ����Ͻÿ�
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