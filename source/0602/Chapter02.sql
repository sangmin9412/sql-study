-- 데이터 값에서 {문자열} 찾기 - like
select *
from HR.employees
where last_name like '%o%' or email like '%o%';

-- String sql = "select * from HR.employees"
--            + "where last_name like '%' + or email like '%o%'";

-- {문자열} 로 시작하는
-- 문제 'A'로 시작하는 이름을 출력하시오.
select * from HR.employees
where first_name like 'A%';

-- {문자열} 로 끝나는
-- 문제 이름이 'a'로 끝나는 
select * from HR.employees
where first_name like '%a';

-- 2002년도에 입사한 사원들을 출력하시오.
select * from HR.employees
where hire_date like '02%';

-- 두번째 글자에 'o'가 이름에 포함된 사원을 출력하시오.
select * from HR.employees
where first_name like '_o%';

-- 세번째 글자에 'o'가 초함되어 있는 사원을 출력하시오.
select * from HR.employees
where first_name like '__o%';

-- 뒤에서 이름의 두번째에 'o'가 포함되어 있는 사원을 출력하시오.
select * from HR.employees
where first_name like '%o_';

-- 이름에 sa가 포함된 사원을 출력하시오.
select * from HR.employees
where first_name like '%sa%';

-- 이름이나 이메일에 sa가 포함된 사원을 출력하시오.
select * from HR.employees
where first_name like '%sa%' or email like '%sa%';


-- where is
select last_name, job_id, commission_pct
from HR.employees;

-- 커미션을 받지 못하는 사원을 출력하시오.
select *
from HR.employees
where commission_pct is null;

-- 커미션을 받는 사원을 출력하시오.
select *
from HR.employees
where not commission_pct is null;

-- 부서가 없는 사원을 출력하시오.
select *
from HR.employees
where department_id is null;

-- 부서가 있는 사원을 출력하시오.
select *
from HR.employees
where not department_id is null;


-- and | or
-- 급여가 10000이거나 직무가 MAN을 포함하고 있는 사원을 출력하시오.
select *
from HR.employees
where salary = 10000 or job_id like '%MAN%';

-- 급여 150000이상이면서 직무가 'SA_PER'이거나 'AD_PRES'인 사원을 출력하시오.
select *
from HR.employees
where salary >= 15000 and job_id in ('SA_REP', 'AD_PRES');

-- 부서가 30이고 60인 부서에서 급여가 10000 이상인 사원을 출력하시오.
select *
from HR.employees
where department_id in (30, 60) and salary >= 10000;


-- order by -- [asc = 오름차순 desc = 내림차순 asc = default]
-- 이름을 오름차순으로 정렬하여 출력
select *
from HR.employees
order by first_name;

-- 입사일이 빠른 사원부터 출력하시오.
select *
from HR.employees
order by hire_date asc;

-- 최근에 입사한 사원부터 출력하시오.
select *
from HR.employees
order by hire_date desc;

-- 사원번호, 성, 연봉을 출력하는데 연봉을 ansal로 출력하시오.
select employee_id, last_name, salary * 12 "ansal"
from HR.employees;
-- 위 내용에서 연봉을 오름차순으로 출력하시오 - 정렬 할 때 [번호,별칭을 사용할 수 있다]
select employee_id, last_name, salary * 12 "ansal"
from HR.employees
order by "ansal";
-- order by 3;

-- 부서를 오름차순으로 같은 부서의 사원들의 급여를 내림차순으로 정렬하시오.
select *
from HR.employees
order by department_id, salary desc;

-- 50인 부서의 사원들을 직무를 내림차순으로 정렬하고 직무에 대한 급여를 오름차순으로 정렬하시오.
select *
from HR.employees
where department_id = 50
order by job_id desc, salary;

-- 급여가 10000이 아닌 사원들을 출력하시오.
select *
from HR.employees
where salary != 10000;
-- where salary ^= 10000;
-- where salary <> 10000;

-- 직무가 'SA_REP', 'AD_PRES'에 속해있지 않는 사원들을 출력하시오.
select *
from HR.employees
where job_id not in ('SA_REP', 'AD_PRES');
--where not (job_id = 'SA_REP' or job_id = 'AD_PRES');
--where job_id != 'SA_REP' and job_id != 'AD_PRES';

-- 문제 사원의 급여가 3000보다 작고 10000보다는 큰 사원을 출력하시오.
select *
from HR.employees
where salary not between 3000 and 10000;