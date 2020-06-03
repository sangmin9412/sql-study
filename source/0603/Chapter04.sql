-- ��Ƽ �ο� �Լ�(�׷� �Լ�) - AVG, COUNT, MAX, MIN, STDDEV, SUM, VARIANCE
select count(*)
from HR.employees;

-- ������ ��¥�� ������ ����Ͻÿ�.
select sysdate, to_char(sysdate, 'D') "1~7", to_char(sysdate, 'Day') "����", to_char(sysdate, 'DD') "��¥"
from dual;

-- ������� �Ի��� ������ �������� ����Ͻÿ�
select employee_id, last_name, job_id, to_char(hire_date, 'D') "���� Number", to_char(hire_date, 'Day') "�Ի��� ����"
from HR.employees;

-- ���� ���� ��¥�� �Ͽ��ϰ� ������� ����Ͻÿ�.
select sysdate - to_char(sysdate, 'd') + 1, sysdate - to_char(sysdate, 'd')
from dual;

select next_day(sysdate, '�Ͽ���') "�̹� �� �� �Ͽ���", next_day(sysdate, '�����') "�̹� �� �� �����"
from dual;

select salary
from HR.employees
where job_id like '%REP%';
-- �� ������� �޿��� ���, �ִ� �޿�, �ּ� �޿��� ����Ͻÿ�
select trunc(avg(salary), 2) "���", max(salary) "�ִ�", min(salary) "�ּ�", sum(salary) "�հ�", job_id
from HR.employees
where job_id like '%REP%'
group by job_id;

--
select salary, job_id
from HR.employees
where job_id like '%REP%';

--
select job_id
from HR.employees
group by job_id;

-- ��ü ����� ��� �޿��� �ִ� �޿��� �ּ� �޿�,
-- �׸��� �޿��� �հ� �� �������� ����Ͻÿ�.
select trunc(avg(salary), 2) "���", max(salary) "�ִ�", min(salary) "�ּ�", sum(salary) "�հ�", sum(salary) / count(salary) avg
from HR.employees;

-- 50�� �μ��� ����� ���� ���Ͻÿ�.
select employee_id, last_name, job_id, salary, department_id
from HR.employees
where department_id = 50;

select count(department_id), count(*)
from HR.employees
where department_id = 50;

-- commission_pct�� ���ؼ� count�Լ��� ����ϼ���. -- null�� �������� �ʴ´�
select count(commission_pct), count(*)
from HR.employees;

-- 80�� �μ��� �������� commission �� �޴� �������� ����Ͻÿ�.
select count(*), count(commission_pct)
from HR.employees
where department_id = 80;

select commission_pct, department_id
from HR.employees
where department_id = 80;

-- ������ ���� �ִ� �μ��� ���� distinct - �ߺ�����
select count(distinct department_id)
from HR.employees;

select count(department_id), department_id
from HR.employees
group by department_id;

-- �������� ��� Ŀ�̼��� ���Ͻÿ�
select sum(commission_pct), count(*) ,(sum(commission_pct) / count(*)) "���", avg(nvl(commission_pct, 0))
from HR.employees;

/* *****************
* group function �� null�� �������� �ʴ´�.
******************* */

-- 50�� �μ��� �޿� ����� ���Ͻÿ�.
select avg(salary)
from HR.employees
where department_id = 50;

select trunc(avg(salary), 2), department_id
from HR.employees
group by department_id;

-- ������ �޿��� ��հ� �հ� �׸��� �ִ� ���� �ּ� ��, ������ ���� ����Ͻÿ�.
select avg(salary), sum(salary), max(salary), min(salary), count(*), job_id
from HR.employees
group by job_id;

-- 50�� �μ��� �μ���ȣ�� ������ ����Ͻÿ�.
-- ������ ������������ �����Ͻÿ�.

select department_id, job_id, sum(salary) "�հ�", avg(salary) "���", count(*)
from HR.employees
--where department_id = 50
group by department_id, job_id
order by department_id, job_id;

-- ������ ã���ÿ� ... �׸��� �����Ͻÿ�.
select department_id, count(last_name)
from HR.employees
group by department_id;

-- �� �μ��� �ִ� �޿��� ���ϴµ� ������ 'SA_REP'�� �ش�Ǵ� �͸� ����Ͻÿ�.
select count(*), department_id, job_id, max(salary) "�ִ� �޿�"
from HR.employees
where job_id = 'SA_REP'
group by department_id, job_id
order by department_id, job_id;
-- �� ���ǿ��� �ִ� �޿��� 10000 �̻��� �͸� ����Ͻÿ�. - group function �� ���� �� having �� ����Ѵ�.
select count(*), department_id, job_id, max(salary) "�ִ� �޿�"
from HR.employees
where job_id = 'SA_REP'
group by department_id, job_id
having max(salary) >= 10000 
order by department_id, job_id;

-- ������ �޿��� �հ踦 ���ϴµ� ������ REP�� ���ԵǾ� �ִ� ���� �������� 
-- �޿��� �հ谡 13000 ���� Ŀ�� �ϸ� �޿��� �հ踦 ������������ �����Ͻÿ�.
select job_id, sum(salary) sal
from HR.employees
where job_id like '%REP%'
group by job_id
having sum(salary) > 13000
order by sal;

-- �޿��� �հ谡 ���� ���� �μ��� �հ�ݾ��� ����Ͻÿ�.
select department_id, sum(salary)
from HR.employees
group by department_id
order by sum(salary) desc;

-- group function �ȿ� group functio �� ����� �� �ִ�.
select max(sum(salary))
from HR.employees
group by department_id;

-- ����) �����ȣ, ��, �Ի����� ����ϴµ� �� ����� �ҼӵǾ��ִ� �μ��� ��ձ޿���
-- ������ ��ձ޿� �׸��� �μ��� ������ ��� �޿��� ����Ͻÿ�.
/*
select employee_id, last_name, hire_date
from HR.employees
group by x;
*/
select employee_id, last_name, hire_date,
avg(salary)over(partition by department_id) "�μ��� ��� �޿�",
avg(salary)over(partition by job_id) "������ ��� �޿�",
avg(salary)over(partition by department_id, job_id) "�μ��� ������ ���"
from HR.employees;

-- Primary key(�⺻ Ű) : �ߺ���(x)
-- Foreign key(�ܷ� Ű) : �θ� ���̺� �ִ� Primary key �÷��� �ִ� �� "��"�� ������.

-- ����) ������̺� �ִ� �����ȣ, �̸�, �Ի��� �� ����ϰ� ����� ���� �ִ� �μ��� �μ����� ����Ͻÿ�.
select * from HR.employees;
select * from HR.departments;
select employee_id, last_name, hire_date, department_name, d.department_id
from HR.employees e, HR.departments d
where e.department_id = d.department_id;