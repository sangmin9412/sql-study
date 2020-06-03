-- 멀티 로우 함수(그룹 함수) - AVG, COUNT, MAX, MIN, STDDEV, SUM, VARIANCE
select count(*)
from HR.employees;

-- 지정한 날짜의 요일을 출력하시오.
select sysdate, to_char(sysdate, 'D') "1~7", to_char(sysdate, 'Day') "요일", to_char(sysdate, 'DD') "날짜"
from dual;

-- 사원들이 입사한 요일이 언제인지 출력하시오
select employee_id, last_name, job_id, to_char(hire_date, 'D') "요일 Number", to_char(hire_date, 'Day') "입사한 요일"
from HR.employees;

-- 문제 현재 날짜의 일요일과 토요일을 출력하시오.
select sysdate - to_char(sysdate, 'd') + 1, sysdate - to_char(sysdate, 'd')
from dual;

select next_day(sysdate, '일요일') "이번 주 의 일요일", next_day(sysdate, '토요일') "이번 주 의 토요일"
from dual;

select salary
from HR.employees
where job_id like '%REP%';
-- 위 결과에서 급여의 평균, 최대 급여, 최소 급여를 출력하시오
select trunc(avg(salary), 2) "평균", max(salary) "최대", min(salary) "최소", sum(salary) "합계", job_id
from HR.employees
where job_id like '%REP%'
group by job_id;

--
select salary, job_id
from HR.employees
where job_id like '%REP%';

--
select job_id
from HR.employees
group by job_id;

-- 전체 사원의 평균 급여와 최대 급여와 최소 급여,
-- 그리고 급여의 합계 및 직원수를 출력하시오.
select trunc(avg(salary), 2) "평균", max(salary) "최대", min(salary) "최소", sum(salary) "합계", sum(salary) / count(salary) avg
from HR.employees;

-- 50인 부서의 사원의 수를 구하시오.
select employee_id, last_name, job_id, salary, department_id
from HR.employees
where department_id = 50;

select count(department_id), count(*)
from HR.employees
where department_id = 50;

-- commission_pct에 대해서 count함수를 사용하세요. -- null은 포함하지 않는다
select count(commission_pct), count(*)
from HR.employees;

-- 80인 부서의 직원수와 commission 을 받는 직원수를 출력하시오.
select count(*), count(commission_pct)
from HR.employees
where department_id = 80;

select commission_pct, department_id
from HR.employees
where department_id = 80;

-- 직원이 속해 있는 부서의 수는 distinct - 중복제거
select count(distinct department_id)
from HR.employees;

select count(department_id), department_id
from HR.employees
group by department_id;

-- 직원들의 평균 커미션을 구하시오
select sum(commission_pct), count(*) ,(sum(commission_pct) / count(*)) "평균", avg(nvl(commission_pct, 0))
from HR.employees;

/* *****************
* group function 는 null을 포함하지 않는다.
******************* */

-- 50인 부서의 급여 평균을 구하시오.
select avg(salary)
from HR.employees
where department_id = 50;

select trunc(avg(salary), 2), department_id
from HR.employees
group by department_id;

-- 직무별 급여의 평균과 합계 그리고 최대 값과 최소 값, 직원의 수를 출력하시오.
select avg(salary), sum(salary), max(salary), min(salary), count(*), job_id
from HR.employees
group by job_id;

-- 50인 부서의 부서번호와 직무를 출력하시오.
-- 직무를 내림차순으로 정렬하시오.

select department_id, job_id, sum(salary) "합계", avg(salary) "평균", count(*)
from HR.employees
--where department_id = 50
group by department_id, job_id
order by department_id, job_id;

-- 오류를 찾으시오 ... 그리고 설명하시오.
select department_id, count(last_name)
from HR.employees
group by department_id;

-- 각 부서의 최대 급여를 구하는데 직무가 'SA_REP'에 해당되는 것만 출력하시오.
select count(*), department_id, job_id, max(salary) "최대 급여"
from HR.employees
where job_id = 'SA_REP'
group by department_id, job_id
order by department_id, job_id;
-- 위 조건에서 최대 급여가 10000 이상인 것만 출력하시오. - group function 을 비교할 때 having 을 사용한다.
select count(*), department_id, job_id, max(salary) "최대 급여"
from HR.employees
where job_id = 'SA_REP'
group by department_id, job_id
having max(salary) >= 10000 
order by department_id, job_id;

-- 직무별 급여의 합계를 구하는데 직무에 REP가 포함되어 있는 것을 가져오고 
-- 급여에 합계가 13000 보다 커야 하며 급여의 합계를 오름차순으로 정렬하시오.
select job_id, sum(salary) sal
from HR.employees
where job_id like '%REP%'
group by job_id
having sum(salary) > 13000
order by sal;

-- 급여의 합계가 제일 많은 부서와 합계금액을 출력하시오.
select department_id, sum(salary)
from HR.employees
group by department_id
order by sum(salary) desc;

-- group function 안에 group functio 을 사용할 수 있다.
select max(sum(salary))
from HR.employees
group by department_id;

-- 문제) 사원번호, 성, 입사일을 출력하는데 각 사원이 소속되어있는 부서의 평균급여와
-- 직무의 평균급여 그리고 부서별 직무의 평균 급여를 출력하시오.
/*
select employee_id, last_name, hire_date
from HR.employees
group by x;
*/
select employee_id, last_name, hire_date,
avg(salary)over(partition by department_id) "부서별 평균 급여",
avg(salary)over(partition by job_id) "직무의 평균 급여",
avg(salary)over(partition by department_id, job_id) "부서별 직무의 평균"
from HR.employees;

-- Primary key(기본 키) : 중복값(x)
-- Foreign key(외래 키) : 부모 테이블에 있는 Primary key 컬럼에 있는 값 "만"을 가진다.

-- 문제) 사원테이블에 있는 사원번호, 이름, 입사일 을 출력하고 사원이 속해 있는 부서의 부서명을 출력하시오.
select * from HR.employees;
select * from HR.departments;
select employee_id, last_name, hire_date, department_name, d.department_id
from HR.employees e, HR.departments d
where e.department_id = d.department_id;