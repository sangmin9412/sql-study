-- set
-- UNION (�ߺ������ʹ� ������� �ʴ´�)
-- ȸ��(member) ���̺� �ִ� user_id, ����(employees)���̺� �ִ� employee_id�� ���ϴ� ���̵� �ִ��� Ȯ������.
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

-- ����) ������ �ִ� �����ȣ�� ������ ����ϰ� �����������̺�(job_history)�� �ִ� �����ȣ�� ������ ����Ͻÿ�.
SELECT
    employee_id, job_id
FROM HR.employees e
UNION
SELECT
    employee_id, job_id
FROM HR.job_history j;

-- UNION ALL �ߺ������� �����Ͽ� ���
SELECT
    employee_id, job_id
FROM HR.employees e
UNION ALL
SELECT
    employee_id, job_id
FROM HR.job_history j;

-- 'highland0' �̶�� ����ڰ� employees�� job_history�� ��ϵ� ��������� Ȯ���Ͻÿ�.
SELECT
    employee_id
FROM HR.employees
WHERE employee_id = 'highland0'
UNION
SELECT
    employee_id
FROM HR.job_history
WHERE employee_id = 'highland0';

-- '102' �̶�� ����ڰ� employees�� job_history�� ��ϵ� ��������� Ȯ���Ͻÿ�.
SELECT
    employee_id
FROM HR.employees
WHERE employee_id = 102
UNION
SELECT
    employee_id
FROM HR.job_history
WHERE employee_id = 102;

-- ����) employees(��ȭ), job_history(��ǰ) 
-- employee_id(������)
-- hire_date(���ų�¥), start_date(���ų�¥)
-- job_id(��ǰ��ȣ)
SELECT
    job_id, hire_date, '��ȭ' "ī�װ�"
FROM HR.employees
WHERE employee_id = 102
UNION
SELECT
    job_id, start_date, '��ǰ'
FROM HR.job_history
WHERE employee_id = 102;


-- ����) ���� ���̺����� �μ���ȣ, �Ի����� ����ϰ� �μ� ���̺����� �μ���ȣ, �����ڵ带 ����Ͻÿ�.
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

-- ����) �������̺��� ������ȣ, ����, �޿��� ����ϴµ� ������ 'REP'�� �����Ͽ��� �Ѵ�.
-- �������� ���̺����� ������ȣ ������ ����ϴµ� �޿� ��� 0�� ����ϴµ� ���� ���� �⵵�� '2005'�� �̾�� �Ѵ�.
SELECT
    employee_id, job_id, salary, hire_date, 'employees'
FROM HR.employees
WHERE job_id like '%REP%'
UNION
SELECT
    employee_id, job_id , 0, start_date, 'job_history'
FROM HR.job_history
WHERE to_char(start_date, 'yyyy') = 2002;

