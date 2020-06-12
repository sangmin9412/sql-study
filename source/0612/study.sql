-- ���� ) �����ȣ, �̸�, ����, �޿�, �Ի����� ����ϴ� �� �Ի��� �⵵ �� �������� �ƴ��� ����Ͻÿ�.
-- 4�⸶�ٴ� �����̰� 100�⸶�ٴ� ������ �ƴϴ� �׷��� 400�⸶�� ������ �ȴ�.
SELECT
    employee_id, last_name, job_id, salary, hire_date, to_char(hire_date, 'yyyy'),
    CASE WHEN MOD(to_char(hire_date, 'yyyy') , 4) = 0 
        AND MOD(to_char(hire_date, 'yyyy') , 100) != 0 
        OR MOD(to_char(hire_date, 'yyyy') , 400) = 0
        THEN '����'
        ELSE '����ƴ�' END YEAR
FROM employees;

SELECT
    employee_id, last_name, job_id, salary, hire_date, to_char(hire_date, 'yyyy')
FROM employees;

-- ���� ) ������ �Ի��� ���� ���� ��ȣ�� �� ���� ������ ���� ������ ����Ͻÿ�.

SELECT
    employee_id, first_name, job_id, salary, last_day(hire_date) "���� ������ ��", to_char(hire_date, 'day') "����", to_char(hire_date, 'd') "���� Number"
FROM employees;

SELECT
    1 || 1 + 10
FROM dual;

-- ���� ) �����ȣ, �̸�, ����, �޿�, �Ի����� ����ϴµ� ��¥�� �����-��-��-��:��:�� �� ����Ͻÿ�.
SELECT
    employee_id, first_name, job_id, salary, to_char(hire_date, '  yyyy-mm-dd hh24 : mi : ss am')
FROM employees;

-- ���� ) �����ȣ, �̸�, ����, �Ի���, �޿��� 3�ڸ����� �޸��� ��� �츮������ ��ȭ�� ���̳ʽ�(-)�� �ִ� ��� �ڿ� "-"�� ���̵��� �Ѵ�.
SELECT
    employee_id, first_name, job_id, hire_date, trim(to_char(salary, 'L999,999,999MI')) salary
FROM employees;

-- ���� ) �����ȣ, �̸�, ����, �޿�, �Ի����� ����ϴµ� ��¥�� 2020�� 5�� 20�� 12��:��:�� �������� ����Ͻÿ�.
SELECT
    employee_id, first_name, job_id, salary, to_char(hire_date, ' yyyy"��" mm"��" dd"��" | hh12 : mi : ss am') "�� �� �� ���̱�"
FROM employees;

-- ���� ) 2002�⵵ ���Ŀ� �Ի��� ������� ����Ͻÿ�.
SELECT
    employee_id, first_name, job_id, salary, hire_date
FROM employees
WHERE to_char(hire_date, 'yyyy') > 2002 ;

-- ��ø �Լ�
-- ���� ) �� �μ��� ��ձ޿� �� �ִ� ���� ����Ͻÿ�.
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

-- ���� ) �� �̸��� �޿��� 3000�̰� Ŀ�̼��� 0.03 �Դϴ�. �� ����ϴµ� (concat�� ���)
SELECT
    CONCAT(last_name, CONCAT(first_name, CONCAT('�� �޿��� ', CONCAT(salary ,CONCAT('�̰� Ŀ�̼��� ', CONCAT(nvl(commission_pct,0), '�Դϴ�')))))) "����"
FROM employees;

-- ���� ) ���� ��縦 ����ϴµ� ��簡 ������ 'No Manager'�� ��µǰ� ����.
SELECT
    last_name, nvl(to_char(manager_id), 'No Manager')
FROM employees;

-- ���� ) Ŀ�̼��� ������ �޿��� ������ ���Ͻÿ�.
SELECT
    (salary + (salary * nvl(commission_pct, 0))) * 12 yearsal
FROM employees;

-- ���� ) �޿��� 12000�̻��̸� '�̻�'
--              10000 �̻��̸� '����'
--              7000 �̻��̸� '����'
--              4000 �̻��̸� '����'
--              3000 �̻��̸� '�븮'
--              �� �� '���'
SELECT
    last_name, job_id, salary,
    CASE 
        WHEN salary >= 12000 THEN '�̻�'
        WHEN salary >= 10000 THEN '����'
        WHEN salary >= 7000 THEN '����'
        WHEN salary >= 4000 THEN '����'
        WHEN salary >= 3000 THEN '�븮'
    ELSE '���' END "����"
FROM employees;

-- ���� ) departments ���� ����� �ִ� �μ��� ���� ���Ͻÿ�. ��������
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













