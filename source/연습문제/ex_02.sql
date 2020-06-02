----���, ����
---- ���



--����) ������ ���ó�¥�� �Ի����� ����Ǿ����� ����Ͻÿ�.
--������ȣ ���� �Ի��� �Ի簳��( MONTHS_BETWEEN)
select employee_id, job_id, hire_date, 
trunc(MONTHS_BETWEEN(SYSDATE,hire_date)) "�Ի� �� ������"
from HR.employees;


--����) ������ �Ի��� ���κ��� 6�����Ĵ� �����Դϱ�?
--������ȣ �� �Ի��� 6������(ADD_MONTHS)
select employee_id, last_name, hire_date, add_months(hire_date, 6)
from HR.employees;

--����) ������ �Ի����� 180������ ���� ����� ����Ͻÿ�.
--������ȣ �� �Ի���
select employee_id, last_name, hire_date, add_months(hire_date, 36), trunc((sysdate - hire_date) / 365) "yeyeye"
from HR.employees
where MONTHS_BETWEEN(SYSDATE,hire_date) > 180;

--����) ������ �Ի����� 180���� �̸��� ����� ����Ͻÿ�.
--������ȣ �� �Ի���
select employee_id, last_name, hire_date, add_months(hire_date, 36), trunc((sysdate - hire_date) / 365) "yeyeye"
from HR.employees
where MONTHS_BETWEEN(SYSDATE,hire_date) < 180;

--����)���ú��� ���� �ݿ����� ���� �Դϱ�?(NEXT_DAT)
select sysdate, next_day(sysdate, '�ݿ���')
from dual;

--����) �Խ��Ǹ���Ʈ���� ������ 5����****
--������ ���� 3���ڸ� ��� �ڿ� *�� ������ ����Ͻÿ�.
--������ȣ, �Ի���, ��
select *
from HR.employees;

--����) ȫ�浿�� ������Դϱ�? 3
select length('ȫ�浿')
from dual;

--����)"ȫ�浿 \n"���� �Ǿ� �ִ� ���� html���� �� �ٲ��̵ǵ���
--     "ȫ�浿 <br>"�����Ͻÿ�.
select replace('ȫ�浿 \n', '\n', '<br>')
from dual;

--����) �Ի����� 'YYYY-MM-DD'�� ��¥�� 31-05-2019 16:24:30 ����
--�� ���·� �������.
select to_char(hire_date, 'dd-mm-yyyy hh24: mi : ss am')
from HR.employees;


--����) ����(3333333)�� 3�ڸ����� ��ǥ�� �� ���
select trim(to_char(3333333, '999,999,999'))
from dual;

--����) �������̺��� �޿��� W33,333,333������ ����Ͻÿ�.
select salary, trim(to_char(salary, 'L999,999,999'))
from HR.employees;

--����) ������ 2018-10-25������ �ٹ��ϼ��� ����Ͻÿ�.
--������ȣ, �μ���ȣ, �Ի���, �ٹ��ϼ�
select employee_id, department_id, hire_date, (to_date('2018-10-25', 'yyyy-mm-dd') - hire_date) "�ٹ��ϼ�"
from HR.employees;


--����) ������ 25-10-2018������ �ٹ��ϼ��� ����Ͻÿ�.
--������ȣ, �μ���ȣ, �Ի���, �ٹ��ϼ�
select employee_id, department_id, hire_date, (to_date('25-10-2018', 'dd-mm-yyyy') - hire_date) "�ٹ��ϼ�"
from HR.employees;


--����) ������ 10-25-2018������ �ٹ��ϼ��� ����Ͻÿ�.
--������ȣ, �μ���ȣ, �Ի���, �ٹ��ϼ�
select employee_id, department_id, hire_date, (to_date('10-25-2018', 'mm-dd-yyyy') - hire_date) "�ٹ��ϼ�"
from HR.employees;

--����) '10-25-2002'�� �Ի��� ����� ����Ͻÿ�.
--������ȣ, �μ���ȣ, �Ի���, �ٹ��ϼ�
select employee_id, department_id, hire_date, (to_date('10-25-2018', 'mm-dd-yyyy') - hire_date) "�ٹ��ϼ�"
from HR.employees
where to_date('10-25-2002', 'mm-dd-yyyy') >= hire_date;


--����) �⸻������ �Ϸ��� �մϴ�.
--      ���(�޿�*12) : �޿��� Ŀ�̼Ǳ��� ���Եȴ�.
--������ ����� ���Ͻÿ�.
-- ������ȣ, �μ���ȣ, �޿�, ���
select employee_id, department_id, salary, (salary + salary * nvl(commission_pct, 0)) * 12 "����", nvl(commission_pct, 0)
from HR.employees;


--����) �μ��� 90�̰ų� 30�� �μ��� ������ ����� ���Ͻÿ�
--������ȣ, �μ���ȣ, �޿�, ���
select employee_id, department_id, salary, (salary + salary * nvl(commission_pct, 0)) * 12 "����", nvl(commission_pct, 0)
from HR.employees
where department_id in (90, 30);


---- nvl2
--����)������ȣ�� ���� �޿� �׸��� ����� ����Ͻÿ�.
select employee_id, department_id, salary, (salary + salary * nvl2(commission_pct, commission_pct, 0)) * 12 "����", nvl(commission_pct, 0)
from HR.employees;


---- ���ǽ�
--����) �޿��� 10000�̻��̸� "�̻���Դϴ�"
--             7000�̻��̸� "������Դϴ�"
--             5000�̻��̸� "������Դϴ�"
--             �������� ������� ����Ͻÿ�.
--      ���� �޿��� ���� ����Ѵ�.
--
--
----case
select employee_id, last_name, salary,
    case when salary >= 10000 then '�̻�'
        when salary >= 7000 then '����'
        when salary >= 5000 then '����'
        else '���' end "����"
from HR.employees;


----decode
--
--
--����) �޿��� 2000���� ���� ���� ���� 
--       0�̸� 0.00
--       1�̸� 0.09
--       2�̸� 0.20
--       3�̸� 0.30
--       4�̸� 0.40
--       5�̸� 0.42
--       6�̸� 0.44
--             0.45 ��ŭ ������ �ο��ȴ�.
--�ο��Ǵ� ������ ����Ͻÿ�.
--���� �޿��� ���� ����Ͻÿ�.(��, �μ��� 80�� �����)
select employee_id, last_name, salary,
    decode( trunc(salary / 2000),0 , salary * 0.00
                                ,1 , salary * 0.09
                                ,2 , salary * 0.20
                                ,3 , salary * 0.30
                                ,4 , salary * 0.40
                                ,5 , salary * 0.42
                                ,6 , salary * 0.44
                                , salary * 0.45) "����"
from HR.employees
where department_id = 80;

--����) ���� ��ü���� �Ի����� ���Ϻ��� ����� �ֱٿ� �Ի��� 
--����� ����Ͻÿ�.




--����) ����� ���� ����Ͻÿ�.
--
--
---- null�� count���� �����Ƿ� ���� ���̰� ���� �� �ִ�.
--select avg(commiddion_pct), sum(commission_pct)/sum(employee_id)
--from hr.employees;
--
--select avg(nvl(commission_pct,0)), sum(commission_pct)/count(employee_id)
--from hr.employees;
--
--
--����) �������̺��� �μ��� ������� ����Ͻÿ�.
--
--
--
--
--
--����)��� ���̺��� ���μ��� �޿������ ������.
--
--
--
--����) �� �������� �μ��� ������������ �����Ͽ� ����Ͻÿ�.
--
--
--
---- select ���� ���� ����
--select
--from
--where
--group by 
--having
--order by
--
--����) ���μ��� �޿��� ����� ���ϴ� ��հ��� ���� �ͺ��� 
--����Ͻÿ�.
--
--
--����) �� �μ��� �ִ� ����� ������ �޿��� ����� ���Ͻÿ�.
--


SELECT TO_DATE(SYSDATE, 'yyyy mm dd') AS "����ð�"  FROM DUAL;
 
SELECT TO_CHAR(SYSDATE, 'RRRR-MM-DD HH24:MI:SS') AS "����ð�"  FROM DUAL;
 
-- 1�� ��
SELECT TO_CHAR(SYSDATE-1, 'RRRR-MM-DD HH24:MI:SS') AS "����ð�"  FROM DUAL;
 
-- 1�ð� ��
SELECT TO_CHAR(SYSDATE-1/24, 'RRRR-MM-DD HH24:MI:SS') AS "����ð�"  FROM DUAL;
 
-- 1�� ��
SELECT TO_CHAR(SYSDATE-1/24/60, 'RRRR-MM-DD HH24:MI:SS') AS "����ð�"  FROM DUAL;
 
-- 1�� ��
SELECT TO_CHAR(SYSDATE-1/24/60/60, 'RRRR-MM-DD HH24:MI:SS') AS "����ð�"  FROM DUAL;
 
-- 5�ð� 30�� 10�� ��
SELECT TO_CHAR(SYSDATE-(5/24+30/24/60+10/24/60/60), 'RRRR-MM-DD HH24:MI:SS') AS "����ð�"  FROM DUAL;
 
-- ADD_MONTHS(a,b) a ��¥�� b ���� ���� ���� ��ȯ
SELECT TO_CHAR(ADD_MONTHS(SYSDATE,4),'RRRR-MM-DD') AS "MONTH" FROM DUAL;
 
-- b�� ������ ���� ���ش�.
SELECT TO_CHAR(ADD_MONTHS(SYSDATE,-4),'RRRR-MM-DD') AS "MONTH" FROM DUAL;
SELECT TO_CHAR(ADD_MONTHS(SYSTIMESTAMP,4),'RRRR-MM-DD') AS "MONTH" FROM DUAL;
 
-- 4) MONTHS_BETWEEN(day1, day2) : day1 �� day2 ������ �޼��� NUMBER Ÿ������ ��ȯ�Ѵ�.
SELECT MONTHS_BETWEEN(TO_DATE('2017-11-10','YYYY-MM-DD'), TO_DATE('2017-09-12','YYYY-MM-DD'))
AS "month" FROM DUAL;
 
-- ��(day) ���ϱ� �ڡڡ�
SELECT TO_DATE('2017-11-10','YYYY-MM-DD') - TO_DATE('2017-09-12','YYYY-MM-DD')
AS "day" FROM DUAL;
 
-- LAST_DAY(m) : ������ ���� ������ ��¥ �������� �տ� �׻� �ٸ� �÷��� ���� ����ؾ���
SELECT SYSDATE TODAY,LAST_DAY(SYSDATE) AS "lastDay" FROM DUAL;

