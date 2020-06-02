-- desc = 컬럼리스트 확인
desc HR.employees;
select * from HR.employees;
select employee_id, salary, commission_pct 
from HR.employees;

-- select 구문에 연산자 활용
select last_name, salary, salary + 300, salary - 300, salary * 2, salary / 2
from HR.employees;

-- 매달 100씩 추가된 사원의 이름, 급여, 연봉
select first_name, salary + 100, (salary + 100) * 12
from HR.employees;

select last_name, job_id, salary, (salary*12)*commission_pct
from HR.employees;

-- colume 네임 변경하기
select last_name as name, commission_pct comm
from HR.employees;

-- colume 네임 변경하기 대소문자 구분하는 경우 ""
select last_name as "Name", commission_pct "Comm Pct"
from HR.employees;

-- 문제) first_name 이 '숭무'이고 last_name이 '이' 일때
-- '이숭무'로 출력되도록 하시오. -- 아래 코드는 리터럴
select last_name || '   ' || first_name "fullName", 25
from HR.employees;

-- 문제) 이숭무의 직무는 강사입니다. 처럼 출력하시오.
select last_name || ' ' || first_name || '의 직무는 ' || job_id || ' 입니다. ' "Name_Job"
from HR.employees;

-- 리터럴 문자열 안에 특수문자를 출력하려면 q'[ ...Text ]'
select department_id || q'[ it`s assigned Manager Id;]'
from HR.departments;

-- 반복적으로 출력되는 부서를 한번만 출력하자. - distinct
select distinct department_id
from HR.employees;

-- 부서별 직무를 출력하시오.
select distinct job_id, department_id
from HR.employees;


-- ************************* Selection *************************
-- (where)
select employee_id, last_name, job_id, department_id
from HR.employees
where department_id = 90;

-- 데이터가 문자일 경우 ''
select employee_id, last_name, job_id, department_id
from HR.employees
where job_id = 'ST_MAN';

-- 데이터를 비교할 때 대소문자 구분 해야 함.
select employee_id, last_name, job_id, department_id
from HR.employees
where last_name = 'Whalen';

-- 연산자 활용
select *
from HR.employees
where salary >= 3000 or salary <= 5000;

select *
from HR.employees
where hire_date < '05/12/01';

select *
from HR.employees
where first_name <= 'Neena';

-- 문제) 입사일이 02/01/01 부터 04/12/31 사이에 입사한 직원을 출력하시오.
select last_name, first_name, employee_id, hire_date
from HR.employees
where hire_date between '02/01/01' and '04/12/31';
-- where hire_date >= '02/01/01' and hire_date <= '04/12/31'; -- 위 와 같다.

-- 급여가 5000에서 10000사이에 있는 직원을 출력하시오.
select *
from HR.employees
where salary between 5000 and 10000;
-- where salary >= 5000 and salary <= 10000; -- 위 와 같다.


-- 이름이 'Lex'이고 직무가 'AD_VP'인 사원을 출력하시오.
select *
from HR.employees
where first_name = 'Lex' and job_id = 'AD_VP';

-- 부서가 10, 30, 50인 사원들을 출력하시오.
select *
from HR.employees
where department_id in(10, 30, 50);
-- where department_id = 10 or department_id = 30 or department_id = 50; -- 위 와 같다.

-- 관리자 100 이거나 120 이거나 110인 사원을 출력하시오.
select *
from HR.employees
where manager_id in(100, 110, 120);
-- where manager_id = 100 or manager_id = 110 or manager_id = 120; -- 위 와 같다.



desc HR.departments;
select * from HR.departments;
select department_id, location_id, manager_id
from HR.departments;



-- 예제 ----------------------------------------------
-- les01
desc HR.departments;
select *
from HR.departments;

desc HR.employees;
select employee_id, last_name, job_id, hire_date as startdate
from HR.employees;

select distinct job_id
from HR.employees;

select last_name || ', ' || job_id "Employee and Title"
from HR.employees;
--where last_name = 'King';

select first_name || ', ' || 
last_name || ', ' || 
email || ', ' || 
phone_number || ', ' || 
hire_date || ', ' || 
job_id || ', ' || 
salary || ', ' || 
commission_pct || ', ' || 
manager_id || ', ' || 
department_id "THE_OUTPUB"
from HR.employees;

-- les02
select last_name, salary
from HR.employees
where salary >= 12000;

select last_name, department_id
from HR.employees
where employee_id = 176;

select last_name, salary
from HR.employees
where not salary between 5000 and 12000;

select last_name, job_id, hire_date 
from HR.employees
where hire_date between '05/02/20' and '05/05/01'
order by hire_date asc;

select last_name, department_id
from HR.employees
where department_id in (20, 50)
order by last_name asc;

select last_name "Employee", salary "Monthly Salary"
from HR.employees
where (salary between 5000 and 12000) and (department_id in (20, 50));

select last_name, hire_date
from HR.employees
where hire_date between '05/01/01' and '05/12/31';

-- les03

-- ----------------------------------------------