--문제) 사원테이블에서 직무에 MAN를 포함하고 급여가 10000이상인 
--사원을 사원번호와 성과 직무 그리고 급여를 출력하시오.

select employee_id, last_name, job_id, salary
from HR.employees
where job_id like '%MAN%' and salary >= 10000;


--문제) 직무가 SA_REP와 AD_PRES 이면서 급여가 15000을 초과하는 
--사원을 출력하시오.
--단, 성, 직무, 급여만 출력 or와 and만 사용

select last_name, job_id, salary
from HR.employees
where (job_id = 'SA_REP' or job_id = 'AD_PRES') and salary > 15000;


--정렬
--select last_name , hire_date
--from hr.employees
--order by hire_date;
--
--문제) 직원테이블에서 부서를 오름차순으로 정렬하여 출력하시오.
--부서번호 , 급여, 입사일, 성

select department_id, salary, hire_date, last_name
from HR.employees
order by department_id;



--부서는 내림차순으로 정렬하고 입사일도 내림차순으로 정렬
--부서번호 , 급여, 입사일, 성

select department_id, salary, hire_date, last_name
from HR.employees
order by department_id desc, hire_date desc;

--부서는 내림차순으로 정렬하고 입사일은 오름차순으로 정렬하여 출력
--부서번호 , 급여, 입사일, 성

select department_id, salary, hire_date, last_name
from HR.employees
order by department_id desc, hire_date;

--부서는 내림차순으로 정렬하고 입사일은 오름차순으로 정렬하여 
--급여를 내림차순으로 정렬하여 출력
--부서번호 ,  입사일, 급여, 성

select department_id, salary, hire_date, last_name
from HR.employees
order by department_id desc, hire_date, salary desc;

--문자함수
--Lower, Upper, initcap, concat, substr
--
--select last_name, lower(last_name) , hire_date
--from hr.employees
--where lower(last_name) = 'grant';
--
--
--문제) 모두 소문자인 grant와 모두 

select *
from HR.departments;

--문제) 'GranT'로 입력했을때 사원테이블에서 'Grant'를 찾으시오.

select *
from HR.employees
where lower(last_name) = lower('GranT');

--문제) 성은 모두 대문자로 변환하고 이름 모두 소문자 변환하여
--성과 이름을 붇여 출려할 때 ' 나는 GRANT douglas 입니다'로 
--출력되게 하시오.

select '나는 ' || upper(last_name) || ' ' || lower(first_name) || ' 입니다' "아"
from HR.employees;

---- concat
--문제) 성과 이름을 붙여 출력

select concat(last_name, first_name) "concat"
from HR.employees;

--문제) 성은 모두 대문자로 변환하고 이름 모두 소문자 변환하여
--성과 이름을 붇여 출려할 때 ' 나는 GRANT douglas 입니다'로 
--출력되게 하시오. concat을 이용

select concat('나는 ' || upper(last_name),  ' ' || lower(first_name) ||' 입니다') "아"
from HR.employees;

--String str = "abcdefghi";
--String result = str.subString(2, 6); cdef'
--String result = str.subString(2);
--
--
--
--문제) 성이 Davies에서 av만 출력하시오.

select substr(last_name, 2, 2)
from HR.employees
where last_name = 'Davies';

--문제)성이 두번째 글짜부터 모두 출력하시오.

select substr(last_name, 2)
from HR.employees;

--문제) 성의 마직막 글자에서 두글짜만 가져오시오.

select last_name, substr(last_name, -2, 2)
from HR.employees;

--문제) 성의 뒤에 on으로 끝나는 사람을 찾으시오.
select last_name, substr(last_name, -2, 2)
from HR.employees
where substr(last_name, -2, 2) = 'on';

--문제) 성의 뒤에 세번째 글자가 so인 사람을 출력하시오.
select last_name, substr(last_name, -3, 2)
from HR.employees
where substr(last_name, -3, 2) = 'so';


--문제) 직원 정보를 출력하는데 이메일은 왼쪽에서 3글자만 출력하시오.
--직원번호, 성, 급여, 직무

select department_id, last_name, salary, job_id, email, substr(email, 0, 3)
from HR.employees;


--문제) 직원 정보를 출력하는데 이메일은 오른쪽에서 3글자만 출력하시오.
--직원번호, 성, 급여, 직무
select department_id, last_name, salary, job_id, email, substr(email, -3, 3)
from HR.employees;


--문제) 틀린 곳을 찾고 이유를 말하시오.
--
--String strnn = 'abcdefg'; 
--str = 'abcdefg'; String 이 잘못 됐나봄
--int i = str.indexOf("f");  //5

--문제) o가 있는 성중 o가 몇번째에 있는 위치를 출력하시오.
--직원번호 성, 성의 위치, 직무

select last_name, instr(last_name, 'o')
from HR.employees
where last_name like '%o%';

--/*
--instr(last_name,'oc') : 원하는 문자가 없으면 0을 반환
--instr('abcde' , 'a') : 1
--자바에서 "abcdef".indexOf("a") : 0
--*/
--
--
--문제) 직무에 RE가 있는 경우 RE부터 3글자만 출력하시오.
--직원번호 성,  직무, 가공된 직무

select job_id, substr(job_id, instr(job_id, 'RE'), 3), instr(job_id, 'RE')
from HR.employees
where job_id like '%RE%';

--문제) 직원번호, 성, 입사일 , 급여, 급여앞에 * 표시가 되게 하자.

select department_id, last_name, hire_date, salary, lpad(salary, length(salary)+1, '*')
from HR.employees;


--문제) 직원번호, 성, 입사일, 직무를 출력하는데 직무에 RE가 있다면
--RE를 AB로 변경하여 출력

select department_id, last_name, hire_date, job_id, replace(job_id, 'RE', 'AB')
from HR.employees;

--/*
--select trim(' ' from ' ab cd ef ') 
--from dual;
--
--select trim('a' from 'abada')
--from dual;
--
--select round(45.923, 2), round(45.924, 2), round(45.925, 2),
--       round(45.926, 2)
--from dual;
--
--
--select trunc(45.923, 2), trunc(45.924, 2), trunc(45.925, 2),
--       trunc(45.926, 2)
--from dual;
--
--select  round(45.925, 2),round(45.925, 1), round(45.925),
--	round(45.925, -1), round(45.925, -2)
--from dual;
--
--
--select  trunc(45.925, 2), trunc(45.925, 1), trunc(45.925),
--	trunc(45.925, -1), trunc(45.925, -2)
--from dual;
--
--
--select mod(10,3)
--from dual;
--*/
--
--문제) 직원번호, 연락처, 커미션, 부서번호,급여
--급여를 3000으로 나누었을 때의 나머지를 출력하시오.

select employee_id, phone_number, commission_pct, department_id, salary, mod(salary, 3000)
from HR.employees;

--문제) 2003년도부터 입사한 직원들을 출력하시오.
select *
from HR.employees
where hire_date > '03/01/01';

--문제) 올해는 오늘까지 몇주가 지났는지 확인하시오.
select sysdate, to_date('20200101', 'yyyymmdd'), (sysdate - to_date('20200101', 'yyyymmdd')) ,trunc((sysdate - to_date('20200101', 'yyyymmdd')) / 7, 2)
from dual; -- 값 이 좀 이상함.

--문제) 직원마다 몇년 근무했지를 출력하시오.
--직원번호, 성, 연락처,부서, 근무년수
select employee_id, last_name || first_name name, department_id, hire_date, trunc((sysdate - hire_date) / 365) "근무년수"
from HR.employees
order by "근무년수" desc;


--문제) 근속년수 15년 이상인 사원들만 출력하시오.
select employee_id, last_name, department_id, hire_date, trunc((sysdate - hire_date) / 365) "yeyeye"
from HR.employees
where trunc((sysdate - hire_date) / 365) >= 15;
