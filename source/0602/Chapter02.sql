-- ������ ������ {���ڿ�} ã�� - like
select *
from HR.employees
where last_name like '%o%' or email like '%o%';

-- String sql = "select * from HR.employees"
--            + "where last_name like '%' + or email like '%o%'";

-- {���ڿ�} �� �����ϴ�
-- ���� 'A'�� �����ϴ� �̸��� ����Ͻÿ�.
select * from HR.employees
where first_name like 'A%';

-- {���ڿ�} �� ������
-- ���� �̸��� 'a'�� ������ 
select * from HR.employees
where first_name like '%a';

-- 2002�⵵�� �Ի��� ������� ����Ͻÿ�.
select * from HR.employees
where hire_date like '02%';

-- �ι�° ���ڿ� 'o'�� �̸��� ���Ե� ����� ����Ͻÿ�.
select * from HR.employees
where first_name like '_o%';

-- ����° ���ڿ� 'o'�� ���ԵǾ� �ִ� ����� ����Ͻÿ�.
select * from HR.employees
where first_name like '__o%';

-- �ڿ��� �̸��� �ι�°�� 'o'�� ���ԵǾ� �ִ� ����� ����Ͻÿ�.
select * from HR.employees
where first_name like '%o_';

-- �̸��� sa�� ���Ե� ����� ����Ͻÿ�.
select * from HR.employees
where first_name like '%sa%';

-- �̸��̳� �̸��Ͽ� sa�� ���Ե� ����� ����Ͻÿ�.
select * from HR.employees
where first_name like '%sa%' or email like '%sa%';


-- where is
select last_name, job_id, commission_pct
from HR.employees;

-- Ŀ�̼��� ���� ���ϴ� ����� ����Ͻÿ�.
select *
from HR.employees
where commission_pct is null;

-- Ŀ�̼��� �޴� ����� ����Ͻÿ�.
select *
from HR.employees
where not commission_pct is null;

-- �μ��� ���� ����� ����Ͻÿ�.
select *
from HR.employees
where department_id is null;

-- �μ��� �ִ� ����� ����Ͻÿ�.
select *
from HR.employees
where not department_id is null;


-- and | or
-- �޿��� 10000�̰ų� ������ MAN�� �����ϰ� �ִ� ����� ����Ͻÿ�.
select *
from HR.employees
where salary = 10000 or job_id like '%MAN%';

-- �޿� 150000�̻��̸鼭 ������ 'SA_PER'�̰ų� 'AD_PRES'�� ����� ����Ͻÿ�.
select *
from HR.employees
where salary >= 15000 and job_id in ('SA_REP', 'AD_PRES');

-- �μ��� 30�̰� 60�� �μ����� �޿��� 10000 �̻��� ����� ����Ͻÿ�.
select *
from HR.employees
where department_id in (30, 60) and salary >= 10000;


-- order by -- [asc = �������� desc = �������� asc = default]
-- �̸��� ������������ �����Ͽ� ���
select *
from HR.employees
order by first_name;

-- �Ի����� ���� ������� ����Ͻÿ�.
select *
from HR.employees
order by hire_date asc;

-- �ֱٿ� �Ի��� ������� ����Ͻÿ�.
select *
from HR.employees
order by hire_date desc;

-- �����ȣ, ��, ������ ����ϴµ� ������ ansal�� ����Ͻÿ�.
select employee_id, last_name, salary * 12 "ansal"
from HR.employees;
-- �� ���뿡�� ������ ������������ ����Ͻÿ� - ���� �� �� [��ȣ,��Ī�� ����� �� �ִ�]
select employee_id, last_name, salary * 12 "ansal"
from HR.employees
order by "ansal";
-- order by 3;

-- �μ��� ������������ ���� �μ��� ������� �޿��� ������������ �����Ͻÿ�.
select *
from HR.employees
order by department_id, salary desc;

-- 50�� �μ��� ������� ������ ������������ �����ϰ� ������ ���� �޿��� ������������ �����Ͻÿ�.
select *
from HR.employees
where department_id = 50
order by job_id desc, salary;

-- �޿��� 10000�� �ƴ� ������� ����Ͻÿ�.
select *
from HR.employees
where salary != 10000;
-- where salary ^= 10000;
-- where salary <> 10000;

-- ������ 'SA_REP', 'AD_PRES'�� �������� �ʴ� ������� ����Ͻÿ�.
select *
from HR.employees
where job_id not in ('SA_REP', 'AD_PRES');
--where not (job_id = 'SA_REP' or job_id = 'AD_PRES');
--where job_id != 'SA_REP' and job_id != 'AD_PRES';

-- ���� ����� �޿��� 3000���� �۰� 10000���ٴ� ū ����� ����Ͻÿ�.
select *
from HR.employees
where salary not between 3000 and 10000;