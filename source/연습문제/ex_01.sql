--����) ������̺��� ������ MAN�� �����ϰ� �޿��� 10000�̻��� 
--����� �����ȣ�� ���� ���� �׸��� �޿��� ����Ͻÿ�.

select employee_id, last_name, job_id, salary
from HR.employees
where job_id like '%MAN%' and salary >= 10000;


--����) ������ SA_REP�� AD_PRES �̸鼭 �޿��� 15000�� �ʰ��ϴ� 
--����� ����Ͻÿ�.
--��, ��, ����, �޿��� ��� or�� and�� ���

select last_name, job_id, salary
from HR.employees
where (job_id = 'SA_REP' or job_id = 'AD_PRES') and salary > 15000;


--����
--select last_name , hire_date
--from hr.employees
--order by hire_date;
--
--����) �������̺��� �μ��� ������������ �����Ͽ� ����Ͻÿ�.
--�μ���ȣ , �޿�, �Ի���, ��

select department_id, salary, hire_date, last_name
from HR.employees
order by department_id;



--�μ��� ������������ �����ϰ� �Ի��ϵ� ������������ ����
--�μ���ȣ , �޿�, �Ի���, ��

select department_id, salary, hire_date, last_name
from HR.employees
order by department_id desc, hire_date desc;

--�μ��� ������������ �����ϰ� �Ի����� ������������ �����Ͽ� ���
--�μ���ȣ , �޿�, �Ի���, ��

select department_id, salary, hire_date, last_name
from HR.employees
order by department_id desc, hire_date;

--�μ��� ������������ �����ϰ� �Ի����� ������������ �����Ͽ� 
--�޿��� ������������ �����Ͽ� ���
--�μ���ȣ ,  �Ի���, �޿�, ��

select department_id, salary, hire_date, last_name
from HR.employees
order by department_id desc, hire_date, salary desc;

--�����Լ�
--Lower, Upper, initcap, concat, substr
--
--select last_name, lower(last_name) , hire_date
--from hr.employees
--where lower(last_name) = 'grant';
--
--
--����) ��� �ҹ����� grant�� ��� 

select *
from HR.departments;

--����) 'GranT'�� �Է������� ������̺��� 'Grant'�� ã���ÿ�.

select *
from HR.employees
where lower(last_name) = lower('GranT');

--����) ���� ��� �빮�ڷ� ��ȯ�ϰ� �̸� ��� �ҹ��� ��ȯ�Ͽ�
--���� �̸��� �ѿ� ����� �� ' ���� GRANT douglas �Դϴ�'�� 
--��µǰ� �Ͻÿ�.

select '���� ' || upper(last_name) || ' ' || lower(first_name) || ' �Դϴ�' "��"
from HR.employees;

---- concat
--����) ���� �̸��� �ٿ� ���

select concat(last_name, first_name) "concat"
from HR.employees;

--����) ���� ��� �빮�ڷ� ��ȯ�ϰ� �̸� ��� �ҹ��� ��ȯ�Ͽ�
--���� �̸��� �ѿ� ����� �� ' ���� GRANT douglas �Դϴ�'�� 
--��µǰ� �Ͻÿ�. concat�� �̿�

select concat('���� ' || upper(last_name),  ' ' || lower(first_name) ||' �Դϴ�') "��"
from HR.employees;

--String str = "abcdefghi";
--String result = str.subString(2, 6); cdef'
--String result = str.subString(2);
--
--
--
--����) ���� Davies���� av�� ����Ͻÿ�.

select substr(last_name, 2, 2)
from HR.employees
where last_name = 'Davies';

--����)���� �ι�° ��¥���� ��� ����Ͻÿ�.

select substr(last_name, 2)
from HR.employees;

--����) ���� ������ ���ڿ��� �α�¥�� �������ÿ�.

select last_name, substr(last_name, -2, 2)
from HR.employees;

--����) ���� �ڿ� on���� ������ ����� ã���ÿ�.
select last_name, substr(last_name, -2, 2)
from HR.employees
where substr(last_name, -2, 2) = 'on';

--����) ���� �ڿ� ����° ���ڰ� so�� ����� ����Ͻÿ�.
select last_name, substr(last_name, -3, 2)
from HR.employees
where substr(last_name, -3, 2) = 'so';


--����) ���� ������ ����ϴµ� �̸����� ���ʿ��� 3���ڸ� ����Ͻÿ�.
--������ȣ, ��, �޿�, ����

select department_id, last_name, salary, job_id, email, substr(email, 0, 3)
from HR.employees;


--����) ���� ������ ����ϴµ� �̸����� �����ʿ��� 3���ڸ� ����Ͻÿ�.
--������ȣ, ��, �޿�, ����
select department_id, last_name, salary, job_id, email, substr(email, -3, 3)
from HR.employees;


--����) Ʋ�� ���� ã�� ������ ���Ͻÿ�.
--
--String strnn = 'abcdefg'; 
--str = 'abcdefg'; String �� �߸� �Ƴ���
--int i = str.indexOf("f");  //5

--����) o�� �ִ� ���� o�� ���°�� �ִ� ��ġ�� ����Ͻÿ�.
--������ȣ ��, ���� ��ġ, ����

select last_name, instr(last_name, 'o')
from HR.employees
where last_name like '%o%';

--/*
--instr(last_name,'oc') : ���ϴ� ���ڰ� ������ 0�� ��ȯ
--instr('abcde' , 'a') : 1
--�ڹٿ��� "abcdef".indexOf("a") : 0
--*/
--
--
--����) ������ RE�� �ִ� ��� RE���� 3���ڸ� ����Ͻÿ�.
--������ȣ ��,  ����, ������ ����

select job_id, substr(job_id, instr(job_id, 'RE'), 3), instr(job_id, 'RE')
from HR.employees
where job_id like '%RE%';

--����) ������ȣ, ��, �Ի��� , �޿�, �޿��տ� * ǥ�ð� �ǰ� ����.

select department_id, last_name, hire_date, salary, lpad(salary, length(salary)+1, '*')
from HR.employees;


--����) ������ȣ, ��, �Ի���, ������ ����ϴµ� ������ RE�� �ִٸ�
--RE�� AB�� �����Ͽ� ���

select department_id, last_name, hire_date, job_id, replace(job_id, 'RE', 'AB')
from HR.employees;

--/*
--select trim(' ' from ' ab cd ef ') 
--from dual;
--
--select trim('a' from 'abada')
--from dual;
--
--select round(45.923, 2), round(45.924, 2), round(45.925, 2),
--       round(45.926, 2)
--from dual;
--
--
--select trunc(45.923, 2), trunc(45.924, 2), trunc(45.925, 2),
--       trunc(45.926, 2)
--from dual;
--
--select  round(45.925, 2),round(45.925, 1), round(45.925),
--	round(45.925, -1), round(45.925, -2)
--from dual;
--
--
--select  trunc(45.925, 2), trunc(45.925, 1), trunc(45.925),
--	trunc(45.925, -1), trunc(45.925, -2)
--from dual;
--
--
--select mod(10,3)
--from dual;
--*/
--
--����) ������ȣ, ����ó, Ŀ�̼�, �μ���ȣ,�޿�
--�޿��� 3000���� �������� ���� �������� ����Ͻÿ�.

select employee_id, phone_number, commission_pct, department_id, salary, mod(salary, 3000)
from HR.employees;

--����) 2003�⵵���� �Ի��� �������� ����Ͻÿ�.
select *
from HR.employees
where hire_date > '03/01/01';

--����) ���ش� ���ñ��� ���ְ� �������� Ȯ���Ͻÿ�.
select sysdate, to_date('20200101', 'yyyymmdd'), (sysdate - to_date('20200101', 'yyyymmdd')) ,trunc((sysdate - to_date('20200101', 'yyyymmdd')) / 7, 2)
from dual; -- �� �� �� �̻���.

--����) �������� ��� �ٹ������� ����Ͻÿ�.
--������ȣ, ��, ����ó,�μ�, �ٹ����
select employee_id, last_name || first_name name, department_id, hire_date, trunc((sysdate - hire_date) / 365) "�ٹ����"
from HR.employees
order by "�ٹ����" desc;


--����) �ټӳ�� 15�� �̻��� ����鸸 ����Ͻÿ�.
select employee_id, last_name, department_id, hire_date, trunc((sysdate - hire_date) / 365) "yeyeye"
from HR.employees
where trunc((sysdate - hire_date) / 365) >= 15;
