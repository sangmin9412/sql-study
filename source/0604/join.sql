-- ANSI JOIN
-- null �� ���� �� ����.

SELECT employee_id, department_id, manager_id
FROM HR.employees;

SELECT department_id, location_id, manager_id
FROM HR.departments;

-- natural JOIN
-- �̸��� ���� �÷��� ��� �� ����� �ȴ�.
-- �μ�(department_id)���� ���(manager_id)�� �ΰ��ִ� ���.
SELECT department_id, department_name, location_id, employee_id, manager_id
FROM HR.employees natural JOIN HR.departments;

-- �� �� ��� ���� ����.
SELECT d.department_id, department_name, location_id, employee_id, e.manager_id
FROM HR.employees e JOIN HR.departments d
on e.department_id = d.department_id AND e.manager_id = d.manager_id;

-- �� �� ��� ���� ����.
SELECT department_id, department_name, location_id, employee_id, manager_id
FROM HR.employees JOIN HR.departments
using (department_id, manager_id);

-- �� ���̺��� ���� �̸��� �÷��� location_id�� �����Ƿ� location_id �� ���� ������ �ȴ�.
SELECT department_id, department_name, location_id, city
FROM HR.departments natural JOIN HR.locations;

SELECT department_id, department_name, d.location_id, city
FROM HR.departments d JOIN HR.locations l
on d.location_id = l.location_id;

-- using (NATURAL JOIN �� �����ϴ�)
-- ���� �̸��� �÷��� �񱳰� �����ϴ�.
-- ��Ī�� �� �� ����
SELECT department_id, department_name, location_id, city
FROM HR.departments inner JOIN HR.locations
using (location_id);

SELECT employee_id, manager_id, last_name
FROM HR.employees;


-- inner JOIN ���ϰ���� �÷��� �� on �� ���� �÷��� �ۼ��� �� �ִ�
SELECT d.department_id, department_name, location_id, employee_id, e.manager_id
FROM HR.employees e JOIN HR.departments d
on e.department_id = d.department_id;



-- �ߺ������Ͱ� �ִٸ� Foreign Key ���ٸ� Primary Key
SELECT *
FROM HR.departments;
SELECT *
FROM HR.locations;





-- ANSI JOIN�� T-SQL JOIN ��
-- ANSI JOIN - A JOIN B on A = B
SELECT d.department_id, department_name, location_id, employee_id, e.manager_id
FROM HR.employees e JOIN HR.departments d
on e.department_id = d.department_id;

-- T-SQL JOIN
SELECT d.department_id, department_name, location_id, employee_id, e.manager_id
FROM HR.employees e , HR.departments d
WHERE e.department_id = d.department_id;

-- ����) �����ȣ�� 120�� ����� �����ȣ, ��, �޿�, �μ���ȣ, �μ���� ������ȣ�� ����Ͻÿ�.
SELECT employee_id, last_name, salary, e.department_id, department_name, location_id
FROM HR.employees e JOIN HR.departments d
on e.department_id = d.department_id
WHERE employee_id = 120; -- WHERE or AND

-- ����) 101�� ��縦 ������ �ִ� ����� �����ȣ, ��, �޿�, �μ���ȣ, �μ����� ����Ͻÿ�
SELECT e.employee_id, last_name, salary, e.department_id, department_name, e.manager_id
FROM HR.employees e JOIN HR.departments d
on e.department_id = d.department_id
WHERE e.manager_id = 101;

SELECT e.employee_id, last_name, salary, e.department_id, department_name, e.manager_id
FROM HR.employees e , HR.departments d
WHERE e.department_id = d.department_id
AND e.manager_id = 101;

-- ����) ������ ������ ����� �� �μ������� �� �μ��� �ּҸ� ����ϴµ� �μ���ȣ�� 90�� ������ ����Ͻÿ�.
SELECT e.employee_id, e.last_name, e.job_id, e.manager_id, e.department_id, d.department_name, d.location_id
FROM HR.employees e JOIN HR.departments d
on e.department_id = d.department_id
WHERE e.department_id = 90;

SELECT e.employee_id, e.last_name, e.job_id, e.manager_id, e.department_id, d.department_name, d.location_id
FROM HR.employees e , HR.departments d
WHERE e.department_id = d.department_id
AND e.department_id = 90;

-- ����) ���������� ����ϵ� ������ ��� �μ����� �ٹ��ϴ��� �μ����� ����Ͻÿ�.
-- ��, ������ȣ, �μ���ȣ, �μ���, �����ڵ�
SELECT e.last_name, e.employee_id, e.department_id, d.department_name, d.location_id
FROM HR.employees e JOIN HR.departments d
on e.department_id = d.department_id;

SELECT e.last_name, e.employee_id, e.department_id, d.department_name, d.location_id
FROM HR.employees e , HR.departments d
WHERE e.department_id = d.department_id;

-- ����) ���� �μ��� �μ����� ���� �� �������� ����Ʈ�� ����ϴµ� 30, 50, 90�� �μ��� ���
----- ����
SELECT e.employee_id, e.last_name, d.manager_id, e.department_id, d.department_name, d.location_id
FROM HR.employees e JOIN HR.departments d
ON e.manager_id = d.manager_id
WHERE e.department_id in (30, 50, 90)
order by 1;

select distinct manager_id
from HR.employees;
select manager_id
from HR.departments;

select distinct department_id
from HR.employees;
select department_id
from HR.departments;
-----

-------------------------------------
SELECT e.employee_id, e.last_name, d.manager_id, e.department_id, d.department_name, d.location_id
FROM HR.employees e JOIN HR.departments d
ON e.department_id = d.department_id
AND e.manager_id = d.manager_id
WHERE e.department_id in (30, 50, 90);
-------------------------------------
SELECT e.employee_id, e.last_name, d.manager_id, e.department_id, d.department_name, d.location_id
FROM HR.employees e , HR.departments d
WHERE e.department_id = d.department_id
AND e.manager_id = d.manager_id
AND e.department_id in (30, 50, 90);

-- 'REP'�� ���Ե� ������ ���� ����� �����ȣ�� ��, ����, �μ���ȣ, �μ���, �μ����ȣ�� ����Ͻÿ�. 
SELECT e.last_name, e.job_id, e.department_id, d.department_name, d.manager_id
FROM HR.employees e JOIN HR.departments d
ON e.department_id = d.department_id
WHERE e.job_id like '%REP%';

SELECT e.last_name, e.job_id, e.department_id, d.department_name, d.manager_id
FROM HR.employees e , HR.departments d
WHERE e.department_id = d.department_id
AND e.job_id like '%REP%';

-- �μ� ������ ����� �� �μ��� �ּҵ� ��� ����Ͻÿ�.
-- �μ� : departments, �ּ� ���� : locations
-- �μ���ȣ, �μ���, �μ����ȣ
-- COUNTRY_ID, CITY, STREET_ADDRESS, location_id
SELECT d.department_id, d.department_name, d.manager_id, l.country_id, l.city, l.street_address, l.location_id
FROM HR.departments d JOIN HR.locations l
ON d.location_id = l.location_id;

-- ������ �����ִ� �μ��� �ּ������� �������.
-- �����ȣ, ��
-- �μ���ȣ, �μ���, �μ���
-- contry_id, city, street_address, location_id
SELECT e.employee_id, e.last_name, e.department_id, d.department_name, d.manager_id,
        l.country_id, l.city, l.street_address, l.location_id
FROM HR.employees e JOIN HR.departments d
ON e.department_id = d.department_id JOIN HR.locations l
ON d.location_id = l.location_id;

SELECT e.employee_id, e.last_name, e.department_id, d.department_name, d.manager_id,
        l.country_id, l.city, l.street_address, l.location_id
FROM HR.employees e , HR.departments d , HR.locations l
WHERE e.department_id = d.department_id
AND d.location_id = l.location_id;

-- �� ���� ���� �μ���ȣ�� 90�� ������ ����Ͻÿ�.
SELECT e.employee_id, e.last_name, e.department_id, d.department_name, d.manager_id,
        l.country_id, l.city, l.street_address, l.location_id
FROM HR.employees e JOIN HR.departments d
ON e.department_id = d.department_id JOIN HR.locations l
ON d.location_id = l.location_id
where e.department_id = 90;

-- ���� ������ ���ؼ� ����Ͻÿ�
SELECT *
FROM HR.jobs;
-- job_id : Primary Key
-- �������
SELECT *
FROM HR.departments;
-- department_id : Primary Key
SELECT *
FROM HR.employees;
-- employee_id : Primary Key
-- job_id : Foreign Key
-- department_id : Foreign Key
-- �μ�����

SELECT j.job_title, e.employee_id, e.last_name, d.department_name, l.street_address
FROM HR.jobs j 
JOIN HR.employees e
ON j.job_id = e.job_id 


JOIN HR.departments d
ON e.department_id = d.department_id
JOIN HR.locations l
ON d.location_id = l.location_id;

SELECT j.job_title, e.employee_id, e.last_name, d.department_name, l.street_address
FROM HR.jobs j , HR.employees e , HR.departments d, HR.locations l
WHERE j.job_id = e.job_id
AND e.department_id = d.department_id
AND d.location_id = l.location_id;


-- ����) �μ��� 20�̰ų� 50�� �μ��� �����ȣ�� �μ���ȣ �� �μ��� �׸��� ��ġ������ ����Ͻÿ�.
SELECT e.employee_id, e.department_id, d.department_name, d.location_id
FROM HR.employees e JOIN HR.departments d
ON e.department_id = d.department_id
WHERE e.department_id in (20, 50);

SELECT e.employee_id, e.department_id, d.department_name, d.location_id
FROM HR.employees e , HR.departments d
WHERE e.department_id = d.department_id
AND e.department_id in (20, 50);

-- ����) Matos��� ���� ������ �ִ� ����� �ִ�. �� ����� �μ������� �����ȣ �׸��� ���� ����Ͻÿ�.
SELECT e.department_id, d.department_name, e.employee_id, e.last_name
FROM HR.employees e JOIN HR.departments d
ON e.department_id = d.department_id
WHERE e.last_name = 'Matos';

SELECT e.department_id, d.department_name, e.employee_id, e.last_name
FROM HR.employees e , HR.departments d
WHERE e.department_id = d.department_id
AND e.last_name = 'Matos';

-- ����) Matos��� ���� ������ �ִ� ����� King��� ���� ���� ����� �ִ�.
-- �� ����� �μ������� �����ȣ �׸��� ���� ����Ͻÿ�.
SELECT e.department_id, d.department_name, e.employee_id, e.last_name
FROM HR.employees e JOIN HR.departments d
ON e.department_id = d.department_id
WHERE e.last_name in ('Matos', 'King');

SELECT e.department_id, d.department_name, e.employee_id, e.last_name
FROM HR.employees e , HR.departments d
WHERE e.department_id = d.department_id
AND e.last_name in ('Matos', 'King');

-- ����) King �̶�� ���� ������ �ִ� ����� �ִ�.
-- �� ����� �μ������� �����ȣ �׸��� ���� ����Ͻÿ�.
SELECT e.department_id, d.department_name, e.employee_id, e.last_name
FROM HR.employees e , HR.departments d
WHERE e.department_id = d.department_id
AND e.last_name = 'King';

-- ����) �μ����̺��� �μ���ȣ�� �μ��� �׸��� �����ڵ� �� �������� ����ϴµ� �����ڵ尡 1400�� ������ ���
SELECT d.department_id, d.department_name, d.location_id, l.street_address, l.city
FROM HR.departments d JOIN HR.locations l
ON d.location_id = l.location_id
WHERE d.location_id = 1400;

-- ����) ����� �ϰ� �ִ� ���� �̸��� ����� �μ����� ����ϴµ� ����� �����ȣ �̸��� ����Ͻÿ�.
-- ��, 'SA'�� �����ϰ� �ִ� ������ '2005'�⿡ �Ի��� ����� ����Ͻÿ�.
SELECT j.job_id ,j.job_title, d.department_name, e.employee_id, e.first_name, e.hire_date
FROM HR.jobs j JOIN HR.employees e 
ON j.job_id =  e.job_id JOIN HR.departments d
ON e.department_id = d.department_id
WHERE e.job_id LIKE '%SA%' AND to_char(e.hire_date, 'yyyy') = 2005;

-- �ڱ����� ����
-- ����) 104�� ����� ���������� ����Ͻÿ�.
SELECT e.employee_id, e.last_name, e.hire_date
FROM HR.employees e JOIN HR.employees m
ON e.employee_id = m.manager_id
WHERE m.employee_id = 104;

-- ����) �����̸��� ������ ��� �̸��� ����Ͻÿ�.
SELECT e1.first_name, e2.manager_id
FROM HR.employees e1 JOIN HR.employees e2
ON e1.manager_id = e2.employee_id;

-- ����) �μ��� ���� ����� ����Ͻÿ�.
SELECT *
FROM HR.employees
where department_id is null;

-- ����) ������ ���� �μ������� ����Ͻÿ�.
-- ���� : �����ȣ, ��, �޿�
-- �μ����� : �μ���ȣ, �μ��̸�
SELECT e.employee_id, e.last_name, e.salary, e.department_id, d.department_name
FROM HR.employees e JOIN HR.departments d
ON e.department_id = d.department_id
WHERE e.employee_id = 178;

-- {LEFT,RIGHT} OUTER JOIN (null���� ������ ���)
-- ����) ������ ���� �μ������� ����ϴµ� �μ��� ���� ������ ��µǰ� �Ͻÿ�.
-- ���� : �����ȣ, ��, �޿�
-- �μ����� : �μ���ȣ, �μ��̸�
SELECT e.employee_id, e.last_name, e.salary, e.department_id, d.department_name
FROM HR.employees e LEFT OUTER JOIN HR.departments d
--FROM HR.departments d RIGHT OUTER JOIN HR.employees e
ON e.department_id = d.department_id
WHERE e.employee_id = 178;

-- null�� ��µǴ� ���� (+)
SELECT e.employee_id, e.last_name, e.salary, e.department_id, d.department_name
FROM HR.employees e , HR.departments d
WHERE e.department_id = d.department_id(+)
AND e.employee_id = 178;

-- ����) ���������� �μ������� ����� �� ���μ��� ���� �� �ֵ�������. ����� ���� �μ������� ���
SELECT e.employee_id, e.last_name, e.salary, e.department_id, d.department_name
FROM HR.employees e RIGHT OUTER JOIN HR.departments d
ON e.department_id = d.department_id;

SELECT e.employee_id, e.last_name, e.salary, e.department_id, d.department_name
FROM HR.employees e , HR.departments d
WHERE e.department_id(+) = d.department_id;

-- FULL OUTER JOIN
-- ����) �μ��� ���� ������ ������ ���� �μ� ��� ����Ͻÿ�.
SELECT e.employee_id, e.last_name, e.salary, e.department_id, d.department_name
FROM HR.employees e FULL OUTER JOIN HR.departments d
ON e.department_id = d.department_id;



SELECT distinct manager_id
FROM HR.employees;

SELECT distinct e.employee_id, e.last_name, m.manager_id --, m.employee_id
FROM HR.employees e JOIN HR.employees m
ON e.employee_id = m.manager_id
--WHERE m.employee_id = 104
order by 1
;

-- 104�� ����� ���� ������ ���Ͻÿ�.
/*
HR.employees m �� Primary manager_id �� �����ִ� managers ���̺� �̶�� �����ϰ�
HR.employees e �� employee_id �� manager_id �� ���Ͽ� HR.employees e �� HR.employees m �� ���� �����ϰ�
HR.employees m �� employee_id ������ WHERE m.employee_id = 104�� �� ��� 104 ���� ����� ���������� ���� �� �ִ�.

*/ 
SELECT e.employee_id, e.last_name, m.manager_id, m.employee_id
FROM HR.employees e JOIN HR.employees m
ON e.employee_id = m.manager_id
--WHERE m.employee_id = 104
order by 1
;


-- ����) 104���� ����� ���� ������ ���Ͻÿ�. (���� ����)
SELECT employee_id, last_name, hire_date
FROM HR.employees
where employee_id = (
    SELECT manager_id FROM HR.employees where employee_id = 104
);