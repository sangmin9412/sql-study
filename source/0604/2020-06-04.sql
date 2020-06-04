ANSI JOIN
-- NATURAL JOIN
-- 컬럼명이 같은 컬럼은 비교 대상이된다.
SELECT department_id, department_name,
       location_id, employee_id, manager_id
FROM   hr.employees NATURAL JOIN hr.departments;
-- 위와 아래의 명령문은 같은 의미를 갖는다.

select department_id, department_name,
       location_id, employee_id, manager_id
from HR.employees  join HR.departments
using (department_id, manager_id); 

-- 위와 아래가 같은 의미이다.
select department_id, department_name,
       location_id, employee_id, manager_id
from hr.employees e join hr.departments
on e.department_id = d.department_id
and e.manager_id = d.manager_id;


--- 두테이블의 같은 이름의 컬럼이 location_id가 같으므로 location_id 만 조인 조건이 된다.
select department_id, department_name, location_id, city
from hr.departments NATURAL JOIN hr.locations;

select department_id, department_name, l.location_id, 	city
from hr.departments d JOIN hr.locations l 
on d.location_id = l.location_id;

--NATURAL JOIN을 사용하는 경우 유의해야 할 점은 같은 이름의 컬럼은 모두 조인조건으로 사용하게 된다.


-- inner join 
select department_id, department_name, l.location_id, 	city
from hr.departments d JOIN hr.locations l 
on d.location_id = l.location_id;

-- using
select department_id, department_name,location_id, 	city
from hr.departments inner JOIN hr.locations 
using (location_id);

-- ASNI JOIN과 T-SQL JOIN비교
--ANSI JOIN
select d.department_id, department_name,
       location_id, employee_id, e.manager_id
from HR.employees e  join HR.departments d
on e.department_id = d.department_id;

-- T-SQL
select d.department_id, department_name,
       location_id, employee_id, e.manager_id
from HR.employees e  , HR.departments d
where e.department_id = d.department_id;

-- 문제) 사원번호가 120인 사원의 사원번호, 성, 급여,
부서번호, 부서명과 지역번호를 출력하시오.
select employee_id, last_name, salary, 
       e.department_id, department_name, location_id
from hr.employees e JOIN hr.departments d
on e.department_id = d.department_id
AND employee_id = 120;
-- where employee_id = 120;


-- 문제) 101인 상사를 가지고 있는 사원의 사원번호,성
, 급여, 부서번호, 부서명을 출력하시오.
select employee_id, last_name, salary, 
	d.department_id, department_name
from hr.employees e JOIN hr.departments d
on e.department_id = d.department_id
where e.manager_id = 101;

-- T-SQL
select employee_id, last_name, salary, 
	d.department_id, department_name
from hr.employees e, hr.deparments d
where e.department_id = d.department_id
and e.manager_id = 101;

-- 문제)직원의 정보(사원번호, 성, 직무, 상사)를 출력할 때 부서이름, 부서번호 그리고 부서의 주소(location_id)를 출력하는데 부서번호가 90인 직원만 출력하시오.
- ANSI JOIN
select employee_id, last_name, job_id, e.manager_id,
      e.department_id, department_name, location_id
from hr.employees e join hr.departments d
on e.department_id = d.department_id
and e.department_id = 90;

- T-SQL JOIN
select employee_id, last_name, job_id, e.manager_id,
      e.department_id, department_name, location_id
from hr.employees e , hr.departments d
where e.department_id = d.department_id
and e.department_id = 90;

문제) 직원정보를 출력하데 직원 어느 부서에서 근무하는지 부서명을 출력하시오. ( ansi, t-sql 모두사용)
성, 직원번호, 부서번호, 부서명, 지역코드
SELECT employee_id, last_name,
       d.department_id, department_name, location_id
FROM hr.employees e JOIN hr.departments d
ON e.department_id = d.department_id;

SELECT employee_id, last_name,
       d.department_id, department_name, location_id
FROM hr.employees e , hr.departments d
where e.department_id = d.department_id;


문제) 같은 부서의 부서장을 상사인 직원들의 리스트를 출력하는데 30, 50, 90인 부서만 출력 ( ansi, t-sql 모두사용)사원번호, 성, 상사, 부서번호, 부서명, 부서장
select employee_id, last_name, e.manager_id
       d.department_id, departmet_name, d.manager_id
from hr.employees e  join   hr.departments
on e.department_id = d.department_id  
and e.manager_id = d.manager_id 
where e.department_id in(30, 50, 90);

select employee_id, last_name, e.manager_id
       d.department_id, departmet_name, d.manager_id
from hr.employees e    ,    hr.departments
where e.department_id = d.department_id  
and e.manager_id = d.manager_id 
and e.department_id in(30, 50, 90);

-- 'REP'가 포함된 직무가 가진 사원의 사원번호와 성, 직무, 부서번호, 부서명, 부서장번호를 출력하시오.
select employee_id, last_name, job_id, 
       d.department_id, department_name, d.manager_id
from hr.employees e join hr.departments d
on e.department_id = d.department_id 
and job_id like '%REP%';

select employee_id, last_name, job_id, 
       d.department_id, department_name, d.manager_id
from hr.employees e , hr.departments d
where e.department_id = d.department_id 
and job_id like '%REP%';


-- 부서정보를 출력할 때 부서의 주소도 모두 출력하시오.
-- 부서 : departments, 주소 정보 : locations
-- 부서번호, 부서명, 부서장번호,
-- COUNTRY_ID, CITY, STREET_ADDRESS, location_id
-- select * from hr.locations;
select department_id, department_name, manager_id,
      l.location_id,  COUNTRY_ID, CITY, STREET_ADDRESS
from hr.departments d join hr.locations l
on d.location_id = l.location_id; 


-- 직원이 속해있는 부서의 주소정보를 출력하자.
-- 사원번호, 성, 입사일 
--  부서번호, 부서명, 부서장
-- COUNTRY_ID, CITY, STREET_ADDRESS, location_id
-- T-SQL join
select employee_id, last_name, hire_date,
      d.department_id, department_name, d.manager_id,
      l.location_id, COUNTRY_ID, CITY, STREET_ADDRESS 
from hr.employees e , hr.departments d, hr.locations l
where e.department_id = d.department_id
and d.location_id = l.location_id;


-- ansi join
select employee_id, last_name, hire_date,
      d.department_id, department_name, d.manager_id,
      l.location_id, COUNTRY_ID, CITY, STREET_ADDRESS 
from hr.employees e join hr.departments d
on e.department_id = d.department_id 
		    join hr.locations l
on d.location_id = l.location_id;

문제) 
직원이 속해있는 부서의 주소정보를 출력하자.
--사원번호, 성, 입사일 
--부서번호, 부서명, 부서장
-COUNTRY_ID, CITY, STREET_ADDRESS, location_id
이때 부서번호가 90인 직원정보만 출력하시오.
-- ANSI JOIN
select employee_id, last_name, hire_date, 
       d.department_id, department_name, d.manager_id,
       COUNTRY_ID, CITY, STREET_ADDRESS, l.location_id
from  hr.employees e  join hr.departments d
on e.department_id = d.department_id  
		              join hr.locations l
on d.location_id = l.location_id
where e.department_id = 90;

--- 직무 정보에 대해서 출력하시오
select * from hr.jobs;
job_id : primary key
--- 사원정보
select * from hr.employees;
employee_id : primary key 
job_id : foreign key
department_id : foreign key
--- 부서정보
select * from hr.departments;
department_id : primary key
location_id : foreign key
-- 주소 정보
select * from hr.locations;
location_id : primary key

select job_title, employee_id, last_name,
       department_name, STREET_ADDRESS
from hr.jobs j join hr.employees e
on j.job_id = e.job_id 
		join hr.departments
on e.department_id = d.department_id
		join hr.locations
on d.location_id = l.location_id;

select job_title, employee_id, last_name,
       department_name, STREET_ADDRESS
from hr.jobs j, hr.employees e, hr.departments d, hr.locations l
where j.job_id = e.job_id 
and e.department_id = d.department_id
and d.location_id = l.location_id;

문제) 부서가 20이거나 50인 부서의 사원번호와 부서번호 및 부서명 그리고 위치정보를 출력하시오.
select employee_id, e.department_id, department_name,
       location_id
from hr.employees e join hr.departments d
on e.department_id = d.department_id
and e.department_id in(20,50);

select employee_id, e.department_id, department_name,
       location_id
from hr.employees e , hr.departments d
where e.department_id = d.department_id
and e.department_id in(20,50);

문제) Matos라는 성을 가지고 있는 사원이 있다.
이 사원의 부서정보와 사원번호 그리고 성을 출력하시오.
select employee_id, last_name, d.deparment_id,
	department_name
from hr.employees e join hr.departments d
on e.department_id = d.department_id
and last_name = 'Matos';

select employee_id, last_name, d.department_id,
	department_name
from hr.employees e , hr.departments d
where e.department_id = d.department_id
and last_name = 'Matos';

문제) Matos라는 성을 가지고 있는 사원과 King라는 성을 
      가진 사원이 있다.
이 사원의 부서정보와 사원번호 그리고 성을 출력하시오.
select last_name, employee_id, 
       d.department_id, department_name
from hr.employees e join hr.departments d
on e.department_id = d.department_id
and last_name in ('Matos', 'King');

select last_name, employee_id, 
       d.department_id, department_name
from hr.employees e , hr.departments d
where e.department_id = d.department_id
and last_name in ('Matos', 'King');

문제) King라는 성을 가지고 있는 사원이 있다.
이 사원의 부서정보와 사원번호 그리고 성을 출력하시오.
select employee_id, last_name, d.department_id,
	department_name
from hr.employees e join hr.departments d
on e.department_id = d.department_id
and last_name = 'King';

select employee_id, last_name, d.department_id,
	department_name
from hr.employees e , hr.departments d
where e.department_id = d.department_id
and last_name = 'King';


문제) 부서테이블에서 부서번호와 부서명 그리고 지역코드와 지역명을 출력하는데 지역코드가 1400인 지역만 출력 

select department_id, department_name, 
	l.location_id, STREET_ADDRESS
from hr.departments d join hr.locations l
on d.location_id = l.location_id
and l.location_id = 1400;

select department_id, department_name, 
	l.location_id, STREET_ADDRESS
from hr.departments d , hr.locations l
where d.location_id = l.location_id
and l.location_id = 1400;


문제) 사원이 하고 있는 직무 이름과 사원의 부서명을 출력하는데 사원번호 이름도 출력하시오.
단, 직무번호가 'SA'를 포함하고 있는 직무와 '2005'년에 입사한 사원만 출력하시오.
select job_title, employee_id, first_name, 		department_name
from hr.jobs j 
		join hr.employees e
on j.job_id = e.job_id
	       join hr.departments d
on e.department_id = d.department_id
and e.job_id like '%SA%' 
and to_char(hire_date,'yyyy') = '2005';


select job_title, employee_id, first_name, 			department_name
from hr.jobs j ,  hr.employees e, hr.departments d
where j.job_id = e.job_id 
and e.department_id = d.department_id
and e.job_id like '%SA%' 
and to_char(hire_date,'yyyy') = '2005';


문제) 104번 사원의 상사의 정보를 출력하시오.
select e2.employee_id, e2.last_name, e2.hire_date
from hr.employees e1 , hr.employees e2
where e1.manager_id = e2.employee_id
and e1.employee_id = 104;

문제) 직원이름과 직원의 상사 이름을 출력하시오.
select e.first_name, m.first_name
from hr.employees e , hr.employees
where e.manager_id = m.employee_id;

--- 부서가 없는 사원을 출력하시오.
select * from hr.employees
where department_id is null;
-- 직원에 대한 부서정보를 출력하시오.
-- 직원: 사원번호 , 성, 급여
-- 부서: 부서번호, 부서이름
-- 단, 178 사원을 출력하시오.
select employee_id, last_name, salary,
       d.department_id, department_name
from hr.employees e, hr.departments d
here e.department_id = d.department_id
and e.employee_id = 178;

문제) 직원에 대한 부서 정보를 출력하는데 부서가 없는 직원도 출력하게 하라.
-- 직원: 사원번호 , 성, 급여
-- 부서: 부서번호, 부서이름
select employee_id, last_name, salary,
	d.department_id, department_name
from hr.employees e left outer join hr.deaprtments d
on e.department_id = d.department_id
where e.employee_id = 178;

select employee_id, last_name, salary,
	d.department_id, department_name
from hr.employees e , hr.deaprtments d
where e.department_id = d.department_id(+)
and e.employee_id = 178;

-- null이 출력되는 곳에 (+)를 둔다.


문제) 직원정보와 부서정보를 출력할 때 모든 부서가 나올수 있도록하자. 
-- 사원이 없는 부서정보도 출력
-- 직원: 사원번호 , 성, 급여
-- 부서: 부서번호, 부서이름
select employee_id, last_name, salary,
	d.department_id, department_name
from hr.employees e right outer join hr.departments d
on e.department_id = d.department_id;

select employee_id, last_name, salary,
	d.department_id, department_name
from hr.employees e , hr.departments d
where d.department_id = e.department_id(+);


문제)부서가 없는 직원과 직원 없는 부서를 모두 출력하고 싶다.
-- 직원: 사원번호 , 성, 급여
-- 부서: 부서번호, 부서이름
select employee_id, last_name, salary,
       d.department_id, department_name
from hr.employees e full outer join hr.departments d
on e.department_id = d.department_id;



























