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
-- 문제) 사원번호, 이름, 직무, 커미션을 포함한 연봉을 출력하자.
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

-- CREATE OR REPLACE 생성과 수정을 동시에 할 수 있다.
-- 문제) 사원번호, 성 이름, 급여, 입사일, 부서를 출력할 때 View를 통해서 출력하도록 하자.
CREATE VIEW emp_info
AS
SELECT
    employee_id id_number, last_name || ' ' || first_name name, salary, hire_date, department_id
FROM employees;

SELECT
    *
FROM emp_info;

-- 문제) 위에서 만든 VIEW에서 id_number 와 name 만 출력하시오.
SELECT
    id_number, name
FROM emp_info;

-- 문제) 위에서 만든 VIEW에서 employee_id를 id_number로 변경하자.
CREATE OR REPLACE VIEW emp_info
AS
SELECT
    employee_id id_number, last_name || ' ' || first_name name, salary, hire_date, department_id
FROM employees;

-- 문제 6) 부서번호가 90인 사원들만 VIEW 를 통해서 출력하시오.
SELECT
    *
FROM emp_info
WHERE department_id = 90;

-- 문제 7) 직무에 'SA'를 포함한 사원들을 VIEW를 통해서 출력하시오.
SELECT
    *
FROM emp_info
WHERE job_id like '%SA%'; -- VIEW 에 job_id 가 없어서 에러

-- 문제 8) 문제 7이 실행할 수 있도록 수정하시오.
CREATE OR REPLACE VIEW emp_info
AS
SELECT
    employee_id id_number, last_name || ' ' || first_name name, salary, hire_date, department_id, job_id
FROM employees;

-- 문제 9) 문제 7을 다시 실행 시켜보자.
SELECT
    *
FROM emp_info
WHERE job_id like '%SA%';

-- 문제 10) 문제 8의 VIEW 에서 컬럼명에 별칭을 사용하지 말고 VIEW 에 컬럼명을 정의해 보자.
CREATE OR REPLACE VIEW emp_info
(id_number, name, sal, hire_date, dept_id, job_id)
AS
SELECT
    employee_id, last_name || ' ' || first_name, salary, hire_date, department_id, job_id
FROM employees;

SELECT
    *
FROM emp_info;

-- 문제 11) 부서별 급여의 평균, 합계, 최고 값, 그리고 최저 값을 VIEW를 통해서 출력하시오. VIEW 명은 salview 이다.
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

-- 문제 12) 문제 11에서 부서의 평균 값이 10000이상인 부서만 출력하시오.
SELECT
    *
FROM salview
WHERE avg >= 10000;

-- 문제 13) 사원번호, 성, 이메일, 입사일, 직무, 부서번호를 가지는 VIEW 를 만드시오.
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

-- 문제 14) salview2 의 각 컬럼에 400, RHEE, SMRHEE, 현재날짜, 'SA_MAN', 70 을 입력하시오.
-- VIEW를 통해서 INSERT 하는 경우에는 실제 테이블에 저장이 되는 것이므로 not null 인 컬럼은 꼭 VIEW 에 있어야 한다.
INSERT INTO salview2(emp_id, lname, email, hire_date, job_id, dept_id)
VALUES (400, 'RHEE', 'SMRHEE', sysdate, 'SA_MAN', 70);

-- 문제 15) salview2를 통해서 부서 번호가 70인 부서의 사원을 삭제 하시오.
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

-- 문제 16) 부서 명별 평균 급여와 합계
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

-- 문제 17) 사원번호, 성, 이메일, 입사일, 직무, 부서번호, 부서명을 empview1 이라는 VIEW 를 통해서 출력하시오.
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

-- 문제 18) empview1에 있는 emp_id, lname, email, hire_date, job_id 에 (400, 'TEST', 'TESTMAIL', sysdate, 'SA_MAN') 데이터를 입력하시오.
-- JOIN 한 멀티 VIEW 는 DML문을 사용할 수 없을 수 도 있다.
INSERT INTO empview1(emp_id, lname, email, hire_date, job_id)
VALUES (400, 'TEST', 'TESTMAIL', sysdate, 'SA_MAN');

-- 예제)
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
-- 문제 19) 17번 문제의 해딩 네임을 변경
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

-- 문제 19) 부서번호가 20인 부서의 사원들만 empview2인 VIEW 에서 출력할 수 있게 한다.
-- 사원번호, 성, 이메일, 입사일, 직무, 부서번호
CREATE OR REPLACE VIEW empview2
AS
SELECT
    employee_id, last_name, email, hire_date, job_id, department_id
FROM employees
WHERE department_id = 20;

SELECT
    *
FROM empview2;

-- 문제 20) empview2 의 각 컬럼에 150, LEE, SMLEE, 현재날짜, 'SA_REP', 70 를 입력하시오.
INSERT INTO empview2(employee_id, last_name, email, hire_date, job_id, department_id)
VALUES (150, 'LEE', 'SMLEE', sysdate, 'SA_REP', 70);

SELECT
    *
FROM employees
WHERE department_id = 70;

-- 문제 21) view를 통해서 보여지지 않는 데이터는 저장되지 않게 하고 싶다.
CREATE OR REPLACE VIEW empview2
AS
SELECT
    employee_id, last_name, email, hire_date, job_id, department_id
FROM employees
WHERE department_id = 20
WITH CHECK OPTION CONSTRAINT empv20; -- empv20 은 식별자다.

INSERT INTO empview2(employee_id, last_name, email, hire_date, job_id, department_id)
VALUES (151, 'LEE', 'SMLEE', sysdate, 'SA_REP', 70); -- 제약조건 위반 오류

INSERT INTO empview2(employee_id, last_name, email, hire_date, job_id, department_id)
VALUES (152, 'LEE', 'SMLEE', sysdate, 'SA_REP', 20);

SELECT
    *
FROM empview2;

-- 문제 22) empview3의 VIEW 에서 사원정보를 출력하는데 DML 문을 사용하지 못하게 하시오. (읽기 전용)
CREATE OR REPLACE VIEW empview3
AS
SELECT
    employee_id, last_name, email, hire_date, job_id, department_id
FROM employees
WHERE department_id = 50
WITH READ ONLY;

INSERT INTO empview2(employee_id, last_name, email, hire_date, job_id, department_id)
VALUES (153, 'LEE', 'SMLEE', sysdate, 'SA_REP', 50); -- 제약조건 위반 오류

SELECT
    *
FROM empview3;

-- 문제 23) empview3삭제
DROP VIEW empview3;