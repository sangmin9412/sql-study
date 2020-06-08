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



-- UPDATE
/*
-- 1 row updated.
UPDATE employees
SET department_id = 70
WHERE employee_id = 113;

-- 22 row updated.
UPDATE employees
SET department_id = 110
*/

UPDATE employees
SET department_id = 20;

SELECT
    department_id
FROM employees;

-- ����) �����ȣ 114���� �޿��� 15000���� �����ϰ� ������ 'SA_MAN'���� �����Ͻÿ�.
UPDATE employees
SET salary = 15000, job_id = 'SA_MAN'
WHERE employee_id = 114;

SELECT
    *
FROM employees
WHERE employee_id = 114;

-- ����) 114�� ����� �޿��� 127�� ����� �޿��� ���� �����ϰ� ������ 200�� ����� ���� �����Ͻÿ�.
UPDATE employees
SET salary = (
    SELECT
        salary
    FROM employees
    WHERE employee_id = 127
), job_id = (
    SELECT
        job_id
    FROM employees
    WHERE employee_id = 200
)
WHERE employee_id = 114;

SELECT
    *
FROM employees
WHERE employee_id = 114;



-- DELETE
/*
DELETE FROM TABLE
WHERE CONDITION(����)
*/

SELECT
    *
FROM departments;

-- ����) �μ����� 'NOC'�� �μ��� �����Ͻÿ�.
DELETE FROM departments
WHERE department_name = 'NOC';

-- ����) DELETE �� WHERE ���� ������� ������ ��� �ǳ�? ���̺� ��ü����
DELETE FROM departments;

-- ����) 'REP'�� �����ϰ� �ִ� �μ��� ������� ��� �����Ͻÿ�.
DELETE employees
WHERE employee_id in (
    SELECT
        employee_id
    FROM employees
    WHERE job_id like '%REP%'
);

SELECT
    *
FROM employees
WHERE job_id like '%REP%';

-- ����) �μ����� 'IT'�� �μ��� ������� �����Ͻÿ�.
DELETE employees
WHERE department_id in (
    SELECT
        department_id
    FROM departments
    WHERE department_name = 'IT'
);

-- ����) ������� ��� �����Ͻÿ�.
DELETE employees; -- rollback �� ����, ���� �ӵ��� ������.
commit;
TRUNCATE TABLE employees; -- rollback�� �Ұ���, ���� �ӵ��� ������, rollback ���� �ʾƵ� �Ǵ� table�� ���


-- 
rollback;

-- 
commit;
