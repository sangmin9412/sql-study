-- ANSI JOIN
-- null 은 비교할 수 없다.

SELECT employee_id, department_id, manager_id
FROM HR.employees;

SELECT department_id, location_id, manager_id
FROM HR.departments;

-- natural JOIN
-- 이름이 같은 컬럼을 모두 비교 대상이 된다.
-- 부서(department_id)장을 상사(manager_id)로 두고있는 사원.
SELECT department_id, department_name, location_id, employee_id, manager_id
FROM HR.employees natural JOIN HR.departments;

-- 위 와 결과 값이 같다.
SELECT d.department_id, department_name, location_id, employee_id, e.manager_id
FROM HR.employees e JOIN HR.departments d
on e.department_id = d.department_id AND e.manager_id = d.manager_id;

-- 위 와 결과 값이 같다.
SELECT department_id, department_name, location_id, employee_id, manager_id
FROM HR.employees JOIN HR.departments
using (department_id, manager_id);

-- 두 테이블의 같은 이름의 컬럼이 location_id가 같으므로 location_id 만 조인 조건이 된다.
SELECT department_id, department_name, location_id, city
FROM HR.departments natural JOIN HR.locations;

SELECT department_id, department_name, d.location_id, city
FROM HR.departments d JOIN HR.locations l
on d.location_id = l.location_id;

-- using (NATURAL JOIN 과 유사하다)
-- 같은 이름의 컬럼만 비교가 가능하다.
-- 별칭을 쓸 수 없다
SELECT department_id, department_name, location_id, city
FROM HR.departments inner JOIN HR.locations
using (location_id);

SELECT employee_id, manager_id, last_name
FROM HR.employees;


-- inner JOIN 비교하고싶은 컬럼을 비교 on 에 비교할 컬럼을 작성할 수 있다
SELECT d.department_id, department_name, location_id, employee_id, e.manager_id
FROM HR.employees e JOIN HR.departments d
on e.department_id = d.department_id;



-- 중복데이터가 있다면 Foreign Key 없다면 Primary Key
SELECT *
FROM HR.departments;
SELECT *
FROM HR.locations;





-- ANSI JOIN과 T-SQL JOIN 비교
-- ANSI JOIN - A JOIN B on A = B
SELECT d.department_id, department_name, location_id, employee_id, e.manager_id
FROM HR.employees e JOIN HR.departments d
on e.department_id = d.department_id;

-- T-SQL JOIN
SELECT d.department_id, department_name, location_id, employee_id, e.manager_id
FROM HR.employees e , HR.departments d
WHERE e.department_id = d.department_id;

-- 문제) 사원번호가 120인 사원의 사원번호, 성, 급여, 부서번호, 부서명과 지역번호를 출력하시오.
SELECT employee_id, last_name, salary, e.department_id, department_name, location_id
FROM HR.employees e JOIN HR.departments d
on e.department_id = d.department_id
WHERE employee_id = 120; -- WHERE or AND

-- 문제) 101인 상사를 가지고 있는 사원의 사원번호, 성, 급여, 부서번호, 부서명을 출력하시오
SELECT e.employee_id, last_name, salary, e.department_id, department_name, e.manager_id
FROM HR.employees e JOIN HR.departments d
on e.department_id = d.department_id
WHERE e.manager_id = 101;

SELECT e.employee_id, last_name, salary, e.department_id, department_name, e.manager_id
FROM HR.employees e , HR.departments d
WHERE e.department_id = d.department_id
AND e.manager_id = 101;

-- 문제) 직원의 정보를 출력할 때 부서정보와 그 부서으 주소를 출력하는데 부서번호가 90인 직원만 출력하시오.
SELECT e.employee_id, e.last_name, e.job_id, e.manager_id, e.department_id, d.department_name, d.location_id
FROM HR.employees e JOIN HR.departments d
on e.department_id = d.department_id
WHERE e.department_id = 90;

SELECT e.employee_id, e.last_name, e.job_id, e.manager_id, e.department_id, d.department_name, d.location_id
FROM HR.employees e , HR.departments d
WHERE e.department_id = d.department_id
AND e.department_id = 90;

-- 문제) 직원정보를 출력하되 직원이 어느 부서에서 근무하는지 부서명을 출력하시오.
-- 성, 직원번호, 부서번호, 부서명, 지역코드
SELECT e.last_name, e.employee_id, e.department_id, d.department_name, d.location_id
FROM HR.employees e JOIN HR.departments d
on e.department_id = d.department_id;

SELECT e.last_name, e.employee_id, e.department_id, d.department_name, d.location_id
FROM HR.employees e , HR.departments d
WHERE e.department_id = d.department_id;

-- 문제) 같은 부서의 부서장을 상사로 둔 직원들의 리스트를 출력하는데 30, 50, 90인 부서만 출력
----- 질문
SELECT e.employee_id, e.last_name, d.manager_id, e.department_id, d.department_name, d.location_id
FROM HR.employees e JOIN HR.departments d
ON e.manager_id = d.manager_id
WHERE e.department_id in (30, 50, 90)
order by 1;

select distinct manager_id
from HR.employees;
select manager_id
from HR.departments;

select distinct department_id
from HR.employees;
select department_id
from HR.departments;
-----

-------------------------------------
SELECT e.employee_id, e.last_name, d.manager_id, e.department_id, d.department_name, d.location_id
FROM HR.employees e JOIN HR.departments d
ON e.department_id = d.department_id
AND e.manager_id = d.manager_id
WHERE e.department_id in (30, 50, 90);
-------------------------------------
SELECT e.employee_id, e.last_name, d.manager_id, e.department_id, d.department_name, d.location_id
FROM HR.employees e , HR.departments d
WHERE e.department_id = d.department_id
AND e.manager_id = d.manager_id
AND e.department_id in (30, 50, 90);

-- 'REP'가 포함된 직무를 가진 사원의 사원번호와 성, 직무, 부서번호, 부서명, 부서장번호를 출력하시오. 
SELECT e.last_name, e.job_id, e.department_id, d.department_name, d.manager_id
FROM HR.employees e JOIN HR.departments d
ON e.department_id = d.department_id
WHERE e.job_id like '%REP%';

SELECT e.last_name, e.job_id, e.department_id, d.department_name, d.manager_id
FROM HR.employees e , HR.departments d
WHERE e.department_id = d.department_id
AND e.job_id like '%REP%';

-- 부서 정보를 출력할 떄 부서의 주소도 모두 출력하시오.
-- 부서 : departments, 주소 정보 : locations
-- 부서번호, 부서명, 부서장번호
-- COUNTRY_ID, CITY, STREET_ADDRESS, location_id
SELECT d.department_id, d.department_name, d.manager_id, l.country_id, l.city, l.street_address, l.location_id
FROM HR.departments d JOIN HR.locations l
ON d.location_id = l.location_id;

-- 직원이 속해있는 부서의 주소정보를 출력하자.
-- 사원번호, 성
-- 부서번호, 부서명, 부서장
-- contry_id, city, street_address, location_id
SELECT e.employee_id, e.last_name, e.department_id, d.department_name, d.manager_id,
        l.country_id, l.city, l.street_address, l.location_id
FROM HR.employees e JOIN HR.departments d
ON e.department_id = d.department_id JOIN HR.locations l
ON d.location_id = l.location_id;

SELECT e.employee_id, e.last_name, e.department_id, d.department_name, d.manager_id,
        l.country_id, l.city, l.street_address, l.location_id
FROM HR.employees e , HR.departments d , HR.locations l
WHERE e.department_id = d.department_id
AND d.location_id = l.location_id;

-- 위 문제 에서 부서번호가 90인 직원만 출력하시오.
SELECT e.employee_id, e.last_name, e.department_id, d.department_name, d.manager_id,
        l.country_id, l.city, l.street_address, l.location_id
FROM HR.employees e JOIN HR.departments d
ON e.department_id = d.department_id JOIN HR.locations l
ON d.location_id = l.location_id
where e.department_id = 90;

-- 직무 정보에 대해서 출력하시오
SELECT *
FROM HR.jobs;
-- job_id : Primary Key
-- 사원정보
SELECT *
FROM HR.departments;
-- department_id : Primary Key
SELECT *
FROM HR.employees;
-- employee_id : Primary Key
-- job_id : Foreign Key
-- department_id : Foreign Key
-- 부서정보

SELECT j.job_title, e.employee_id, e.last_name, d.department_name, l.street_address
FROM HR.jobs j 
JOIN HR.employees e
ON j.job_id = e.job_id 


JOIN HR.departments d
ON e.department_id = d.department_id
JOIN HR.locations l
ON d.location_id = l.location_id;

SELECT j.job_title, e.employee_id, e.last_name, d.department_name, l.street_address
FROM HR.jobs j , HR.employees e , HR.departments d, HR.locations l
WHERE j.job_id = e.job_id
AND e.department_id = d.department_id
AND d.location_id = l.location_id;


-- 문제) 부서가 20이거나 50인 부서의 사원번호와 부서번호 및 부서명 그리고 위치정보를 출력하시오.
SELECT e.employee_id, e.department_id, d.department_name, d.location_id
FROM HR.employees e JOIN HR.departments d
ON e.department_id = d.department_id
WHERE e.department_id in (20, 50);

SELECT e.employee_id, e.department_id, d.department_name, d.location_id
FROM HR.employees e , HR.departments d
WHERE e.department_id = d.department_id
AND e.department_id in (20, 50);

-- 문제) Matos라는 성을 가지고 있는 사원이 있다. 이 사원의 부서정보와 사원번호 그리고 성을 출력하시오.
SELECT e.department_id, d.department_name, e.employee_id, e.last_name
FROM HR.employees e JOIN HR.departments d
ON e.department_id = d.department_id
WHERE e.last_name = 'Matos';

SELECT e.department_id, d.department_name, e.employee_id, e.last_name
FROM HR.employees e , HR.departments d
WHERE e.department_id = d.department_id
AND e.last_name = 'Matos';

-- 문제) Matos라는 성을 가지고 있는 사원과 King라는 성을 가진 사원이 있다.
-- 이 사원의 부서정보와 사원번호 그리고 성을 출력하시오.
SELECT e.department_id, d.department_name, e.employee_id, e.last_name
FROM HR.employees e JOIN HR.departments d
ON e.department_id = d.department_id
WHERE e.last_name in ('Matos', 'King');

SELECT e.department_id, d.department_name, e.employee_id, e.last_name
FROM HR.employees e , HR.departments d
WHERE e.department_id = d.department_id
AND e.last_name in ('Matos', 'King');

-- 문제) King 이라는 성을 가지고 있는 사원이 있다.
-- 이 사원의 부서정보와 사원번호 그리고 성을 출력하시오.
SELECT e.department_id, d.department_name, e.employee_id, e.last_name
FROM HR.employees e , HR.departments d
WHERE e.department_id = d.department_id
AND e.last_name = 'King';

-- 문제) 부서테이블에서 부서번호와 부서명 그리고 지역코드 와 지역명을 출력하는데 지역코드가 1400인 지역만 출력
SELECT d.department_id, d.department_name, d.location_id, l.street_address, l.city
FROM HR.departments d JOIN HR.locations l
ON d.location_id = l.location_id
WHERE d.location_id = 1400;

-- 문제) 사원이 하고 있는 직무 이름과 사원의 부서명을 출력하는데 사원의 사원번호 이름도 출력하시오.
-- 단, 'SA'를 포함하고 있는 직무와 '2005'년에 입사한 사원만 출력하시오.
SELECT j.job_id ,j.job_title, d.department_name, e.employee_id, e.first_name, e.hire_date
FROM HR.jobs j JOIN HR.employees e 
ON j.job_id =  e.job_id JOIN HR.departments d
ON e.department_id = d.department_id
WHERE e.job_id LIKE '%SA%' AND to_char(e.hire_date, 'yyyy') = 2005;

-- 자기참조 관계
-- 문제) 104번 상사의 직원정보를 출력하시오.
SELECT e.employee_id, e.last_name, e.hire_date
FROM HR.employees e JOIN HR.employees m
ON e.employee_id = m.manager_id
WHERE m.employee_id = 104;

-- 문제) 직원이름과 직원의 상사 이름을 출력하시오.
SELECT e1.first_name, e2.manager_id
FROM HR.employees e1 JOIN HR.employees e2
ON e1.manager_id = e2.employee_id;

-- 문제) 부서가 없는 사원을 출력하시오.
SELECT *
FROM HR.employees
where department_id is null;

-- 문제) 직원에 대한 부서정보를 출력하시오.
-- 직원 : 사원번호, 성, 급여
-- 부서정보 : 부서번호, 부서이름
SELECT e.employee_id, e.last_name, e.salary, e.department_id, d.department_name
FROM HR.employees e JOIN HR.departments d
ON e.department_id = d.department_id
WHERE e.employee_id = 178;

-- {LEFT,RIGHT} OUTER JOIN (null값도 포함할 경우)
-- 문제) 직원에 대한 부서정보를 출력하는데 부서가 없는 직원도 출력되게 하시오.
-- 직원 : 사원번호, 성, 급여
-- 부서정보 : 부서번호, 부서이름
SELECT e.employee_id, e.last_name, e.salary, e.department_id, d.department_name
FROM HR.employees e LEFT OUTER JOIN HR.departments d
--FROM HR.departments d RIGHT OUTER JOIN HR.employees e
ON e.department_id = d.department_id
WHERE e.employee_id = 178;

-- null이 출력되는 곳에 (+)
SELECT e.employee_id, e.last_name, e.salary, e.department_id, d.department_name
FROM HR.employees e , HR.departments d
WHERE e.department_id = d.department_id(+)
AND e.employee_id = 178;

-- 문제) 직원정보와 부서정보를 출력할 때 모든부서가 나올 수 있도록하자. 사원이 없는 부서정보도 출력
SELECT e.employee_id, e.last_name, e.salary, e.department_id, d.department_name
FROM HR.employees e RIGHT OUTER JOIN HR.departments d
ON e.department_id = d.department_id;

SELECT e.employee_id, e.last_name, e.salary, e.department_id, d.department_name
FROM HR.employees e , HR.departments d
WHERE e.department_id(+) = d.department_id;

-- FULL OUTER JOIN
-- 문제) 부서가 없는 직원과 직원이 없는 부서 모두 출력하시오.
SELECT e.employee_id, e.last_name, e.salary, e.department_id, d.department_name
FROM HR.employees e FULL OUTER JOIN HR.departments d
ON e.department_id = d.department_id;



SELECT distinct manager_id
FROM HR.employees;

SELECT distinct e.employee_id, e.last_name, m.manager_id --, m.employee_id
FROM HR.employees e JOIN HR.employees m
ON e.employee_id = m.manager_id
--WHERE m.employee_id = 104
order by 1
;

-- 104번 상사의 직원 정보를 구하시오.
/*
HR.employees m 을 Primary manager_id 를 갖고있는 managers 테이블 이라고 생각하고
HR.employees e 의 employee_id 와 manager_id 를 비교하여 HR.employees e 에 HR.employees m 의 값을 대입하고
HR.employees m 의 employee_id 값으로 WHERE m.employee_id = 104를 할 경우 104 직원 상사의 직원정보를 얻을 수 있다.

*/ 
SELECT e.employee_id, e.last_name, m.manager_id, m.employee_id
FROM HR.employees e JOIN HR.employees m
ON e.employee_id = m.manager_id
--WHERE m.employee_id = 104
order by 1
;


-- 문제) 104번의 상사의 직원 정보를 구하시오. (서브 쿼리)
SELECT employee_id, last_name, hire_date
FROM HR.employees
where employee_id = (
    SELECT manager_id FROM HR.employees where employee_id = 104
);