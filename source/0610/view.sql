-- Data Dictionary
SELECT
    *
FROM dba_constraints
WHERE table_name = 'MEMBER';

SELECT
    *
FROM dba_constraints
WHERE table_name = 'BOARD';

-- VIEW
-- ����) �����ȣ, �̸�, ����, Ŀ�̼��� ������ ������ �������.
SELECT
    employee_id, first_name, job_id, salary + (salary * nvl(commission_pct, 0)) year_sal
FROM employees;

CREATE VIEW yearsal
AS
SELECT
    employee_id, first_name, job_id, salary + (salary * nvl(commission_pct, 0)) year_sal
FROM employees;

SELECT
    *
FROM yearsal;

-- CREATE OR REPLACE ������ ������ ���ÿ� �� �� �ִ�.
-- ����) �����ȣ, �� �̸�, �޿�, �Ի���, �μ��� ����� �� View�� ���ؼ� ����ϵ��� ����.
CREATE VIEW emp_info
AS
SELECT
    employee_id id_number, last_name || ' ' || first_name name, salary, hire_date, department_id
FROM employees;

SELECT
    *
FROM emp_info;

-- ����) ������ ���� VIEW���� id_number �� name �� ����Ͻÿ�.
SELECT
    id_number, name
FROM emp_info;

-- ����) ������ ���� VIEW���� employee_id�� id_number�� ��������.
CREATE OR REPLACE VIEW emp_info
AS
SELECT
    employee_id id_number, last_name || ' ' || first_name name, salary, hire_date, department_id
FROM employees;

-- ���� 6) �μ���ȣ�� 90�� ����鸸 VIEW �� ���ؼ� ����Ͻÿ�.
SELECT
    *
FROM emp_info
WHERE department_id = 90;

-- ���� 7) ������ 'SA'�� ������ ������� VIEW�� ���ؼ� ����Ͻÿ�.
SELECT
    *
FROM emp_info
WHERE job_id like '%SA%'; -- VIEW �� job_id �� ��� ����

-- ���� 8) ���� 7�� ������ �� �ֵ��� �����Ͻÿ�.
CREATE OR REPLACE VIEW emp_info
AS
SELECT
    employee_id id_number, last_name || ' ' || first_name name, salary, hire_date, department_id, job_id
FROM employees;

-- ���� 9) ���� 7�� �ٽ� ���� ���Ѻ���.
SELECT
    *
FROM emp_info
WHERE job_id like '%SA%';

-- ���� 10) ���� 8�� VIEW ���� �÷��� ��Ī�� ������� ���� VIEW �� �÷����� ������ ����.
CREATE OR REPLACE VIEW emp_info
(id_number, name, sal, hire_date, dept_id, job_id)
AS
SELECT
    employee_id, last_name || ' ' || first_name, salary, hire_date, department_id, job_id
FROM employees;

SELECT
    *
FROM emp_info;

-- ���� 11) �μ��� �޿��� ���, �հ�, �ְ� ��, �׸��� ���� ���� VIEW�� ���ؼ� ����Ͻÿ�. VIEW ���� salview �̴�.
CREATE OR REPLACE VIEW salview
(dept_id, avg, sum, max, min)
AS
SELECT
    department_id, AVG(salary), SUM(salary), MAX(salary), MIN(salary)
FROM employees
GROUP BY department_id;

SELECT
    *
FROM salview;

-- ���� 12) ���� 11���� �μ��� ��� ���� 10000�̻��� �μ��� ����Ͻÿ�.
SELECT
    *
FROM salview
WHERE avg >= 10000;

-- ���� 13) �����ȣ, ��, �̸���, �Ի���, ����, �μ���ȣ�� ������ VIEW �� ����ÿ�.
CREATE OR REPLACE VIEW salview2
(emp_id, lname, email, hire_date, job_id, dept_id)
AS
SELECT
    employee_id, last_name, email, hire_date, job_id, department_id
FROM employees;

SELECT
    *
FROM employees;

SELECT
    *
FROM salview2;

-- ���� 14) salview2 �� �� �÷��� 400, RHEE, SMRHEE, ���糯¥, 'SA_MAN', 70 �� �Է��Ͻÿ�.
-- VIEW�� ���ؼ� INSERT �ϴ� ��쿡�� ���� ���̺� ������ �Ǵ� ���̹Ƿ� not null �� �÷��� �� VIEW �� �־�� �Ѵ�.
INSERT INTO salview2(emp_id, lname, email, hire_date, job_id, dept_id)
VALUES (400, 'RHEE', 'SMRHEE', sysdate, 'SA_MAN', 70);

-- ���� 15) salview2�� ���ؼ� �μ� ��ȣ�� 70�� �μ��� ����� ���� �Ͻÿ�.
SELECT
    *
FROM employees
WHERE department_id = 70;

SELECT
    *
FROM salview2
WHERE dept_id = 70;

DELETE FROM salview2
WHERE dept_id = 70;

-- ���� 16) �μ� �� ��� �޿��� �հ�
CREATE OR REPLACE VIEW salview1
(dept_name, avg, sum, max, min)
AS
SELECT
    d.department_name, AVG(e.salary), SUM(e.salary), MAX(e.salary), MIN(e.salary)
FROM employees e JOIN departments d
ON e.department_id = d.department_id
GROUP BY d.department_name;

SELECT
    *
FROM salview1;

-- ���� 17) �����ȣ, ��, �̸���, �Ի���, ����, �μ���ȣ, �μ����� empview1 �̶�� VIEW �� ���ؼ� ����Ͻÿ�.
CREATE OR REPLACE VIEW empview1
(emp_id, lname, email, hire_date, job_id, dept_id, dname)
AS
SELECT
    e.employee_id, e.last_name, e.email, e.hire_date, e.job_id, d.department_id, d.department_name
FROM employees e JOIN departments d
ON e.department_id = d.department_id;

SELECT
    *
FROM empview1;

-- ���� 18) empview1�� �ִ� emp_id, lname, email, hire_date, job_id �� (400, 'TEST', 'TESTMAIL', sysdate, 'SA_MAN') �����͸� �Է��Ͻÿ�.
-- JOIN �� ��Ƽ VIEW �� DML���� ����� �� ���� �� �� �ִ�.
INSERT INTO empview1(emp_id, lname, email, hire_date, job_id)
VALUES (400, 'TEST', 'TESTMAIL', sysdate, 'SA_MAN');

-- ����)
DROP TABLE viewupd1;
DROP TABLE viewupd2;
CREATE TABLE viewupd1 (
    c1 int,
    c2 int
);

CREATE TABLE viewupd2 (
    c1 int,
    c3 int
);
INSERT INTO viewupd1 VALUES(1, 1);
INSERT INTO viewupd2 VALUES(1, 1);

CREATE VIEW v_viewupd
(t1c1, t1c2, t2c1, t2c3)
AS
SELECT
    t1.c1, t1.c2, t2.c1, t2.c3
FROM viewupd1 t1 JOIN viewupd2 t2
ON t1.c1 = t2.c1;

INSERT INTO v_viewupd(t1c1, t1c2) VALUES(3, 3);

SELECT
    *
FROM v_viewupd;

SELECT
    *
FROM viewupd1;

SELECT
    *
FROM viewupd2;

/*
-- ���� 19) 17�� ������ �ص� ������ ����
CREATE OR REPLACE VIEW empview1
AS
SELECT
    e.employee_id, e.last_name, e.email, e.hire_date, e.job_id, d.department_id, d.department_name
FROM employees e JOIN departments d
ON e.department_id = d.department_id;

INSERT INTO empview1(employee_id, last_name, email, hire_date, job_id, department_id)
VALUES (400, 'TEST', 'TESTMAIL', sysdate, 'SA_MAN', 70);

INSERT INTO empview1(department_id, department_name)
VALUES (70, 'aaaa');
*/

-- ���� 19) �μ���ȣ�� 20�� �μ��� ����鸸 empview2�� VIEW ���� ����� �� �ְ� �Ѵ�.
-- �����ȣ, ��, �̸���, �Ի���, ����, �μ���ȣ
CREATE OR REPLACE VIEW empview2
AS
SELECT
    employee_id, last_name, email, hire_date, job_id, department_id
FROM employees
WHERE department_id = 20;

SELECT
    *
FROM empview2;

-- ���� 20) empview2 �� �� �÷��� 150, LEE, SMLEE, ���糯¥, 'SA_REP', 70 �� �Է��Ͻÿ�.
INSERT INTO empview2(employee_id, last_name, email, hire_date, job_id, department_id)
VALUES (150, 'LEE', 'SMLEE', sysdate, 'SA_REP', 70);

SELECT
    *
FROM employees
WHERE department_id = 70;

-- ���� 21) view�� ���ؼ� �������� �ʴ� �����ʹ� ������� �ʰ� �ϰ� �ʹ�.
CREATE OR REPLACE VIEW empview2
AS
SELECT
    employee_id, last_name, email, hire_date, job_id, department_id
FROM employees
WHERE department_id = 20
WITH CHECK OPTION CONSTRAINT empv20; -- empv20 �� �ĺ��ڴ�.

INSERT INTO empview2(employee_id, last_name, email, hire_date, job_id, department_id)
VALUES (151, 'LEE', 'SMLEE', sysdate, 'SA_REP', 70); -- �������� ���� ����

INSERT INTO empview2(employee_id, last_name, email, hire_date, job_id, department_id)
VALUES (152, 'LEE', 'SMLEE', sysdate, 'SA_REP', 20);

SELECT
    *
FROM empview2;

-- ���� 22) empview3�� VIEW ���� ��������� ����ϴµ� DML ���� ������� ���ϰ� �Ͻÿ�. (�б� ����)
CREATE OR REPLACE VIEW empview3
AS
SELECT
    employee_id, last_name, email, hire_date, job_id, department_id
FROM employees
WHERE department_id = 50
WITH READ ONLY;

INSERT INTO empview2(employee_id, last_name, email, hire_date, job_id, department_id)
VALUES (153, 'LEE', 'SMLEE', sysdate, 'SA_REP', 50); -- �������� ���� ����

SELECT
    *
FROM empview3;

-- ���� 23) empview3����
DROP VIEW empview3;