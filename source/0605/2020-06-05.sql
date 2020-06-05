-- 'Abel'�� �޿��� ���� ����� �������.
select salary from hr.employees
where last_name = 'Abel'; 

select * from hr.employees
where salary = 11000;


select * from hr.employees
where salary = (select salary from hr.employees
where last_name = 'Abel');

--   'Abel'�� �޿����� ū ����� �������.
select salary from hr.employees
where last_name = 'Abel'; -- 'Abel'�޿�

select * from hr.employees
where salary > (select salary from hr.employees
where last_name = 'Abel');


-- 120�� ����� ������ ���� 121�� ����� �޿����� ū ������� ����Ͻÿ�.
select job_id from hr.employees
where employee_id = 120; -- SA_REP

select salary from hr.employees
where employee_id = 121; -- 10000

select * from hr.employees
where job_id = (select job_id from hr.employees
		where employee_id = 120)
and salary > (select salary from hr.employees
		where employee_id = 121)

-- ������ 'SA'�� �����ϰ� �ִ� ������ ���� �޿����� ���� ������� ����Ͻÿ�.

-- SA�� ����ȯ ������ �����޿�
select min(salary) from hr.employees
where job_id like '%SA%';

select * from hr.employees
where salary < (select min(salary) from hr.employees
		where job_id like '%SA%');

--- 50�� �μ��� ��� �޿����� ũ�� 140���� ������ ���� ������� ����Ͻÿ�.
select avg(salary) from hr.employees
where department_id = 50;

select job_id from hr.employees
where employee_id = 140;

select * from hr.employees
where salary > (select avg(salary) from hr.employees
		where department_id = 50)
and job_id = (select job_id from hr.employees
		where employee_id = 140);

-- �μ��� ���� ������ ������ ���� ���� �ϴ� ����� ����Ͻÿ�.
select job_id from hr.employees
where department_id is null;

select * from hr.employees
where job_id = (select job_id from hr.employees
		where department_id is null);


����) �̸��� Nancy�� ����� ������ ���� Ŀ�̼��� ���� ������ ��� �Ͻÿ�.
select job_id from hr.employees
where first_name = 'Nancy';

select * from hr.employees
where job_id = (select job_id from hr.employees
		where first_name = 'Nancy')
and commission_pct is null;


����) ���� 'Abel'�� ������ ������ ���� ���� ������ ����Ͻÿ�.
select job_id from hr.employees
where last_name = 'Abel';

select * from hr.employees
where job_id != (select job_id from hr.employees
		 where last_name = 'Abel');

����) ���� 'Abel'�� ������ ���� �ؿ� �Ի��� ������ ����Ͻÿ�.
select to_char(hire_date, 'yyyy') from hr.employees
where last_name = 'Abel';


select * from hr.employees
where to_char(hire_date, 'yyyy') = 
		(select to_char(hire_date, 'yyyy') 
	 	from hr.employees
		where last_name = 'Abel');


����) �μ����� 'Marketing'�� �μ��� ������� ����Ͻÿ�.
-- �μ���ȣ�� ����.
select department_id from hr.departmenrs 
where department_name = 'Marketing';

select * from hr.employees
where department_id  = 
		(select department_id 
		from hr.departmenrs 
		where department_name = 'Marketing')

--- ���� 'Hunold'�� ����� ������ ���� �̸����� 
'JMURMAN'�� ����� �μ��� �ִ� ������� ����Ͻÿ�.
selec job_id from hr.employees
where last_name = 'Hunold';

select department_id from hr.employees
where email = 'JMURMAN';

select * from hr.employees
where job_id = (selec job_id from hr.employees
		where last_name = 'Hunold')
and department_id = (select department_id 
		from hr.employees
		where email = 'JMURMAN');

-- �μ��� 80�̸鼭 ������ 'SA_REP' ����� ��� �޿����� ū ����� ����Ͻÿ�.
select avg(salary) from hr.employees
where department_id = 80 
and job_id = 'SA_REP'; 

select * from hr.employees
where salary > (select avg(salary) from hr.employees
		where department_id = 80 
		and job_id = 'SA_REP');

-- �� ������ ��� �޿��� ������ ��, ����, �Ի����� ����Ͻÿ�.
select avg(salary) from hr.employees;

select 
     round((select avg(salary) from hr.employees),2),
     last_name, job_id, hire_date
from hr.employees;

����) ���μ��� �����޿��� 90�� �μ��� �����޿����� ���� �μ��� ����Ͻÿ�.
select min(salary) from hr.employees
where department_id = 90;

select department_id , min(salary)
from hr.employees
group by deaprtment_id
having min(salary) < (select min(salary) from 			hr.employees
			where department_id = 90);


select 
from
where 
group by 
having 
order by

����) ���μ��� ��ձ޿��� 50�� �μ��� �ְ� �޿����� ū �μ��� ����Ͻÿ�.
select department_id , avg(salary)
from hr.employees
group by department_id
having avg(salary) > (select max(salary)
		      from hr.employees
		      where department_id = 50);

����) ������ ��ձ޿��� �� ������ ��ձ޿����� �������� �޿��� ���� ������ ����Ͻÿ�.
select job_id, avg(salary)
from hr.employees
group by job_id
having avg(salary) = (select min(avg(salary))
		      from hr.employees
		      group by job_id); 
����) ���μ��� ���� �޿��� ���� �޿��� �޴� ������� ���Ͻÿ�.
select min(salary) from hr.employees
group by department_id;

select * from hr.employees
where salary in (select min(salary) from hr.employees
		 group by department_id);

����) 'SA_REP'�� ������ ���� ������ �޿��� ���� �޿��� ���� �������� ���Ͻÿ�.
select salary from hr.employees
where job_id = 'SA_REP';

select * from hr.employees 
where salary in ( select salary from hr.employees
		where job_id = 'SA_REP');

����) 'SA_REP' �� ������ ���� ������ �޿��� ���� �޿��� ���� �����̸鼭 Ŀ�̼��� ���� ������ ����Ͻÿ�
select salary from hr.employees
where job_id = 'SA_REP';

select * from hr.employees
where salary in (select salary from hr.employees
		where job_id = 'SA_REP')
and commission_pct is null;

����) ������(���)�� �ƴ� �������� ���Ͻÿ�.
      (���������� ���� ������� ���Ͻÿ�)
select * from hr.employees
where employee_id not in 
	(select manager_id from hr.employees
	 where manager_id is not null);

����) �������� �������� ���Ͻÿ�.
select * from hr.employees
where employee_id in (select manager_id
		      from hremployees
		      where manager_id is not null);


����) �μ����� �ƴ� �������� ���Ͻÿ�.

select manager_id from hr.departments

select * from hr.employees
where employee_id not in (
		select manager_id from hr.departments
		where manager is not null
	);


--- union 
ȸ��(member) ���̺� �ִ� user_id, �������̺� �ִ� employee_id�� ���ϴ� ���̵� �ִ��� Ȯ������.

select user_id from member
where user_id = 'highland0'
union
select employee_id form employees
where employee_id = 'highland0';


����)������ �ִ� �����ȣ�� ������ ����ϰ� 
�����������̺�(job_history)�� �ִ� �����ȣ�� ������ ����Ͻÿ�.
select employee_id, job_id
from hr.employees
union
select employee_id, job_id
from hr.job_history;


select employee_id, job_id
from hr.employees
union all
select employee_id, job_id
from hr.job_history;


����)employee_id�� 'highland0'�̶�� ����ڰ� employees�� job_history�� ��ϵ� ��������� Ȯ���Ͻÿ�.
select employee_id 
from hr.employees
where employee_id = 'highland0'
union
select employee_id 
from hr.job_history
where employee_id = 'highland0'

����)employee_id�� '102'�̶�� ����ڰ� employees�� job_history�� ��ϵ� ��������� Ȯ���Ͻÿ�.
select employee_id 
from hr.employees
where employee_id = 102
union
select employee_id 
from hr.job_history
where employee_id = 102

����)employees(��ȭ), job_history(��ǰ)
-- job_id(��ǰ��ȣ), 
-- hire_date , START_DATE(���ų�¥)
-- employee_id (������) : 102

select job_id, hire_date , '��ȭ' gubun
from hr.employees
where employee_id = 102
union
select job_id, START_DATE, '��ǰ' gubun
from hr.job_history
where employee_id = 102;

--- ����, ���� �̸��� �޶� ������Ÿ���� ���ƾ��Ѵ�.


����) ���� ���̺����� �μ���ȣ, �Ի����� ����ϰ�
�μ� ���̺����� �μ���ȣ, �����ڵ带 ����Ͻÿ�.
select department_id ,hire_date , to_number(null) location_id
from hr.employees
union
select department_id,to_date(null),   location_id
from hr.departments


����) �������̺��� ������ȣ, ����, �޿��� ����ϴµ� ������ 'REP'�� �����Ͽ��� �Ѵ�.
      �������� ���̺����� ������ȣ ������ ����ϴµ� ���� ���۳��� '2002���̾�� �Ѵ�. 
      �޿� ��� 0�� ����Ͻÿ�.

select employee_id, job_id, salary
from hr.employees
where job_id like '%REP%'
union
select employee_id, job_id, 0
from HR.job_history
where to_char(START_DATE,'YYYY') = '2002'; 


======== DML ========
CREATE TABLE DEPARTMENTS
AS
SELECT * FROM HR.DEPARTMENTS;

SELECT * FROM DEPARTMENTS;

CREATE TABLE EMPLOYEES
AS 
SELECT * FROM HR.EMPLOYEES;

SELECT * FROM EMPLOYEES;

SELECT * FROM DEPARTMENTS
WHERE DEPARTMENT_ID = 300;

INSERT INTO departments(department_name,department_id, 
        manager_id, location_id)
VALUES ('Public Relations', 300,  100, 1700);

SELECT * FROM DEPARTMENTS 
WHERE DEPARTMENT_ID = 300;

SELECT * FROM DEPARTMENTS 
WHERE DEPARTMENT_ID = 301;

DESC departments;

INSERT INTO departments
VALUES ( 301,'�ֵ���ũ',  100, 1700); --(X)
-- apllication�� db�� �������� �ʰ� �ȴ�.

SELECT * FROM DEPARTMENTS
WHERE department_id = 301;


desc departments; -- not null�� �÷�Ȯ��,

����) null�� �÷����� ���� �������� ����.
insert into departments 
	   (department_id, department_name, manager_id, location_id)
values(302,'�ѹ���',null,null);


insert into departments 
	   (department_id, department_name)
values(303,'���������');

insert into departments 
values(304,'ǰ��������',null,null);

--- not null�� �μ��� null���� �Է��� ����.
insert into departments 
	(department_id, department_name, manager_id, location_id)
values(304,null,101,1400); --����
ORA-01400: cannot insert NULL into ("STUDY"."DEPARTMENTS"."DEPARTMENT_NAME")

����) ���� ��¥�� Ȯ������.
select sysdate from dual;


����) 210������� ������ �Է��ϴµ� �̸��� '����', ���� '��', �̸����� 'highland0', ���ѹ��� 01071461970, ������ȣ SA_REP, �Ի����� ����,�޿� 1000, Ŀ�̼� null,  ��� 205, �μ� 100�Դϴ�.

insert into employees(employee_id, first_name, last_name, email,
	phone_number, hire_date, job_id, salary, commission_pct,
	manager_id, department_id)
values(210, '����', '��', 'highland0', '01071461970', sysdate,
'SA_REP', 1000, null, 205, 100);

select * from employees
where employee_id = 210;
















 














