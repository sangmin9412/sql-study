-데이터 액세스를 제한하기 위해
-복잡한 질의를 쉽게 작성하기 위해
-데이터 독립성을 제공하기 위해
-동일한 데이터로부터 다양한 결과를 얻기 위해

 문제 1) 사원번호, 이름, 직무, 커미션을 포함한 년봉을 출력하자.
select employee_id, first_name, job_id, 
	(nvl(commission_pct, 0) * salary) + salary year_sal
from employees;

문제 2) 위 문제를 view로 만들어보자.
create view yearsal
as 
select employee_id, first_name, job_id, 
	(nvl(commission_pct, 0) * salary) + salary year_sal
from employees;

select * from yearsal;


문제 3) 사원번호, 성 이름, 급여, 입사일, 부서를 출력할때 view를 통해서 출력하도록하자.

create view empview
as
select employee_id id_nember, last_name || ' ' || first_name name, 
	salary sal , hire_date , department_id dept_id
from employees;


select * from empview;

문제 4) 위에 만든 view에서 id_number, name만 출력하시오.
select id_nember, name
from empview;


문제 5) 위view에서 id_nember를 id_number로 변경하자.
create or replace view empview
as
select employee_id id_number, last_name || ' ' || first_name name, 
	salary sal , hire_date , department_id dept_id
from employees;

select id_number, name
from empview;

문제 6) 부서번호가 90인 사원들만 view를 통해서 출력하시오.
select * from empview
where dept_id = 90; -- department_id사용할 수 없음.
                    -- view를 만들 때 컬럼명을 변경했기 때문..

문제 7) 직무가 'SA'포함하는 사원들을 view를 통해서 출력하시오.
select * from  empview
where job_id like '%SA%'; 
ORA-00904: "JOB_ID": invalid identifier
이유는 view에 job_id가 없어서 생긴 오류


문제 8)문제 7이 실행할 수 있도록 수정하시오.
create or replace view empview
as
select employee_id id_number, last_name || ' ' || first_name name, 
	salary sal , hire_date , department_id dept_id, job_id
from employees;

문제 9) 문제 7을 다시 실행시켜보자.
 select * from  empview
where job_id like '%SA%'; 


문제 10) 문제 8의 view에서 컬럼명에 별칭을 사용하지말고 view에 컬럼명을 정의해 보자.
create or replace view empview
(id_number, name, sal, hire_date, dept_id, job_id )
as
select employee_id , last_name || ' ' || first_name , 
	salary  , hire_date , department_id , job_id
from employees;

select * from empview;


문제 11) 부서별 급여의 평균, 합계, 최고 값, 그리고 최저 값을 view를 통해서 출력하시오.view명은 salview이다.
create or replace view salview
as
select department_id , avg(salary) avgsal, sum(salary) sumsal,
	max(salary) maxsal, min(salry) minsal
from employees
group by  department_id;

select * from salview;

문제 12)  문제 11에서 부서의 평균 값이 10000이상인 부서만 출력하시오.
select * from salview
where avg(salary) >= 10000; --(X)

 select * from salview
where avgsal >= 10000; --(O)

문제 13) 사원번호, 성, 이메일, 입사일, 직무, 부서번호를 가지는 view를 만드시오. salview을 view명으로 한다.

create  or replace view salview
(emp_id, lname, email, HIRE_DATE, JOB_ID, dept_id)
as
select EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID, DEPARTMENT_ID
from employees;

select * from salview;

문제 14) salview의 각각의 컬럼에 400, RHEE, SMRHEE, 현재날짜, 'SA_MAN', 70
을 입력하시오.
insert into  salview(emp_id, lname, email, HIRE_DATE, JOB_ID, dept_id)
values(400, 'RHEE', 'SMRHEE', sysdate, 'SA_MAN', 70);

select * from salview
where emp_id = 400;

select * from employees
where employee_id = 400;

--- view를 통해서 insert를 하는 경우에는 실제 테이블에 저장이되는 것이므로
-- not null인 컬럼은 꼭 view에 있어야 한다.

문제 15) view인 salview를 통해서 부서 번호가 70인 부서의 사원을 삭제 하시오.
select * from employees where department_id = 70;

delete from salview
where dept_id = 70;

select * from employees where department_id = 70;

문제 16) 부서명별 평균 급여와 합계, 최고, 최저가 출력되게 
slaview1인 view를 만드시오.

create  or replace view salview1
(dname, avgsal,sumsal, maxsal, minsal)
as
select department_name, avg(salary), sum(salary), max(salary), min(salary) 
from employees e, departments d
where e.department_id = d.department_id
group by  department_name;

select * from salview1;

문제 17) 사원번호, 성, 이메일, 입사일, 직무 , 부서번호, 부서명을 empview1이라는 view를 통해서 출력하시오.
create  or replace view empview1
(emp_id, lname, email, HIRE_DATE, JOB_ID, dept_id, dname)
as
select EMPLOYEE_ID, LAST_NAME, EMAIL, HIRE_DATE, JOB_ID, d.DEPARTMENT_ID,
	department_name
from departments d, employees e
where d.department_id = e.department_id;

select * from empview1;


문제 18)  empview1에 있는 emp_id, lname, email, HIRE_DATE, JOB_ID에
각각 400, 'RHEE', 'SMRHEE', sysdate, 'SA_MAN'를 저장하시오.

insert into  empview1(emp_id, lname, email, HIRE_DATE, JOB_ID)
values(400, 'RHEE', 'SMRHEE', sysdate, 'SA_MAN');

-- 복합뷰는 DML문을 사용할 수 없을 수 도 있다.
SQL 오류: ORA-01779: cannot modify a column which maps to a non key-preserved table
primary key가 존재하지 않은  table에 대해서는 값을 저장할 수 없다.

























 





































