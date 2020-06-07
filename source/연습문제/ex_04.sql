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



--����) �μ������� ����� �� �μ��� �ִ� �ּҸ� �������.
--      street_address(�μ��� �ִ� �ּ�)
--      �μ���ȣ, �μ���, ��ġ�ڵ�, �ּ�
SELECT
    d.department_id, d.department_name, d.location_id, l.street_address
FROM my_departments d JOIN my_locations l
ON d.location_id = l.location_id;


--����) ���������� ����ϵ� ���� ��� �μ����� �ٹ��ϴ���
--�μ����� ����Ͻÿ�. 
--��, ������ȣ, �μ���ȣ, �μ���, �����ڵ�
SELECT
    e.last_name, e.employee_id, d.department_id, d.department_name, d.location_id
FROM my_employees e JOIN my_departments d
ON e.department_id = d.department_id;


--����) ������ ������ ����� �� �μ������� �� �μ��� �ּҸ� ����Ͻÿ�.
SELECT
    e.last_name, e.employee_id, d.department_id, d.department_name, d.location_id
FROM my_employees e JOIN my_departments d
ON e.department_id = d.department_id;

--����) �� �������� �μ���ȣ�� 90�� ���������� ����Ͻÿ�.
SELECT
    e.last_name, e.employee_id, d.department_id, d.department_name, d.location_id
FROM my_employees e JOIN my_departments d
ON e.department_id = d.department_id
WHERE e.department_id = 90;


--����) �������� : jobs : job_title(��������)
--      �������� : employees
--���� ������ ����� �� ������ �ϴ� ���� ���� ������ 
--����Ͻÿ�. ������ȣ �� ������ȣ ��������
SELECT
    e.employee_id, e.last_name, e.job_id, j.job_title
FROM my_employees e JOIN my_jobs j
ON e.job_id = j.job_id;


--����) ���������� �μ������� ����Ͻÿ�.
--������ȣ, ��, �μ���ȣ, �μ���
SELECT
    e.employee_id, e.last_name, d.department_id, d.department_name
FROM my_employees e JOIN my_departments d
ON e.department_id = d.department_id;

--����) ���������� ����� �� �� ������ �μ������� �� ������ ���������� ����Ͻÿ�.
--      �μ���ȣ, �μ���, ������ȣ, ��������
SELECT
    e.employee_id, e.last_name, d.department_id, d.department_name, j.job_id, j.job_title
FROM my_jobs j JOIN my_employees e
ON j.job_id = e.job_id JOIN my_departments d
ON e.department_id = d.department_id;

--����) �������� jobs
--      ������� job_history
--      ������� employees
--���������� ���� ��� ���� �ߴ����� ���ؼ� ����Ͻÿ�.
--���������丮 : ������ȣ, start_date�� end_date
--�������� : ������ȣ , ��, 
--�������� : ��������
SELECT
    e.employee_id, e.last_name, j1.job_title, j2.job_id, j2.start_date, j2.end_date
FROM my_employees e JOIN my_jobs j1
ON e.job_id = j1.job_id JOIN my_job_history j2
ON j1.job_id = j2.job_id;

SELECT
    *
FROM my_employees;

--����) ���������� �μ������� ����Ͻÿ�.
-- ������ȣ, ��, �μ���ȣ, �μ��� (T-SQL, ansi ���)
SELECT
    e.employee_id, e.last_name, d.department_id, d.department_name
FROM my_employees e JOIN my_departments d
ON e.department_id = d.department_id;


--����) �� ���������� �μ��� �ִ� ����� ��µǾ���.
--�׷��Ƿ� �μ��� ���� ���� ����� ���� �ʾҴ�.
--�μ��� ���� ������ ��µǰ� �Ͻÿ�.
--������ȣ, ��, �μ���ȣ, �μ���
SELECT
    e.employee_id, e.last_name, d.department_id, d.department_name
FROM my_employees e LEFT OUTER JOIN my_departments d
ON e.department_id = d.department_id;

--����) ������ ���������� ���������� ����ϴ� ���������� ���� ������ ����Ͻÿ�.
SELECT
    *
FROM my_employees e LEFT OUTER JOIN my_job_history j
ON e.job_id = j.job_id;

--����) �������� �μ������� ���� �������. 
--��, �μ��� ���� ������ ������ϰ� ������ ���� �μ��� �������.
SELECT
    *
FROM my_employees e FULL OUTER JOIN my_departments d
ON e.department_id = d.department_id;

--����)�μ��� ���� ���� ���
SELECT
    *
FROM my_employees
WHERE employee_id = (
    SELECT
        employee_id
    FROM my_employees
    WHERE department_id is null
);

--����)������ ���� �μ��� ����Ͻÿ�.
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

--����) ���� Abel�̶�� ����� �޿��� �ִ�
SELECT
    *
FROM my_employees
WHERE salary = (
    SELECT
        salary
    FROM HR.employees
    where last_name = 'Abel'
);

--����) ������ȣ�� 141�� ������ ���� ���� ������ �ϴ� �������� ����Ͻÿ�.
SELECT
    *
FROM my_employees
WHERE job_id = (
    SELECT
        job_id
    FROM my_employees
    WHERE employee_id = 141
);


--����) �����ȣ�� 143�� ��� �޿����� ū �޿��� ���� ������ ����Ͻÿ�.
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

--����) 141�� ����� ������ ����  143����� �޿����� ū �޿��� ���� ���� �����ΰ�?
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

--����) ��ü �޿��� ��ձ޿����� ū �������� ���Ͻÿ�.
SELECT
    *
FROM my_employees
WHERE salary > (
    SELECT
        avg(salary)
    FROM my_employees
);


--����) �̸��� Nancy�� ����� ������ ���� Ŀ�̼��� ���� ������ �Ͻÿ�.
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

--����) Ŀ�̼��� �ְ� �޿��� Nancy���� ū ������ �����Դϱ�?
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

--����) ���� 'Olsen'�� ������ ������ ���� ���� ������ ����Ͻÿ�.
SELECT
    *
FROM my_employees
WHERE job_id != (
    SELECT
        job_id
    FROM my_employees
    WHERE last_name = 'Olsen'
);

--����) �̸��� 'Christopher'�� ������ ���� �ؿ� �Ի��� ������ ����Ͻÿ�.
SELECT
    *
FROM my_employees
WHERE to_char(hire_date, 'yyyy') = (
    SELECT
        to_char(hire_date, 'yyyy')
    FROM my_employees
    WHERE first_name = 'Christopher'
);

--����) ���� 'Olsen'�� ������ ������ ���� ���� �����̸鼭 �̸����� 'TRAJS'�λ������ �޿��� �۰� �޴� ������?
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

--����) �μ����� 'IT'�� ������ ����Ͻÿ�.
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

--����) 60�� �μ��� ���� �޿��� ���� �������� ���Ͻÿ�.
SELECT
    *
FROM my_employees
WHERE salary = (
    SELECT
        MIN(salary)
    FROM my_employees
    WHERE department_id = 60
);

--����) �� �μ��� ���� �޿��� 60�� �μ��� �����޿����� ū �μ��� �μ��� �����޿��� ���Ͻÿ�.
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

--����) 50�� �μ��� ��ձ޿����� ū �������� ���Ͻÿ�.
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

--����) 50�μ��� �ִ�޿����� �� �μ��� ��� �޿��� �� ū �μ��� ���Ͻÿ�.
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

--����) ��� �޿��� ���� ���� ������ ã���ÿ�.
SELECT
    AVG(salary), job_id
FROM my_employees
GROUP BY job_id;

--����) �� �μ����� ���� �޿��� ���� �������� ���Ͻÿ�.
--
--����)'IT_PROG'�� ������ ���� ������ �޿��� ���� �޿��� ���� �������� ���Ͻÿ�.
--
--����)'IT_PROG'�� ������ ���� ������ �޿��� ���� �޿��� ���� �����̸鼭 Ŀ�̼��� ���� ������ ����Ͻÿ�.
--
--����)  'IT_PROG'�� ������ ���� ������ �޿����� �ִ� �޿����� ���� �޿��� �޴� ������ �� ������ 'IT_PROG'�� �������� ������ ������ �������� ����Ͻÿ�.
--
--
--����) 'IT_PROG'�� ������ ���� ������ �޿��� ���� ���� 
-- �޿��� �޴� ������?
--
--
--����) ���� ���̺����� �μ���ȣ, �Ի����� ����ϰ�
--      �μ� ���̺����� �μ���ȣ, �����ڵ带 ����Ͻÿ�.
--
--
--����) �������̺����� ������ȣ, �Ի���
--      �����������̺����� ������ȣ, �������� ����Ͻÿ�.
--
--
-----���� �������� ���� ���Ѽ� insert�� �� ������..
--insert into departments (department_id, department_name,manager_id, location_id)
--values (280, 'smrit_404', 100, 1700);
--
--insert into departments (department_name,  location_id,manager_id, department_id)
--values('smrit_405', 1710, 110, 290);
--
--insert into departments (department_id, department_name)
--values (300,'smrit_406');
--
--insert into departments values(310, '�����н�' , 120, 1800);
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
--insert into departments values(320, '������ ������' , null, null);
--
--
--INSERT INTO employees 
--values (401, 'Den', 'Raphealy',
--        'DRAPHEAL' , '987.987.9874',
--       to_date('05-20-2019','MM-DD-RR'),  
--      'AC_ACCOUNT', 11000, NULL, 100, 30);
--
--INSERT INTO employees 
--values (402, '����', '��',
--        '������' , '987.987.9874',
--        to_date('5�� 23, 2019','MON DD, RR'),                   'AC_ACCOUNT', 11000, NULL, 100, 30);
--
