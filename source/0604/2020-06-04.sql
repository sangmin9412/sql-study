ANSI JOIN
-- NATURAL JOIN
-- �÷����� ���� �÷��� �� ����̵ȴ�.
SELECT department_id, department_name,
       location_id, employee_id, manager_id
FROM   hr.employees NATURAL JOIN hr.departments;
-- ���� �Ʒ��� ��ɹ��� ���� �ǹ̸� ���´�.

select department_id, department_name,
       location_id, employee_id, manager_id
from HR.employees  join HR.departments
using (department_id, manager_id); 

-- ���� �Ʒ��� ���� �ǹ��̴�.
select department_id, department_name,
       location_id, employee_id, manager_id
from hr.employees e join hr.departments
on e.department_id = d.department_id
and e.manager_id = d.manager_id;


--- �����̺��� ���� �̸��� �÷��� location_id�� �����Ƿ� location_id �� ���� ������ �ȴ�.
select department_id, department_name, location_id, city
from hr.departments NATURAL JOIN hr.locations;

select department_id, department_name, l.location_id, 	city
from hr.departments d JOIN hr.locations l 
on d.location_id = l.location_id;

--NATURAL JOIN�� ����ϴ� ��� �����ؾ� �� ���� ���� �̸��� �÷��� ��� ������������ ����ϰ� �ȴ�.


-- inner join 
select department_id, department_name, l.location_id, 	city
from hr.departments d JOIN hr.locations l 
on d.location_id = l.location_id;

-- using
select department_id, department_name,location_id, 	city
from hr.departments inner JOIN hr.locations 
using (location_id);

-- ASNI JOIN�� T-SQL JOIN��
--ANSI JOIN
select d.department_id, department_name,
       location_id, employee_id, e.manager_id
from HR.employees e  join HR.departments d
on e.department_id = d.department_id;

-- T-SQL
select d.department_id, department_name,
       location_id, employee_id, e.manager_id
from HR.employees e  , HR.departments d
where e.department_id = d.department_id;

-- ����) �����ȣ�� 120�� ����� �����ȣ, ��, �޿�,
�μ���ȣ, �μ���� ������ȣ�� ����Ͻÿ�.
select employee_id, last_name, salary, 
       e.department_id, department_name, location_id
from hr.employees e JOIN hr.departments d
on e.department_id = d.department_id
AND employee_id = 120;
-- where employee_id = 120;


-- ����) 101�� ��縦 ������ �ִ� ����� �����ȣ,��
, �޿�, �μ���ȣ, �μ����� ����Ͻÿ�.
select employee_id, last_name, salary, 
	d.department_id, department_name
from hr.employees e JOIN hr.departments d
on e.department_id = d.department_id
where e.manager_id = 101;

-- T-SQL
select employee_id, last_name, salary, 
	d.department_id, department_name
from hr.employees e, hr.deparments d
where e.department_id = d.department_id
and e.manager_id = 101;

-- ����)������ ����(�����ȣ, ��, ����, ���)�� ����� �� �μ��̸�, �μ���ȣ �׸��� �μ��� �ּ�(location_id)�� ����ϴµ� �μ���ȣ�� 90�� ������ ����Ͻÿ�.
- ANSI JOIN
select employee_id, last_name, job_id, e.manager_id,
      e.department_id, department_name, location_id
from hr.employees e join hr.departments d
on e.department_id = d.department_id
and e.department_id = 90;

- T-SQL JOIN
select employee_id, last_name, job_id, e.manager_id,
      e.department_id, department_name, location_id
from hr.employees e , hr.departments d
where e.department_id = d.department_id
and e.department_id = 90;

����) ���������� ����ϵ� ���� ��� �μ����� �ٹ��ϴ��� �μ����� ����Ͻÿ�. ( ansi, t-sql ��λ��)
��, ������ȣ, �μ���ȣ, �μ���, �����ڵ�
SELECT employee_id, last_name,
       d.department_id, department_name, location_id
FROM hr.employees e JOIN hr.departments d
ON e.department_id = d.department_id;

SELECT employee_id, last_name,
       d.department_id, department_name, location_id
FROM hr.employees e , hr.departments d
where e.department_id = d.department_id;


����) ���� �μ��� �μ����� ����� �������� ����Ʈ�� ����ϴµ� 30, 50, 90�� �μ��� ��� ( ansi, t-sql ��λ��)�����ȣ, ��, ���, �μ���ȣ, �μ���, �μ���
select employee_id, last_name, e.manager_id
       d.department_id, departmet_name, d.manager_id
from hr.employees e  join   hr.departments
on e.department_id = d.department_id  
and e.manager_id = d.manager_id 
where e.department_id in(30, 50, 90);

select employee_id, last_name, e.manager_id
       d.department_id, departmet_name, d.manager_id
from hr.employees e    ,    hr.departments
where e.department_id = d.department_id  
and e.manager_id = d.manager_id 
and e.department_id in(30, 50, 90);

-- 'REP'�� ���Ե� ������ ���� ����� �����ȣ�� ��, ����, �μ���ȣ, �μ���, �μ����ȣ�� ����Ͻÿ�.
select employee_id, last_name, job_id, 
       d.department_id, department_name, d.manager_id
from hr.employees e join hr.departments d
on e.department_id = d.department_id 
and job_id like '%REP%';

select employee_id, last_name, job_id, 
       d.department_id, department_name, d.manager_id
from hr.employees e , hr.departments d
where e.department_id = d.department_id 
and job_id like '%REP%';


-- �μ������� ����� �� �μ��� �ּҵ� ��� ����Ͻÿ�.
-- �μ� : departments, �ּ� ���� : locations
-- �μ���ȣ, �μ���, �μ����ȣ,
-- COUNTRY_ID, CITY, STREET_ADDRESS, location_id
-- select * from hr.locations;
select department_id, department_name, manager_id,
      l.location_id,  COUNTRY_ID, CITY, STREET_ADDRESS
from hr.departments d join hr.locations l
on d.location_id = l.location_id; 


-- ������ �����ִ� �μ��� �ּ������� �������.
-- �����ȣ, ��, �Ի��� 
--  �μ���ȣ, �μ���, �μ���
-- COUNTRY_ID, CITY, STREET_ADDRESS, location_id
-- T-SQL join
select employee_id, last_name, hire_date,
      d.department_id, department_name, d.manager_id,
      l.location_id, COUNTRY_ID, CITY, STREET_ADDRESS 
from hr.employees e , hr.departments d, hr.locations l
where e.department_id = d.department_id
and d.location_id = l.location_id;


-- ansi join
select employee_id, last_name, hire_date,
      d.department_id, department_name, d.manager_id,
      l.location_id, COUNTRY_ID, CITY, STREET_ADDRESS 
from hr.employees e join hr.departments d
on e.department_id = d.department_id 
		    join hr.locations l
on d.location_id = l.location_id;

����) 
������ �����ִ� �μ��� �ּ������� �������.
--�����ȣ, ��, �Ի��� 
--�μ���ȣ, �μ���, �μ���
-COUNTRY_ID, CITY, STREET_ADDRESS, location_id
�̶� �μ���ȣ�� 90�� ���������� ����Ͻÿ�.
-- ANSI JOIN
select employee_id, last_name, hire_date, 
       d.department_id, department_name, d.manager_id,
       COUNTRY_ID, CITY, STREET_ADDRESS, l.location_id
from  hr.employees e  join hr.departments d
on e.department_id = d.department_id  
		              join hr.locations l
on d.location_id = l.location_id
where e.department_id = 90;

--- ���� ������ ���ؼ� ����Ͻÿ�
select * from hr.jobs;
job_id : primary key
--- �������
select * from hr.employees;
employee_id : primary key 
job_id : foreign key
department_id : foreign key
--- �μ�����
select * from hr.departments;
department_id : primary key
location_id : foreign key
-- �ּ� ����
select * from hr.locations;
location_id : primary key

select job_title, employee_id, last_name,
       department_name, STREET_ADDRESS
from hr.jobs j join hr.employees e
on j.job_id = e.job_id 
		join hr.departments
on e.department_id = d.department_id
		join hr.locations
on d.location_id = l.location_id;

select job_title, employee_id, last_name,
       department_name, STREET_ADDRESS
from hr.jobs j, hr.employees e, hr.departments d, hr.locations l
where j.job_id = e.job_id 
and e.department_id = d.department_id
and d.location_id = l.location_id;

����) �μ��� 20�̰ų� 50�� �μ��� �����ȣ�� �μ���ȣ �� �μ��� �׸��� ��ġ������ ����Ͻÿ�.
select employee_id, e.department_id, department_name,
       location_id
from hr.employees e join hr.departments d
on e.department_id = d.department_id
and e.department_id in(20,50);

select employee_id, e.department_id, department_name,
       location_id
from hr.employees e , hr.departments d
where e.department_id = d.department_id
and e.department_id in(20,50);

����) Matos��� ���� ������ �ִ� ����� �ִ�.
�� ����� �μ������� �����ȣ �׸��� ���� ����Ͻÿ�.
select employee_id, last_name, d.deparment_id,
	department_name
from hr.employees e join hr.departments d
on e.department_id = d.department_id
and last_name = 'Matos';

select employee_id, last_name, d.department_id,
	department_name
from hr.employees e , hr.departments d
where e.department_id = d.department_id
and last_name = 'Matos';

����) Matos��� ���� ������ �ִ� ����� King��� ���� 
      ���� ����� �ִ�.
�� ����� �μ������� �����ȣ �׸��� ���� ����Ͻÿ�.
select last_name, employee_id, 
       d.department_id, department_name
from hr.employees e join hr.departments d
on e.department_id = d.department_id
and last_name in ('Matos', 'King');

select last_name, employee_id, 
       d.department_id, department_name
from hr.employees e , hr.departments d
where e.department_id = d.department_id
and last_name in ('Matos', 'King');

����) King��� ���� ������ �ִ� ����� �ִ�.
�� ����� �μ������� �����ȣ �׸��� ���� ����Ͻÿ�.
select employee_id, last_name, d.department_id,
	department_name
from hr.employees e join hr.departments d
on e.department_id = d.department_id
and last_name = 'King';

select employee_id, last_name, d.department_id,
	department_name
from hr.employees e , hr.departments d
where e.department_id = d.department_id
and last_name = 'King';


����) �μ����̺��� �μ���ȣ�� �μ��� �׸��� �����ڵ�� �������� ����ϴµ� �����ڵ尡 1400�� ������ ��� 

select department_id, department_name, 
	l.location_id, STREET_ADDRESS
from hr.departments d join hr.locations l
on d.location_id = l.location_id
and l.location_id = 1400;

select department_id, department_name, 
	l.location_id, STREET_ADDRESS
from hr.departments d , hr.locations l
where d.location_id = l.location_id
and l.location_id = 1400;


����) ����� �ϰ� �ִ� ���� �̸��� ����� �μ����� ����ϴµ� �����ȣ �̸��� ����Ͻÿ�.
��, ������ȣ�� 'SA'�� �����ϰ� �ִ� ������ '2005'�⿡ �Ի��� ����� ����Ͻÿ�.
select job_title, employee_id, first_name, 		department_name
from hr.jobs j 
		join hr.employees e
on j.job_id = e.job_id
	       join hr.departments d
on e.department_id = d.department_id
and e.job_id like '%SA%' 
and to_char(hire_date,'yyyy') = '2005';


select job_title, employee_id, first_name, 			department_name
from hr.jobs j ,  hr.employees e, hr.departments d
where j.job_id = e.job_id 
and e.department_id = d.department_id
and e.job_id like '%SA%' 
and to_char(hire_date,'yyyy') = '2005';


����) 104�� ����� ����� ������ ����Ͻÿ�.
select e2.employee_id, e2.last_name, e2.hire_date
from hr.employees e1 , hr.employees e2
where e1.manager_id = e2.employee_id
and e1.employee_id = 104;

����) �����̸��� ������ ��� �̸��� ����Ͻÿ�.
select e.first_name, m.first_name
from hr.employees e , hr.employees
where e.manager_id = m.employee_id;

--- �μ��� ���� ����� ����Ͻÿ�.
select * from hr.employees
where department_id is null;
-- ������ ���� �μ������� ����Ͻÿ�.
-- ����: �����ȣ , ��, �޿�
-- �μ�: �μ���ȣ, �μ��̸�
-- ��, 178 ����� ����Ͻÿ�.
select employee_id, last_name, salary,
       d.department_id, department_name
from hr.employees e, hr.departments d
here e.department_id = d.department_id
and e.employee_id = 178;

����) ������ ���� �μ� ������ ����ϴµ� �μ��� ���� ������ ����ϰ� �϶�.
-- ����: �����ȣ , ��, �޿�
-- �μ�: �μ���ȣ, �μ��̸�
select employee_id, last_name, salary,
	d.department_id, department_name
from hr.employees e left outer join hr.deaprtments d
on e.department_id = d.department_id
where e.employee_id = 178;

select employee_id, last_name, salary,
	d.department_id, department_name
from hr.employees e , hr.deaprtments d
where e.department_id = d.department_id(+)
and e.employee_id = 178;

-- null�� ��µǴ� ���� (+)�� �д�.


����) ���������� �μ������� ����� �� ��� �μ��� ���ü� �ֵ�������. 
-- ����� ���� �μ������� ���
-- ����: �����ȣ , ��, �޿�
-- �μ�: �μ���ȣ, �μ��̸�
select employee_id, last_name, salary,
	d.department_id, department_name
from hr.employees e right outer join hr.departments d
on e.department_id = d.department_id;

select employee_id, last_name, salary,
	d.department_id, department_name
from hr.employees e , hr.departments d
where d.department_id = e.department_id(+);


����)�μ��� ���� ������ ���� ���� �μ��� ��� ����ϰ� �ʹ�.
-- ����: �����ȣ , ��, �޿�
-- �μ�: �μ���ȣ, �μ��̸�
select employee_id, last_name, salary,
       d.department_id, department_name
from hr.employees e full outer join hr.departments d
on e.department_id = d.department_id;



























