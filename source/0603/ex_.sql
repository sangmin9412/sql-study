-- 문제) 직원 전체에서 입사일이 제일 빠른 사람과 최근에 입사한 사원을 출력하시오.
select min(hire_date), max(hire_date)
from HR.employees;

-- 문제) 사원의 수를 출력하시오.
select count(*)
from HR.employees;

-- 문제) 직원테이블에서 부서가 몇개인지를 출력하시오.
select count(distinct department_id)
from HR.employees;

-- 문제) 사원 테이블에서 각 부서별 급여평균을 구하자.
select distinct avg(salary)over(partition by department_id)
from HR.employees;

select avg(salary)
from HR.employees
group by department_id;

-- 문제) 위 문제에서 부서를 오름차순으로 정렬하고 출력하시오.
select avg(salary), department_id
from HR.employees
group by department_id
order by 2;

-- 문제) 각 부서별 급여의 평균을 구하고 평균값이 낮은 것부터 출력하시오.
select avg(salary), department_id
from HR.employees
group by department_id
order by 1;

-- 문제) 각 부서에 있는 사원의 직무별 급여의 평균을 구하시오.
select avg(salary), department_id, job_id
from HR.employees
group by department_id, job_id;

-- 문제) 직무에 REP가 포함되어 있는 사원들의 평균 급여와 최소급여, 최대급여, 급여의 합계를 구하시오
select avg(salary), min(salary), max(salary), sum(salary)
from HR.employees
where job_id like '%REP%';
--group by job_id;

-- 문제) 직무에서 4번째에서 6번째까지 PRO가 있다면 it_program으로 출력
--                                    ACC가 있다면 finance_account
--                                    나머지는 business로 출력하시오.
select job_id, substr(job_id, 4, 3),
case substr(job_id, 4, 3) when 'PRO' then 'it_program'
                            when 'ACC' then 'finance_account'
                            else 'business' end job
from HR.employees;

-- 문제) 급여가 15000 이상이면 임원으로 출력
--             10000 이상이면 부장
--             7000 이상이면 부장
--             5000 이상이면 부장
--             나머지는 사원으로 출력하시오.
select last_name, salary, job_id,
    case when salary >= 15000 then '임원'
        when salary >= 10000 then '부장'
        when salary >= 7000 then '과장'
        when salary >= 5000 then '대리'
    else '사원' end "직급"
from HR.employees;

-- 문제) 부서별 급여의 평균이 5000이상인 부서만 출력하시오
select trunc(avg(salary), 2), department_id
from HR.employees
group by department_id
having avg(salary) >= 5000;

-- 문제) 급여가 10000이상인 사원들중 부서별 급여 평균이 160000이상인 부서만 출력하시오.
select department_id, salary, avg(salary), count(*)
from HR.employees
where salary >= 10000
group by department_id, salary
having avg(salary) >= 16000;

-- 문제) 입사일이 2005년도 이전에 입사한 사람들 중 부서별 최대급여가 8000이상인 부서와 최대 급여를 출력하시오.
select department_id, max(salary)
from HR.employees
where hire_date < to_date('20050101', 'yyyymmdd')
group by department_id
having max(salary) >= 8000;

-- 문제) 부서별 최대 급여가 10000 이상인 부서만 출력하시오.
select max(salary), department_id
from HR.employees
group by department_id
having max(salary) >= 10000
order by 2;

-- 문제) 직무에 'REP' 포함하고 있지 않은 사원들중 직무별 급여의 합계가
-- 13000을 초과하는 직무와 급여의 합계를 출력하시오.
-- 또한 급여의 합계를 내림차순으로 정렬하여 출력하시오.
select job_id, sum(salary)
from HR.employees
where job_id not like '%REP%'
group by job_id
having sum(salary) > 13000
order by 2 desc;

-- 문제) 'REP'가 포함되어 있는 직무의 급여의 평균과 최고 급여와 최저 급여와 총 급여의 합계를 출력하시오.
select avg(salary), max(salary), min(salary), sum(salary)
from HR.employees
where job_id like '%REP%';

-- 문제) 전체 사원의 평균 급여와 최대 급여와 최소 급여, 그리고 급여의 합계 및 직원수를 출력하시오.
select avg(salary), max(salary), min(salary), sum(salary), count(*)
from HR.employees;

-- 문제) 50인 부서의 사원수를 구하시오.
select count(*), count(department_id)
from HR.employees
where department_id = 50;

-- 문제) 커미션을 받는 사원의 수를 구하시오.
select count(*), count(commission_pct)
from HR.employees;
--where commission_pct is not null;


-- 문제) 이 회사의 평균 커미션은 어떻게 되나?
select avg(nvl(commission_pct, 0)), sum(commission_pct) / count(*)
from HR.employees;

-- 문제) 부서별 급여 평균을 구하시오.
select department_id, avg(salary)
from HR.employees
group by department_id;

-- 문제) 직무별 급여의 평균과 합계 그리고 최고 값과 최저 값, 직원의 수를 구하시오.
select avg(salary), max(salary), min(salary), count(*)
from HR.employees
group by job_id;

-- 문제) 50인 부서의 부서번호와 직무를 출력하시오. 직무를 내림차순으로 정렬하시오.
select department_id, job_id
from HR.employees
where department_id = 50
order by job_id desc;

-- 문제) 각 부서의 직무별 최대급여를 구하는데, 직무가 'SA_REP'에 해당되는 것만 출력하시오.
select max(salary), job_id, department_id
from HR.employees
where job_id = 'SA_REP'
group by department_id, job_id;
-- 문제) 위 조건에서 최대 급여가 10000이상인 것만 출력하시오.
select max(salary), job_id, department_id
from HR.employees
where job_id = 'SA_REP'
group by department_id, job_id
having max(salary) >= 10000;

-- 문제) 직무별 급여의 합계를 구하는데 직무에 MAN가 포함되어 있는 것을 가져오며
-- 급여에 합계가 15000이상 이어야 하며 급여의 합계를 내림차순으로 정렬하시오.
select avg(salary)
from HR.employees
where job_id like '%MAN%'
group by job_id
having avg(salary) >= 15000
order by 1 desc;

-- 문제) 사원번호, 성, 입사일을 출력하는데 각 사원이 소속되어 있는 
-- 부서의 제일 빠른 입사일과 제일 늦은 입사일, 그리고 부서별 직무를 맡은 사원중 제일 많은 급여를 출력하시오.
select employee_id, last_name, hire_date, department_id, salary,
min(hire_date)over(partition by department_id) "제일 빠른 입사일", 
max(hire_date)over(partition by department_id) "제일 늦은 입사일",
max(salary)over(partition by department_id) "제일 많은 급여"
from HR.employees;


--------------------------------------------------------------------------
select employee_id, last_name, salary, d.department_id, d.department_name
from HR.employees e, HR.departments d;

