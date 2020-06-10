-������ �׼����� �����ϱ� ����
-������ ���Ǹ� ���� �ۼ��ϱ� ����
-������ �������� �����ϱ� ����
-������ �����ͷκ��� �پ��� ����� ��� ����

 ���� 1) �����ȣ, �̸�, ����, Ŀ�̼��� ������ ����� �������.
select employee_id, first_name, job_id, 
	(nvl(commission_pct, 0) * salary) + salary year_sal
from employees;

���� 2) �� ������ view�� ������.
create view yearsal
as 
select employee_id, first_name, job_id, 
	(nvl(commission_pct, 0) * salary) + salary year_sal
from employees;

select * from yearsal;


���� 3) �����ȣ, �� �̸�, �޿�, �Ի���, �μ��� ����Ҷ� view�� ���ؼ� ����ϵ�������.

create view empview
as
select employee_id id_nember, last_name || ' ' || first_name name, 
	salary sal , hire_date , department_id dept_id
from employees;


select * from empview;

���� 4) ���� ���� view���� id_number, name�� ����Ͻÿ�.
select id_nember, name
from empview;


���� 5) ��view���� id_nember�� id_number�� ��������.
create or replace view empview
as
select employee_id id_number, last_name || ' ' || first_name name, 
	salary sal , hire_date , department_id dept_id
from employees;

select id_number, name
from empview;

���� 6) �μ���ȣ�� 90�� ����鸸 view�� ���ؼ� ����Ͻÿ�.
select * from empview
where dept_id = 90; -- department_id����� �� ����.
                    -- view�� ���� �� �÷����� �����߱� ����..

���� 7) ������ 'SA'�����ϴ� ������� view�� ���ؼ� ����Ͻÿ�.
select * from  empview
where job_id like '%SA%'; 
ORA-00904: "JOB_ID": invalid identifier
������ view�� job_id�� ��� ���� ����


���� 8)���� 7�� ������ �� �ֵ��� �����Ͻÿ�.
create or replace view empview
as
select employee_id id_number, last_name || ' ' || first_name name, 
	salary sal , hire_date , department_id dept_id, job_id
from employees;

���� 9) ���� 7�� �ٽ� ������Ѻ���.
 select * from  empview
where job_id like '%SA%'; 


���� 10) ���� 8�� view���� �÷��� ��Ī�� ����������� view�� �÷����� ������ ����.
create or replace view empview
(id_number, name, sal, hire_date, dept_id, job_id )
as
select employee_id , last_name || ' ' || first_name , 
	salary  , hire_date , department_id , job_id
from employees;

select * from empview;


���� 11) �μ��� �޿��� ���, �հ�, �ְ� ��, �׸��� ���� ���� view�� ���ؼ� ����Ͻÿ�.view���� salview�̴�.
create or replace view salview
as
select department_id , avg(salary) avgsal, sum(salary) sumsal,
	max(salary) maxsal, min(salry) minsal
from employees
group by  department_id;

select * from salview;

���� 12)  ���� 11���� �μ��� ��� ���� 10000�̻��� �μ��� ����Ͻÿ�.
select * from salview
where avg(salary) >= 10000; --(X)

 select * from salview
where avgsal >= 10000; --(O)

���� 13) �����ȣ, ��, �̸���, �Ի���, ����, �μ���ȣ�� ������ view�� ����ÿ�. salview�� view������ �Ѵ�.

create  or replace view salview
(emp_id, lname, email, HIRE_DATE, JOB_ID, dept_id)
as
select EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID, DEPARTMENT_ID
from employees;

select * from salview;

���� 14) salview�� ������ �÷��� 400, RHEE, SMRHEE, ���糯¥, 'SA_MAN', 70
�� �Է��Ͻÿ�.
insert into  salview(emp_id, lname, email, HIRE_DATE, JOB_ID, dept_id)
values(400, 'RHEE', 'SMRHEE', sysdate, 'SA_MAN', 70);

select * from salview
where emp_id = 400;

select * from employees
where employee_id = 400;

--- view�� ���ؼ� insert�� �ϴ� ��쿡�� ���� ���̺� �����̵Ǵ� ���̹Ƿ�
-- not null�� �÷��� �� view�� �־�� �Ѵ�.

���� 15) view�� salview�� ���ؼ� �μ� ��ȣ�� 70�� �μ��� ����� ���� �Ͻÿ�.
select * from employees where department_id = 70;

delete from salview
where dept_id = 70;

select * from employees where department_id = 70;

���� 16) �μ��� ��� �޿��� �հ�, �ְ�, ������ ��µǰ� 
slaview1�� view�� ����ÿ�.

create  or replace view salview1
(dname, avgsal,sumsal, maxsal, minsal)
as
select department_name, avg(salary), sum(salary), max(salary), min(salary) 
from employees e, departments d
where e.department_id = d.department_id
group by  department_name;

select * from salview1;

���� 17) �����ȣ, ��, �̸���, �Ի���, ���� , �μ���ȣ, �μ����� empview1�̶�� view�� ���ؼ� ����Ͻÿ�.
create  or replace view empview1
(emp_id, lname, email, HIRE_DATE, JOB_ID, dept_id, dname)
as
select EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID, d.DEPARTMENT_ID,
	department_name
from departments d, employees e
where d.department_id = e.department_id;

select * from empview1;


���� 18)  empview1�� �ִ� emp_id, lname, email, HIRE_DATE, JOB_ID��
���� 400, 'RHEE', 'SMRHEE', sysdate, 'SA_MAN'�� �����Ͻÿ�.

insert into  empview1(emp_id, lname, email, HIRE_DATE, JOB_ID)
values(400, 'RHEE', 'SMRHEE', sysdate, 'SA_MAN');

-- ���պ�� DML���� ����� �� ���� �� �� �ִ�.
SQL ����: ORA-01779: cannot modify a column which maps to a non key-preserved table
primary key�� �������� ����  table�� ���ؼ��� ���� ������ �� ����.

























 





































