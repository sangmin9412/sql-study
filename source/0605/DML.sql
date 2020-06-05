-- DML (Describe each data manipulation language) {Insert, Update, Delete}
--  CRUD
--  C - create (insert)
--  R - select
--  U - update
--  D - delete

/*
** 문법 **
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
-- 컬럼 순서대로 데이터 타입을 맞춰 값을 넣어주면 컬럼명을 생략할 수 있다.
-- 하지만, 실제 프로젝트에서는 작성해야 한다.
--INSERT INTO departments
INSERT INTO departments(department_id, department_name, manager_id, location_id)
VALUES (301, '솔데스크', 100, 1700);

SELECT
    department_id, department_name, manager_id, location_id
FROM departments
WHERE department_name = '솔데스크';

-- 문제) null인 컬럼에는 값을 저장하지 말자.
INSERT INTO departments(department_id, department_name, manager_id, location_id)
VALUES (302, '총무부', null, null);

SELECT
    department_id, department_name, manager_id, location_id
FROM departments
WHERE department_name = '총무부';

INSERT INTO departments(department_id, department_name)
VALUES (303, '생산관리부');

SELECT
    department_id, department_name, manager_id, location_id
FROM departments
WHERE department_name = '생산관리부';

-- not null인 부서명에 null 값을 입력해보자
INSERT INTO departments(department_id, department_name, manager_id, location_id)
VALUES (303, null, 101, 1400); -- 오류 cannot insert NULL into

SELECT
    department_id, department_name, manager_id, location_id
FROM departments
WHERE department_name = '생산관리부';

-- 오늘 날짜를 확인하자.
SELECT
    sysdate
FROM dual;

SELECT
    *
FROM employees;

-- 210번 사원의 정보를 INSERT 하는데 
-- 이름은 '숭무', 
-- 성은 '박', 
-- 이메일은 'highland0', 
-- 폰넘버는 '01071461970', 
-- 직무번호 'SA_REP', 
-- 입사일은 오늘, 
-- 급여는 1000, 
-- 커미션 없음, 
-- 매니저 null, 
-- 부서는 100
INSERT INTO employees(employee_id, first_name, last_name, email, phone_number, job_id, hire_date, salary, commission_pct, manager_id, department_id)
VALUES (210, '숭무', '이', 'highland0', '01071461970', 'SA_REP', sysdate, 1001, null, null, 101);

SELECT
    *
FROM employees
WHERE first_name = '숭무';

commit;
