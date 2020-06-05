-- 'Abel'의 급여와 같은 사원을 출력하자.
select salary from hr.employees
where last_name = 'Abel'; 

select * from hr.employees
where salary = 11000;


select * from hr.employees
where salary = (select salary from hr.employees
where last_name = 'Abel');

--   'Abel'의 급여보다 큰 사원을 출력하자.
select salary from hr.employees
where last_name = 'Abel'; -- 'Abel'급여

select * from hr.employees
where salary > (select salary from hr.employees
where last_name = 'Abel');


-- 120번 사원의 직무와 같고 121번 사원의 급여보다 큰 사원들을 출력하시오.
select job_id from hr.employees
where employee_id = 120; -- SA_REP

select salary from hr.employees
where employee_id = 121; -- 10000

select * from hr.employees
where job_id = (select job_id from hr.employees
		where employee_id = 120)
and salary > (select salary from hr.employees
		where employee_id = 121)

-- 직무에 'SA'를 포함하고 있는 직무의 최저 급여보다 작은 사원들을 출력하시오.

-- SA를 포함환 직무의 최저급여
select min(salary) from hr.employees
where job_id like '%SA%';

select * from hr.employees
where salary < (select min(salary) from hr.employees
		where job_id like '%SA%');

--- 50인 부서의 평균 급여보다 크고 140번의 직무와 같은 사원들을 출력하시오.
select avg(salary) from hr.employees
where department_id = 50;

select job_id from hr.employees
where employee_id = 140;

select * from hr.employees
where salary > (select avg(salary) from hr.employees
		where department_id = 50)
and job_id = (select job_id from hr.employees
		where employee_id = 140);

-- 부서가 없는 직원의 직무와 같은 일을 하는 사원을 출력하시오.
select job_id from hr.employees
where department_id is null;

select * from hr.employees
where job_id = (select job_id from hr.employees
		where department_id is null);


문제) 이름이 Nancy인 사원의 직무와 같고 커미션이 없는 직원을 출력 하시오.
select job_id from hr.employees
where first_name = 'Nancy';

select * from hr.employees
where job_id = (select job_id from hr.employees
		where first_name = 'Nancy')
and commission_pct is null;


문제) 성이 'Abel'인 직원의 직무와 같지 않은 직원을 출력하시오.
select job_id from hr.employees
where last_name = 'Abel';

select * from hr.employees
where job_id != (select job_id from hr.employees
		 where last_name = 'Abel');

문제) 성이 'Abel'인 직원과 같은 해에 입사한 직원을 출력하시오.
select to_char(hire_date, 'yyyy') from hr.employees
where last_name = 'Abel';


select * from hr.employees
where to_char(hire_date, 'yyyy') = 
		(select to_char(hire_date, 'yyyy') 
	 	from hr.employees
		where last_name = 'Abel');


문제) 부서명이 'Marketing'인 부서의 사원들을 출력하시오.
-- 부서번호를 알자.
select department_id from hr.departmenrs 
where department_name = 'Marketing';

select * from hr.employees
where department_id  = 
		(select department_id 
		from hr.departmenrs 
		where department_name = 'Marketing')

--- 성이 'Hunold'인 사원의 직무와 같고 이메일이 
'JMURMAN'인 사원의 부서에 있는 사원들을 출력하시오.
selec job_id from hr.employees
where last_name = 'Hunold';

select department_id from hr.employees
where email = 'JMURMAN';

select * from hr.employees
where job_id = (selec job_id from hr.employees
		where last_name = 'Hunold')
and department_id = (select department_id 
		from hr.employees
		where email = 'JMURMAN');

-- 부서가 80이면서 직무가 'SA_REP' 사원의 평균 급여보다 큰 사원을 출력하시오.
select avg(salary) from hr.employees
where department_id = 80 
and job_id = 'SA_REP'; 

select * from hr.employees
where salary > (select avg(salary) from hr.employees
		where department_id = 80 
		and job_id = 'SA_REP');

-- 전 직원의 평균 급여와 직원의 성, 직무, 입사일을 출력하시오.
select avg(salary) from hr.employees;

select 
     round((select avg(salary) from hr.employees),2),
     last_name, job_id, hire_date
from hr.employees;

문제) 각부서의 최저급여가 90인 부서의 최저급여보다 작은 부서를 출력하시오.
select min(salary) from hr.employees
where department_id = 90;

select department_id , min(salary)
from hr.employees
group by deaprtment_id
having min(salary) < (select min(salary) from 			hr.employees
			where department_id = 90);


select 
from
where 
group by 
having 
order by

문제) 각부서의 평균급여가 50인 부서의 최고 급여보다 큰 부서를 출력하시오.
select department_id , avg(salary)
from hr.employees
group by department_id
having avg(salary) > (select max(salary)
		      from hr.employees
		      where department_id = 50);

문제) 직무의 평균급여가 각 직무의 평균급여에서 제일작은 급여와 같은 직무를 출력하시오.
select job_id, avg(salary)
from hr.employees
group by job_id
having avg(salary) = (select min(avg(salary))
		      from hr.employees
		      group by job_id); 
문제) 각부서의 최저 급여와 같은 급여를 받는 사원들을 구하시오.
select min(salary) from hr.employees
group by department_id;

select * from hr.employees
where salary in (select min(salary) from hr.employees
		 group by department_id);

문제) 'SA_REP'인 직무를 가진 직원의 급여와 같은 급여를 가진 직원들을 구하시오.
select salary from hr.employees
where job_id = 'SA_REP';

select * from hr.employees 
where salary in ( select salary from hr.employees
		where job_id = 'SA_REP');

문제) 'SA_REP' 인 직무를 가진 직원의 급여와 같은 급여를 가진 직원이면서 커미션이 없는 직원만 출력하시오
select salary from hr.employees
where job_id = 'SA_REP';

select * from hr.employees
where salary in (select salary from hr.employees
		where job_id = 'SA_REP')
and commission_pct is null;

문제) 관리자(상사)가 아닌 직원들을 구하시오.
      (부하직원이 없는 사원들을 구하시오)
select * from hr.employees
where employee_id not in 
	(select manager_id from hr.employees
	 where manager_id is not null);

문제) 관리자인 직원들을 구하시오.
select * from hr.employees
where employee_id in (select manager_id
		      from hremployees
		      where manager_id is not null);


문제) 부서장이 아닌 직원들을 구하시오.

select manager_id from hr.departments

select * from hr.employees
where employee_id not in (
		select manager_id from hr.departments
		where manager is not null
	);


--- union 
회원(member) 테이블에 있는 user_id, 직원테이블에 있는 employee_id에 원하느 아이디가 있는지 확인하자.

select user_id from member
where user_id = 'highland0'
union
select employee_id form employees
where employee_id = 'highland0';


문제)직원에 있는 사원번호와 직무를 출력하고 
직무연역테이블(job_history)에 있는 사원번호와 직무를 출력하시오.
select employee_id, job_id
from hr.employees
union
select employee_id, job_id
from hr.job_history;


select employee_id, job_id
from hr.employees
union all
select employee_id, job_id
from hr.job_history;


문제)employee_id에 'highland0'이라는 사용자가 employees와 job_history에 등록되 사용자인지 확인하시오.
select employee_id 
from hr.employees
where employee_id = 'highland0'
union
select employee_id 
from hr.job_history
where employee_id = 'highland0'

문제)employee_id에 '102'이라는 사용자가 employees와 job_history에 등록되 사용자인지 확인하시오.
select employee_id 
from hr.employees
where employee_id = 102
union
select employee_id 
from hr.job_history
where employee_id = 102

문제)employees(영화), job_history(상품)
-- job_id(상품번호), 
-- hire_date , START_DATE(구매날짜)
-- employee_id (구매자) : 102

select job_id, hire_date , '영화' gubun
from hr.employees
where employee_id = 102
union
select job_id, START_DATE, '상품' gubun
from hr.job_history
where employee_id = 102;

--- 주의, 열의 이름은 달라도 데이터타입은 같아야한다.


문제) 직원 테이블에서는 부서번호, 입사일을 출력하고
부서 테이블에서는 부서번호, 지역코드를 출력하시오.
select department_id ,hire_date , to_number(null) location_id
from hr.employees
union
select department_id,to_date(null),   location_id
from hr.departments


문제) 직원테이블에서 직원번호, 직무, 급여를 출력하는데 직무가 'REP'를 포함하여야 한다.
      직무내역 테이블에서는 직원번호 직무를 출력하는데 직무 시작년이 '2002년이어야 한다. 
      급여 대신 0을 출력하시오.

select employee_id, job_id, salary
from hr.employees
where job_id like '%REP%'
union
select employee_id, job_id, 0
from HR.job_history
where to_char(START_DATE,'YYYY') = '2002'; 


======== DML ========
CREATE TABLE DEPARTMENTS
AS
SELECT * FROM HR.DEPARTMENTS;

SELECT * FROM DEPARTMENTS;

CREATE TABLE EMPLOYEES
AS 
SELECT * FROM HR.EMPLOYEES;

SELECT * FROM EMPLOYEES;

SELECT * FROM DEPARTMENTS
WHERE DEPARTMENT_ID = 300;

INSERT INTO departments(department_name,department_id, 
        manager_id, location_id)
VALUES ('Public Relations', 300,  100, 1700);

SELECT * FROM DEPARTMENTS 
WHERE DEPARTMENT_ID = 300;

SELECT * FROM DEPARTMENTS 
WHERE DEPARTMENT_ID = 301;

DESC departments;

INSERT INTO departments
VALUES ( 301,'솔데스크',  100, 1700); --(X)
-- apllication과 db가 독립이지 않게 된다.

SELECT * FROM DEPARTMENTS
WHERE department_id = 301;


desc departments; -- not null인 컬럼확인,

문제) null인 컬럼에는 값을 저장하지 말자.
insert into departments 
	   (department_id, department_name, manager_id, location_id)
values(302,'총무부',null,null);


insert into departments 
	   (department_id, department_name)
values(303,'생산관리부');

insert into departments 
values(304,'품질관리부',null,null);

--- not null인 부서명에 null값을 입력해 보자.
insert into departments 
	(department_id, department_name, manager_id, location_id)
values(304,null,101,1400); --오류
ORA-01400: cannot insert NULL into ("STUDY"."DEPARTMENTS"."DEPARTMENT_NAME")

문제) 오늘 날짜를 확인하자.
select sysdate from dual;


문제) 210번사원에 정보를 입력하는데 이름은 '숭무', 성은 '박', 이메일은 'highland0', 폰넘버는 01071461970, 직무번호 SA_REP, 입사일은 오늘,급여 1000, 커미션 null,  상사 205, 부서 100입니다.

insert into employees(employee_id, first_name, last_name, email,
	phone_number, hire_date, job_id, salary, commission_pct,
	manager_id, department_id)
values(210, '숭무', '박', 'highland0', '01071461970', sysdate,
'SA_REP', 1000, null, 205, 100);

select * from employees
where employee_id = 210;
















 














