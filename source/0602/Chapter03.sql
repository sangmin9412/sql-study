-- lower = �ҹ��ڷ� ����, upper = �빮�ڷ� ����
-- ����� �� higgins ��� ����� ����Ͻÿ�.
select *
from HR.employees
where lower(last_name) = 'higgins';

select last_name, lower(last_name), upper(last_name)
from HR.employees;

-- ���� �̸��� �ٿ��� ����Ͻÿ�. �޿��� ������ ���� ����Ͻÿ�.
select last_name || first_name name, salary, job_id
from HR.employees;
select concat(last_name, first_name) name, salary, job_id
from HR.employees;

-- ���� �̸��� �ٿ��� ����Ͻÿ�. �޿��� ������ ���� ����Ͻÿ�.
select last_name, first_name, length(first_name)
from HR.employees;

-- substr(String = ���ڿ� ��, Number = �ڸ� ����, Number = ���� ����);
-- �����ȣ�� �̸�, ����, �޿��� ����ϴµ� ������ 4��°���ڰ� REF��
-- �����ϴ� ����� ���Ͻÿ�.
select employee_id, first_name, job_id, salary
from HR.employees
where substr(job_id, 4) = 'REP';
--where job_id like '___REP%';

-- ������ 4��° ���� 2��¥�� PR�� ������ ����Ͻÿ�.
select *
from HR.employees
where substr(job_id, 4, 3) = 'PRO';

-- �����ȣ�� �޿�, ������ ����ϴ� �� ������ 4��°���� 3��¥�� ����Ͻÿ�
select employee_id, salary, job_id, substr(job_id, 4, 3)
from HR.employees;

-- �����ȣ�� �޿�, ������ ����ϴ� �� ������ �ڿ��� 3���ں��� 2���� ����Ͻÿ�.
select employee_id, salary, job_id, substr(job_id, -3, 2)
from HR.employees;

-- ������ �ڿ��� 3���ں��� 2���ڰ� RE�� ������� ����Ͻÿ�.
select *
from HR.employees
where substr(job_id, -3, 2) = 'RE';

-- instr
-- �̸��� s��� ���ڰ� �ִ� ��� ���°���� ����Ͻÿ�. (indexOf()) first_name.indexOf('s') = �ڹ� Syntax
select first_name, instr(first_name, 's')
from HR.employees;

-- �̸��� 's'�� 6��°�� �ִ� ����� ����Ͻÿ�.
select *
from HR.employees
where instr(first_name, 's') = 6;

-- �����ȣ, �� �̸�, ����, �̸��� ����, �׸��� ���� 'a'�� �ִ� ��ġ�� ����ϴµ� ������ 4��° ���ں��� 3���ڰ� 'REP'�� ����� ����Ͻÿ�
select employee_id, last_name || ' ' || first_name name, job_id, length(first_name), instr(last_name, 'a')
from HR.employees
where substr(job_id, 4, 3) = 'REP';


-- �����ȣ, ��, ����, �޿��� ����ϴµ� �޿��� 1234�� ���� �� 1000���� ���� ���� ����Ͻÿ�.
select employee_id, last_name, job_id, (salary + 1234) / 1000
from HR.employees;
-- �ݿø� round() 5 �̻��� �ݿø�
-- �� ���뿡�� ��µ� �޿��� �Ҽ��� ���ڸ� ��µǰ� �Ͻÿ�.
select employee_id, last_name, job_id, 
(salary - 1235) / 1000, 
round((salary - 1235) / 1000, 2), 
round((salary - 1235) / 1000, 1),
round((salary - 1235) / 1000, 0),
round((salary - 1235) / 1000, -1) -- 1�� �ڸ�
from HR.employees;

-- ���̺��� ���� ��Ȳ���� ���� ����ϰ� ���� ��� from dual;
select round(45.923, 2), 
round(45.9234, 0), 
round(45.923, -1),
round(45.923, -2)
from dual;

select '�̼���' 
from dual;

-- ���� trunc() �ݿø� x
select trunc(45.925, 2), 
trunc(45.9234, 0), 
trunc(45.923, -1),
trunc(45.923, -2)
from dual;

-- ������ ���ϱ� mod(��, ���� ��)
-- ���� �޿��� ����ϴµ� �޿��� 5000���� ���� �������� ���� ����Ͻÿ�.
-- ��, ������ 'SA_REP'�� ����� ����Ͻÿ�.
select last_name, salary, mod(salary, 5000)
from HR.employees
where job_id = 'SA_REP';


-- ��¥
-- ���� ��¥ ��� (new Date())
select sysdate
from dual;

