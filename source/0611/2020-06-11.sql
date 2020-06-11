create table emp
as 
select * from employees
where 1=2;

select * from emp;

���� 1) ������̺� �ִ� 90�� �μ��� ����� emp�� �����Ͻÿ�.
	
insert into emp(employee_id, last_name, email, hire_date , job_id, department_id)
select employee_id, last_name, email, hire_date , job_id, department_id
from employees
where department_id = 90;

select * from emp;


insert into emp(employee_id, last_name, email, hire_date , job_id, department_id)
values((select nvl(max(employee_id),0)+1 from emp),'LEE','SMLEE',sysdate,
'SA_REP', 90);

select * from emp;

���� 2) insert���� �÷�����Ʈ�� �ۼ��ϴ� �� ��� ���������� ����غ���.
INSERT INTO
        (SELECT employee_id, last_name, email, hire_date, job_id, 
                department_id
         FROM   emp
         WHERE  department_id = 90)
VALUES (99999, 'Taylor', 'DTAYLOR',TO_DATE('07-6��-20', 'DD-MON-RR'),
        'ST_CLERK', 90);

���� 3) emp�� 90�� �μ��� ����� �� �ְ� insert���� �ۼ��Ͻÿ�.
INSERT INTO
        (SELECT employee_id, last_name, email, hire_date, job_id, 
                department_id
         FROM   emp
         WHERE  department_id = 90
	 with check option) 
VALUES (100000, 'Taylor', 'DTAYLOR',TO_DATE('07-6��-20', 'DD-MON-RR'),
        'ST_CLERK', 80);
---ORA-01402: view WITH CHECK OPTION where-clause violation
---- 90�κμ��� �����͸� ������ �ȴ�.

���� 3)emp�� �ִ� �Ի����� �⺻ ���� sysdate�� ����.
alter table emp
modify (hire_date default sysdate);

���� 4) emp�� �ִ� 103�� ����� �Ի����� �⺻������ �����Ͻÿ�.
update emp
set hire_date = default
where employee_id = 103;


���� 5) 103�� ����� �ִٸ� Ŀ�̼��� 0.003�� �ְ� 
	103�� ��������� ��� �����͸� �Է��Ͻÿ�.
merge into emp e1
using (select employee_id from employees where employee_id = 103) e2
on( e1.employee_id = e2.employee_id)
When MATCHED THEN 
update set commission_pct = nvl(commission_pct,1) * 0.03
When NOT MATCHED THEN 
insert(e1.employee_id, e1.last_name, e1.email, e1.hire_date, 
	e1.job_id, e1.department_id)
values(103,'RHEE','SMRHEE',default,'SA_MAN',90);


select * from emp;


���� 6) 50�� �μ���ȣ��  ������ Ŀ�̼��� 0.5�� �����ϰ�
	������ 105,'RHEE','SMRHEE',default,'SA_MAN',90�� �Է��ϼ���.
merge into emp e1
using (select employee_id from employees where department_id = 50) e2
on( e1.employee_id = e2.employee_id)
When MATCHED THEN 
	update set commission_pct = 0.5,
		   hire_date = default
WHEN NOT MATCHED THEN 
insert(employee_id, last_name, email, hire_date, job_id, department_id)
values(105,'RHEE','SMRHEE',default,'SA_MAN',90);

---- 45�� insert��

���� 7) 104�� ����� �ִٸ� Ŀ�̼��� 0.003�� �ְ� 
	104�� ��������� ��� �����͸� �Է��Ͻÿ�.
merge into emp e1
using (select employee_id from employees where employee_id = 104) e2
on( e1.employee_id = e2.employee_id)
When MATCHED THEN 
update set commission_pct = 0.03
When NOT MATCHED THEN 
insert(e1.employee_id, e1.last_name, e1.email, e1.hire_date, 
	e1.job_id, e1.department_id)
values(104,'RHEE','SMRHEE',default,'SA_MAN',90);


���� 8) 105�λ���� ������ emp���� 105�� ����� �����ϰ� 
	������ 107,'SJ','SJRHEE', sysdate, 'SA_MAN',90
merge into emp e1
using (select employee_id from employees where employee_id = 105) e2
on( e1.employee_id = e2.employee_id)
When MATCHED THEN
	update set commission_pct = 0.03
	delete where employee_id = 105
When not MATCHED THEN
insert(e1.employee_id, e1.last_name, e1.email, e1.hire_date, 
	e1.job_id, e1.department_id)
values(107,'SJ','SJRHEE', sysdate, 'SA_MAN',90);	


merge
using
on 
When MATCHED THEN
	update
When not MATCHED THEN
insert
values

���� 9) 107�λ���� ������ emp���� 107�� ����� �����ϰ� 
	������ 107,'SJ','SJYI', sysdate, 'SA_MAN',90
merge into emp e1
using (select employee_id from employees where employee_id = 107) e2
on( e1.employee_id = e2.employee_id)
When MATCHED THEN
	update set commission_pct = 0.03
	delete where employee_id = 107
When not MATCHED THEN
insert(e1.employee_id, e1.last_name, e1.email, e1.hire_date, 
	e1.job_id, e1.department_id)
values(107,'SJ','SJRHEE', sysdate, 'SA_MAN',90);

select * from emp where employee_id = 107;


���� 10)employees�� �ִ� ����� emp���� �ִ� ��� emp���� ���� �Ͻÿ�.
delete from emp
where employee_id IN (select employee_id from employees);


���� 11) emp�� �ִ� 102 ����� job_id�� employees�� �ִ� ��ձ޿��� ���� ������ �����Ͻÿ�.

update emp
set job_id = (select job_id 
	      from employees
	      group by job_id
	      having avg(salary) = (select max(avg(salary))
			            from employees
				     group by job_id) 
		)
where employee_id = 102;


select * from emp where employee_id = 102;

���� 12) 179�� ����� 200�� ����� ����̸鼭
	 179�� ����� 200�� ����� �μ��� ���� �μ��� ������� ���Ͻÿ�.

select * from employees
where manager_id IN ( select manager_id from employees
		   where employee_id in (179, 200)) -- 149, 101
and department_id IN (select department_id from employees
			where employee_id in (179,200));


select * from employees
where manager_id IN ( 149,101) and department_id IN (80,10);


���� 13) 149���� ������ �μ��� ���� ������ ����Ͻÿ�.
	�� 149���� ����
select * from employees
where (job_id , department_id) = (select job_id, department_id
				  from employees
			          where employee_id = 149)
and employee_id <> 149;

���� 14) 199���� 174���� ���� �μ��� ���� �������� ���Ͻÿ�.
	��, 199���� 174���� ����
select * from employees
where (manager_id, epartment_id) in 
			(select manager,department_id
			 from employees
			 where employee_id in (174,199)
			)
and employee_id not in (174, 199);

���� 15)��� ��ȣ, ��, �׸��� �μ���ȣ�� ����ϴµ� �μ���ȣ�� �ּҹ�ȣ(location_id) 1800�� �ش��ϴ� �μ��� ��� 'KOR'�� ����ϰ� �������� 'USA'�� ����Ͻÿ�. employee_id, last_name , department_id (location����) ��� (20�� �μ��� KOR, �������� 'USA')
��, ���λ������ ���� ���������� ����� ��

select  employee_id, last_name,
	case  when department_id in (
			select department_id from departments
			where location_id = 1800
		) then 'KOR' else 'USA' end location    
 from employees;


select  employee_id, last_name,
	decode (department_id , (
				select department_id from departments
				where location_id = 1800
			), 'KOR' , 'USA') location
 from employees;

-- inline view
from���� ���Ǵ� ���������� �ζ��� �����Ѵ�.
select *
from (select deaprtment_id ,job_id
      from employees)

���� 16) �μ��� �ְ� �޿��� �ش��ϴ� ����� �������� ����Ͻÿ�.
select * from employees
where salary in (select max(salary) from employees
		 group by department_id);



���� 17)  �μ��� �ִ� �޿� �ش��ϴ� ������� ������ ���Ͻÿ�.

--�μ��� �ְ� �޿�
select department_id , max(salary)
from employees
group by department_id;

select employee_id, last_name, salary, d.department_id
from employees e, (select department_id , max(salary) sal
		   from employees
		   group by department_id) d
where e.department_id = d.department_id and e.salary = d.sal;


���� 18) �μ����� �ְ� �޿����� ���� �޿��� �޴� �����鸸 ����Ͻÿ�.
select employee_id, last_name, salary, d.department_id
from employees e, (
			select department_id, max(salary) maxsal
			from employees
			group by department_id 
		)
where e.department_id = d.department_id and salary < maxsal;


---- TOP - N
���� 19) �ֱ� �Ի��� ����� 5�� ����Ͻÿ�,
select rownum , employee_id, last_name, salary, department_id
from (select employee_id, last_name, salary, department_id
      from employees
      order by employee_id desc)
where rownum <= 5;

���� 20) �ֱ� �Ի��� ����� 11��° ���� 20��°���� employee_id, last_name, salary, department_id ���
select rownum, rn, employee_id, last_name, salary, department_id
from	(select rownum rn, employee_id, last_name, salary, department_id
	from (select employee_id, last_name, salary, department_id
      		from employees
      		order by employee_id desc))
where rn >= 11 and rn <= 20;






































































