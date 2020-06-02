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

-- �Ի����� 2007�� 01�� 01�Ϻ��� ������ �������� ����Ͻÿ�.
select *
from HR.employees
where hire_date < '07/01/01';

-- to_date()
select *
from HR.employees
where hire_date < to_date('01/01/07', 'DD/MM/YY');

-- �����ȣ, ����, �Ի����� ����ϴµ� ������� �Ի��Ϸ� ���� �� �ְ� �Ǿ����� ���� ����Ͻÿ�.
select employee_id, job_id, hire_date, (sysdate - hire_date) / 7
from HR.employees;

-- �Ի����� �� ���� �Ǿ����� ����Ͻÿ�. - months_between
select employee_id, job_id, hire_date, months_between(sysdate, hire_date)
from HR.employees;

-- �Ի����� 6������ �� ��¥�� �����Դϱ�?
-- �����ȣ, ����, �Ի���
select employee_id, job_id, hire_date, add_months(hire_date, 6)
from HR.employees;

select hire_date, sysdate - 14
from HR.employees;

-- ���� ��¥���� 14�� ���� �Ի��� ������?
select *
from HR.employees
where hire_date = sysdate - 14;

-- �Ի��Ϸκ��� ���� �ݿ����� ���� �Դϱ�?
select employee_id, job_id, hire_date, next_day(hire_date, '�ݿ���') 
from HR.employees;

-- ���� ���������� ���
-- �Ի��� ���� ������ ���� �����Դϱ�?
select employee_id, job_id, hire_date, last_day(hire_date)
from HR.employees;

-- �Ի��Ϸ� ���� 36������ ���� ������� ����Ͻÿ�.
select *
from HR.employees
where months_between(sysdate, hire_date) > 36; -- ��

select *
from HR.employees
where sysdate - hire_date > 36; -- ��

-- �Ի��Ϸ� ���� ��ĥ�� �������� ���Ͻð�.
select trunc(sysdate - hire_date)
from HR.employees;

-- �����ȣ, ����, �Ի����� ����ϴµ� �Ի����� �� 4�ڸ��� ����Ͻÿ�.
-- ��¥ ǥ�⸦ yyyy-mm-dd
-- to_char(data, 'yyyy-mm-dd hh mi ss am') = ��¥�� ���ϴ� ������ ���ڷ� �ٲܶ� ���
select employee_id, job_id, hire_date, to_char(hire_date, 'yyyy-mm-dd hh : mi : ss am')
from HR.employees;

select sysdate, to_char(sysdate, 'yyyy-mm-dd hh : mi : ss am')
from dual;

-- �����ȣ ���� �޿��� ����ϴµ� �޿� �տ� $�� ���̰� ���ڸ����� , �� �� ����Ͻÿ�.
select employee_id, job_id, salary, to_char(salary, '$999,999'), to_char(salary, 'L999,999'), to_char(salary, 'L999,999mi')
from HR.employees;

-- ��¥�� 10-10-2002 ���Ŀ� �Ի��� ������ ����Ͻÿ�.
select *
from HR.employees
where to_char(hire_date, 'dd-mm-yyyy') > '10-10-2002';

select *
from HR.employees
where hire_date > to_date('10-10-2002', 'dd-mm-yyyy');


-- �Ϲ� �Լ� : NVL(Null Value), NVL2, NULLIF
select *
from HR.employees;
-- �����ȣ, ����, Ŀ�̼���, ������ �޿��� ����Ͻÿ�.
select employee_id, job_id, salary + salary * nvl(commission_pct, 0)
from HR.employees;

-- �����ȣ, ����, ������ ���Ͻÿ�
select employee_id, job_id, salary * (1 + nvl(commission_pct, 0)) * 12
from HR.employees;

select employee_id, job_id, nvl2(commission_pct, salary + salary * commission_pct, salary)
from HR.employees;

--select nvl2(null, 'not null', 'null')
--from dual;

-- ���� ����ϴ� ���
select employee_id, job_id, nvl2(commission_pct, 'sal+comm', 'sal')
from HR.employees;

-- ���� ǥ����
-- ������ 'IT_PROG' �� �� �޿��� 1.1�踦 �ϰ�
-- ������ 'ST_CLERK' �� �� �޿��� 1.15�踦 �ϰ�
-- ������ 'SA_REP' �� �� �޿��� 1.2�踦 �Ѵ�.
-- ������ ������ �޿��� �����Ѵ�.
-- �����ȣ, �޿�, ����, ���ǿ� ���� ��
select employee_id, salary, job_id,
    case job_id when 'IT_PROG' then 1.10 * salary
                when 'ST_CLERK' then 1.15 * salary
                when 'SA_REP' then 1.20 * salary
    else salary end sal, hire_date
from HR.employees;

select employee_id, salary, job_id,
    decode( job_id  , 'IT_PROG', 1.10 * salary
                    , 'ST_CLERK', 1.15 * salary
                    , 'SA_REP', 1.20 * salary
    , salary ) sal, hire_date
from HR.employees;

-- �޿��� 10000�̻��̸� "�̻�"
--          7000�̻� "����"
--          5000�̻� "����"
--          �������� "���"
--      ���� �޿��� ���� ����Ѵ�.
select last_name, salary, job_id,
    case when salary >= 10000 then '�̻�'
        when salary >= 7000 then '����'
        when salary >= 5000 then '����'
    else '���' end "����"
from HR.employees;

-- ����) �޿��� 2000���� ���� ���� ����
--        0�̸� 0.00
--        1�̸� 0.09
--        2�̸� 0.20
--        3�̸� 0.30
--        4�̸� 0.40
--        5�̸� 0.42
--        6�̸� 0.44
--              0.45 ��ŭ ������ �ο��ȴ�.
-- �ο��Ǵ� ������ ����Ͻÿ�.
-- ���� �޿��� ���� ����Ͻÿ�. (��, �μ��� 80�� �����)
-- decode �� ����Ͻÿ�.
select last_name, salary, trunc(salary / 2000) "���� ��",
    decode (
        trunc(salary / 2000),0 , salary * 0.00
                            ,1 , salary * 0.09
                            ,2 , salary * 0.20
                            ,3 , salary * 0.30
                            ,4 , salary * 0.40
                            ,5 , salary * 0.42
                            ,6 , salary * 0.44
                                , salary * 0.45
    ) "����", department_id
from HR.employees
where department_id = 80;
