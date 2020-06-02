-- lower = 소문자로 변경, upper = 대문자로 변경
-- 사원들 중 higgins 라는 사원을 출력하시오.
select *
from HR.employees
where lower(last_name) = 'higgins';

select last_name, lower(last_name), upper(last_name)
from HR.employees;

-- 성과 이름을 붙여서 출력하시오. 급여와 직무도 같이 출력하시오.
select last_name || first_name name, salary, job_id
from HR.employees;
select concat(last_name, first_name) name, salary, job_id
from HR.employees;

-- 성과 이름을 붙여서 출력하시오. 급여와 직무도 같이 출력하시오.
select last_name, first_name, length(first_name)
from HR.employees;

-- substr(String = 문자열 값, Number = 자를 길이, Number = 비교할 길이);
-- 사원번호와 이름, 직무, 급여를 출력하는데 직무의 4번째글자가 REF로
-- 시작하는 사원을 구하시오.
select employee_id, first_name, job_id, salary
from HR.employees
where substr(job_id, 4) = 'REP';
--where job_id like '___REP%';

-- 직무에 4번째 부터 2글짜가 PR인 직원을 출력하시오.
select *
from HR.employees
where substr(job_id, 4, 3) = 'PRO';

-- 사원번호와 급여, 직무를 출력하는 데 직무는 4번째부터 3글짜만 출력하시오
select employee_id, salary, job_id, substr(job_id, 4, 3)
from HR.employees;

-- 사원번호와 급여, 직무를 출력하는 데 직무를 뒤에서 3글자부터 2글자 출력하시오.
select employee_id, salary, job_id, substr(job_id, -3, 2)
from HR.employees;

-- 직무가 뒤에서 3글자부터 2글자가 RE인 사원들을 출력하시오.
select *
from HR.employees
where substr(job_id, -3, 2) = 'RE';

-- instr
-- 이름에 s라는 글자가 있는 경우 몇번째인지 출력하시오. (indexOf()) first_name.indexOf('s') = 자바 Syntax
select first_name, instr(first_name, 's')
from HR.employees;

-- 이름에 's'가 6번째에 있는 사원을 출력하시오.
select *
from HR.employees
where instr(first_name, 's') = 6;

-- 사원번호, 성 이름, 직무, 이름의 길이, 그리고 성에 'a'가 있는 위치를 출력하는데 직무에 4번째 글자부터 3글자가 'REP'인 사원만 출력하시오
select employee_id, last_name || ' ' || first_name name, job_id, length(first_name), instr(last_name, 'a')
from HR.employees
where substr(job_id, 4, 3) = 'REP';


-- 사원번호, 성, 직무, 급여를 출력하는데 급여에 1234를 더한 후 1000으로 나눈 값을 출력하시오.
select employee_id, last_name, job_id, (salary + 1234) / 1000
from HR.employees;
-- 반올림 round() 5 이상은 반올림
-- 위 내용에서 출력된 급여를 소숫점 두자만 출력되게 하시오.
select employee_id, last_name, job_id, 
(salary - 1235) / 1000, 
round((salary - 1235) / 1000, 2), 
round((salary - 1235) / 1000, 1),
round((salary - 1235) / 1000, 0),
round((salary - 1235) / 1000, -1) -- 1의 자리
from HR.employees;

-- 테이블이 없는 상황에서 값을 출력하고 싶을 경우 from dual;
select round(45.923, 2), 
round(45.9234, 0), 
round(45.923, -1),
round(45.923, -2)
from dual;

select '이숭무' 
from dual;

-- 절삭 trunc() 반올림 x
select trunc(45.925, 2), 
trunc(45.9234, 0), 
trunc(45.923, -1),
trunc(45.923, -2)
from dual;

-- 나머지 구하기 mod(값, 비교할 값)
-- 성과 급여를 출력하는데 급여를 5000으로 나눈 나머지도 같이 출력하시오.
-- 단, 직무가 'SA_REP'인 사원만 출력하시오.
select last_name, salary, mod(salary, 5000)
from HR.employees
where job_id = 'SA_REP';


-- 날짜
-- 현재 날짜 출력 (new Date())
select sysdate
from dual;

