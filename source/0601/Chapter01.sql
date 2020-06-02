-- desc = �÷�����Ʈ Ȯ��
desc HR.employees;
select * from HR.employees;
select employee_id, salary, commission_pct 
from HR.employees;

-- select ������ ������ Ȱ��
select last_name, salary, salary + 300, salary - 300, salary * 2, salary / 2
from HR.employees;

-- �Ŵ� 100�� �߰��� ����� �̸�, �޿�, ����
select first_name, salary + 100, (salary + 100) * 12
from HR.employees;

select last_name, job_id, salary, (salary*12)*commission_pct
from HR.employees;

-- colume ���� �����ϱ�
select last_name as name, commission_pct comm
from HR.employees;

-- colume ���� �����ϱ� ��ҹ��� �����ϴ� ��� ""
select last_name as "Name", commission_pct "Comm Pct"
from HR.employees;

-- ����) first_name �� '����'�̰� last_name�� '��' �϶�
-- '�̼���'�� ��µǵ��� �Ͻÿ�. -- �Ʒ� �ڵ�� ���ͷ�
select last_name || '   ' || first_name "fullName", 25
from HR.employees;

-- ����) �̼����� ������ �����Դϴ�. ó�� ����Ͻÿ�.
select last_name || ' ' || first_name || '�� ������ ' || job_id || ' �Դϴ�. ' "Name_Job"
from HR.employees;

-- ���ͷ� ���ڿ� �ȿ� Ư�����ڸ� ����Ϸ��� q'[ ...Text ]'
select department_id || q'[ it`s assigned Manager Id;]'
from HR.departments;

-- �ݺ������� ��µǴ� �μ��� �ѹ��� �������. - distinct
select distinct department_id
from HR.employees;

-- �μ��� ������ ����Ͻÿ�.
select distinct job_id, department_id
from HR.employees;


-- ************************* Selection *************************
-- (where)
select employee_id, last_name, job_id, department_id
from HR.employees
where department_id = 90;

-- �����Ͱ� ������ ��� ''
select employee_id, last_name, job_id, department_id
from HR.employees
where job_id = 'ST_MAN';

-- �����͸� ���� �� ��ҹ��� ���� �ؾ� ��.
select employee_id, last_name, job_id, department_id
from HR.employees
where last_name = 'Whalen';

-- ������ Ȱ��
select *
from HR.employees
where salary >= 3000 or salary <= 5000;

select *
from HR.employees
where hire_date < '05/12/01';

select *
from HR.employees
where first_name <= 'Neena';

-- ����) �Ի����� 02/01/01 ���� 04/12/31 ���̿� �Ի��� ������ ����Ͻÿ�.
select last_name, first_name, employee_id, hire_date
from HR.employees
where hire_date between '02/01/01' and '04/12/31';
-- where hire_date >= '02/01/01' and hire_date <= '04/12/31'; -- �� �� ����.

-- �޿��� 5000���� 10000���̿� �ִ� ������ ����Ͻÿ�.
select *
from HR.employees
where salary between 5000 and 10000;
-- where salary >= 5000 and salary <= 10000; -- �� �� ����.


-- �̸��� 'Lex'�̰� ������ 'AD_VP'�� ����� ����Ͻÿ�.
select *
from HR.employees
where first_name = 'Lex' and job_id = 'AD_VP';

-- �μ��� 10, 30, 50�� ������� ����Ͻÿ�.
select *
from HR.employees
where department_id in(10, 30, 50);
-- where department_id = 10 or department_id = 30 or department_id = 50; -- �� �� ����.

-- ������ 100 �̰ų� 120 �̰ų� 110�� ����� ����Ͻÿ�.
select *
from HR.employees
where manager_id in(100, 110, 120);
-- where manager_id = 100 or manager_id = 110 or manager_id = 120; -- �� �� ����.



desc HR.departments;
select * from HR.departments;
select department_id, location_id, manager_id
from HR.departments;



-- ���� ----------------------------------------------
-- les01
desc HR.departments;
select *
from HR.departments;

desc HR.employees;
select employee_id, last_name, job_id, hire_date as startdate
from HR.employees;

select distinct job_id
from HR.employees;

select last_name || ', ' || job_id "Employee and Title"
from HR.employees;
--where last_name = 'King';

select first_name || ', ' || 
last_name || ', ' || 
email || ', ' || 
phone_number || ', ' || 
hire_date || ', ' || 
job_id || ', ' || 
salary || ', ' || 
commission_pct || ', ' || 
manager_id || ', ' || 
department_id "THE_OUTPUB"
from HR.employees;

-- les02
select last_name, salary
from HR.employees
where salary >= 12000;

select last_name, department_id
from HR.employees
where employee_id = 176;

select last_name, salary
from HR.employees
where not salary between 5000 and 12000;

select last_name, job_id, hire_date 
from HR.employees
where hire_date between '05/02/20' and '05/05/01'
order by hire_date asc;

select last_name, department_id
from HR.employees
where department_id in (20, 50)
order by last_name asc;

select last_name "Employee", salary "Monthly Salary"
from HR.employees
where (salary between 5000 and 12000) and (department_id in (20, 50));

select last_name, hire_date
from HR.employees
where hire_date between '05/01/01' and '05/12/31';

-- les03

-- ----------------------------------------------