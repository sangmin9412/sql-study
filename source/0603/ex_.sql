-- ����) ���� ��ü���� �Ի����� ���� ���� ����� �ֱٿ� �Ի��� ����� ����Ͻÿ�.
select min(hire_date), max(hire_date)
from HR.employees;

-- ����) ����� ���� ����Ͻÿ�.
select count(*)
from HR.employees;

-- ����) �������̺��� �μ��� ������� ����Ͻÿ�.
select count(distinct department_id)
from HR.employees;

-- ����) ��� ���̺��� �� �μ��� �޿������ ������.
select distinct avg(salary)over(partition by department_id)
from HR.employees;

select avg(salary)
from HR.employees
group by department_id;

-- ����) �� �������� �μ��� ������������ �����ϰ� ����Ͻÿ�.
select avg(salary), department_id
from HR.employees
group by department_id
order by 2;

-- ����) �� �μ��� �޿��� ����� ���ϰ� ��հ��� ���� �ͺ��� ����Ͻÿ�.
select avg(salary), department_id
from HR.employees
group by department_id
order by 1;

-- ����) �� �μ��� �ִ� ����� ������ �޿��� ����� ���Ͻÿ�.
select avg(salary), department_id, job_id
from HR.employees
group by department_id, job_id;

-- ����) ������ REP�� ���ԵǾ� �ִ� ������� ��� �޿��� �ּұ޿�, �ִ�޿�, �޿��� �հ踦 ���Ͻÿ�
select avg(salary), min(salary), max(salary), sum(salary)
from HR.employees
where job_id like '%REP%';
--group by job_id;

-- ����) �������� 4��°���� 6��°���� PRO�� �ִٸ� it_program���� ���
--                                    ACC�� �ִٸ� finance_account
--                                    �������� business�� ����Ͻÿ�.
select job_id, substr(job_id, 4, 3),
case substr(job_id, 4, 3) when 'PRO' then 'it_program'
                            when 'ACC' then 'finance_account'
                            else 'business' end job
from HR.employees;

-- ����) �޿��� 15000 �̻��̸� �ӿ����� ���
--             10000 �̻��̸� ����
--             7000 �̻��̸� ����
--             5000 �̻��̸� ����
--             �������� ������� ����Ͻÿ�.
select last_name, salary, job_id,
    case when salary >= 15000 then '�ӿ�'
        when salary >= 10000 then '����'
        when salary >= 7000 then '����'
        when salary >= 5000 then '�븮'
    else '���' end "����"
from HR.employees;

-- ����) �μ��� �޿��� ����� 5000�̻��� �μ��� ����Ͻÿ�
select trunc(avg(salary), 2), department_id
from HR.employees
group by department_id
having avg(salary) >= 5000;

-- ����) �޿��� 10000�̻��� ������� �μ��� �޿� ����� 160000�̻��� �μ��� ����Ͻÿ�.
select department_id, salary, avg(salary), count(*)
from HR.employees
where salary >= 10000
group by department_id, salary
having avg(salary) >= 16000;

-- ����) �Ի����� 2005�⵵ ������ �Ի��� ����� �� �μ��� �ִ�޿��� 8000�̻��� �μ��� �ִ� �޿��� ����Ͻÿ�.
select department_id, max(salary)
from HR.employees
where hire_date < to_date('20050101', 'yyyymmdd')
group by department_id
having max(salary) >= 8000;

-- ����) �μ��� �ִ� �޿��� 10000 �̻��� �μ��� ����Ͻÿ�.
select max(salary), department_id
from HR.employees
group by department_id
having max(salary) >= 10000
order by 2;

-- ����) ������ 'REP' �����ϰ� ���� ���� ������� ������ �޿��� �հ谡
-- 13000�� �ʰ��ϴ� ������ �޿��� �հ踦 ����Ͻÿ�.
-- ���� �޿��� �հ踦 ������������ �����Ͽ� ����Ͻÿ�.
select job_id, sum(salary)
from HR.employees
where job_id not like '%REP%'
group by job_id
having sum(salary) > 13000
order by 2 desc;

-- ����) 'REP'�� ���ԵǾ� �ִ� ������ �޿��� ��հ� �ְ� �޿��� ���� �޿��� �� �޿��� �հ踦 ����Ͻÿ�.
select avg(salary), max(salary), min(salary), sum(salary)
from HR.employees
where job_id like '%REP%';

-- ����) ��ü ����� ��� �޿��� �ִ� �޿��� �ּ� �޿�, �׸��� �޿��� �հ� �� �������� ����Ͻÿ�.
select avg(salary), max(salary), min(salary), sum(salary), count(*)
from HR.employees;

-- ����) 50�� �μ��� ������� ���Ͻÿ�.
select count(*), count(department_id)
from HR.employees
where department_id = 50;

-- ����) Ŀ�̼��� �޴� ����� ���� ���Ͻÿ�.
select count(*), count(commission_pct)
from HR.employees;
--where commission_pct is not null;


-- ����) �� ȸ���� ��� Ŀ�̼��� ��� �ǳ�?
select avg(nvl(commission_pct, 0)), sum(commission_pct) / count(*)
from HR.employees;

-- ����) �μ��� �޿� ����� ���Ͻÿ�.
select department_id, avg(salary)
from HR.employees
group by department_id;

-- ����) ������ �޿��� ��հ� �հ� �׸��� �ְ� ���� ���� ��, ������ ���� ���Ͻÿ�.
select avg(salary), max(salary), min(salary), count(*)
from HR.employees
group by job_id;

-- ����) 50�� �μ��� �μ���ȣ�� ������ ����Ͻÿ�. ������ ������������ �����Ͻÿ�.
select department_id, job_id
from HR.employees
where department_id = 50
order by job_id desc;

-- ����) �� �μ��� ������ �ִ�޿��� ���ϴµ�, ������ 'SA_REP'�� �ش�Ǵ� �͸� ����Ͻÿ�.
select max(salary), job_id, department_id
from HR.employees
where job_id = 'SA_REP'
group by department_id, job_id;
-- ����) �� ���ǿ��� �ִ� �޿��� 10000�̻��� �͸� ����Ͻÿ�.
select max(salary), job_id, department_id
from HR.employees
where job_id = 'SA_REP'
group by department_id, job_id
having max(salary) >= 10000;

-- ����) ������ �޿��� �հ踦 ���ϴµ� ������ MAN�� ���ԵǾ� �ִ� ���� ��������
-- �޿��� �հ谡 15000�̻� �̾�� �ϸ� �޿��� �հ踦 ������������ �����Ͻÿ�.
select avg(salary)
from HR.employees
where job_id like '%MAN%'
group by job_id
having avg(salary) >= 15000
order by 1 desc;

-- ����) �����ȣ, ��, �Ի����� ����ϴµ� �� ����� �ҼӵǾ� �ִ� 
-- �μ��� ���� ���� �Ի��ϰ� ���� ���� �Ի���, �׸��� �μ��� ������ ���� ����� ���� ���� �޿��� ����Ͻÿ�.
select employee_id, last_name, hire_date, department_id, salary,
min(hire_date)over(partition by department_id) "���� ���� �Ի���", 
max(hire_date)over(partition by department_id) "���� ���� �Ի���",
max(salary)over(partition by department_id) "���� ���� �޿�"
from HR.employees;


--------------------------------------------------------------------------
select employee_id, last_name, salary, d.department_id, d.department_name
from HR.employees e, HR.departments d;

