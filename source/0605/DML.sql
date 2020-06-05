-- DML (Describe each data manipulation language) {Insert, Update, Delete}
--  CRUD
--  C - create (insert)
--  R - select
--  U - update
--  D - delete

/*
** ���� **
INSERT INTO table [(column, [, column...])]
VALUES (value [, value...]);

INSERT INTO deparments(department_id, department_name, manager_id, location_id)
VALUES (70 'Public Relations', 100, 1700);

*/
--------------------------
CREATE TABLE departments
AS
SELECT * FROM HR.departments;

SELECT * FROM departments;
--
CREATE TABLE employees
AS
SELECT * FROM HR.employees;

SELECT * FROM employees;
--------------------------

desc departments;
-- �÷� ������� ������ Ÿ���� ���� ���� �־��ָ� �÷����� ������ �� �ִ�.
-- ������, ���� ������Ʈ������ �ۼ��ؾ� �Ѵ�.
--INSERT INTO departments
INSERT INTO departments(department_id, department_name, manager_id, location_id)
VALUES (301, '�ֵ���ũ', 100, 1700);

SELECT
    department_id, department_name, manager_id, location_id
FROM departments
WHERE department_name = '�ֵ���ũ';

-- ����) null�� �÷����� ���� �������� ����.
INSERT INTO departments(department_id, department_name, manager_id, location_id)
VALUES (302, '�ѹ���', null, null);

SELECT
    department_id, department_name, manager_id, location_id
FROM departments
WHERE department_name = '�ѹ���';

INSERT INTO departments(department_id, department_name)
VALUES (303, '���������');

SELECT
    department_id, department_name, manager_id, location_id
FROM departments
WHERE department_name = '���������';

-- not null�� �μ��� null ���� �Է��غ���
INSERT INTO departments(department_id, department_name, manager_id, location_id)
VALUES (303, null, 101, 1400); -- ���� cannot insert NULL into

SELECT
    department_id, department_name, manager_id, location_id
FROM departments
WHERE department_name = '���������';

-- ���� ��¥�� Ȯ������.
SELECT
    sysdate
FROM dual;

SELECT
    *
FROM employees;

-- 210�� ����� ������ INSERT �ϴµ� 
-- �̸��� '����', 
-- ���� '��', 
-- �̸����� 'highland0', 
-- ���ѹ��� '01071461970', 
-- ������ȣ 'SA_REP', 
-- �Ի����� ����, 
-- �޿��� 1000, 
-- Ŀ�̼� ����, 
-- �Ŵ��� null, 
-- �μ��� 100
INSERT INTO employees(employee_id, first_name, last_name, email, phone_number, job_id, hire_date, salary, commission_pct, manager_id, department_id)
VALUES (210, '����', '��', 'highland0', '01071461970', 'SA_REP', sysdate, 1001, null, null, 101);

SELECT
    *
FROM employees
WHERE first_name = '����';

commit;
