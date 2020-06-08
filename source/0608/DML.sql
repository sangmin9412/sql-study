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

-- 문제) 사원번호 114번의 급여를 15000으로 변경하고 직무를 'SA_MAN'으로 변경하시오.
UPDATE employees
SET salary = 15000, job_id = 'SA_MAN'
WHERE employee_id = 114;

SELECT
    *
FROM employees
WHERE employee_id = 114;

-- 문제) 114번 사원의 급여는 127번 사원의 급여와 같게 변경하고 직무는 200번 사원과 같게 변경하시오.
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
WHERE CONDITION(조건)
*/

SELECT
    *
FROM departments;

-- 문제) 부서명이 'NOC'인 부서를 삭제하시오.
DELETE FROM departments
WHERE department_name = 'NOC';

-- 문제) DELETE 에 WHERE 절을 사용하지 않으면 어떻게 되나? 테이블 전체삭제
DELETE FROM departments;

-- 문제) 'REP'를 포함하고 있는 부서의 사원들을 모두 삭제하시오.
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

-- 문제) 부서명이 'IT'인 부서의 사원들을 삭제하시오.
DELETE employees
WHERE department_id in (
    SELECT
        department_id
    FROM departments
    WHERE department_name = 'IT'
);

-- 문제) 사원들을 모두 삭제하시오.
DELETE employees; -- rollback 이 가능, 삭제 속도가 느리다.
commit;
TRUNCATE TABLE employees; -- rollback이 불가능, 삭제 속도가 빠르다, rollback 하지 않아도 되는 table에 사용


-- 
rollback;

-- 
commit;
