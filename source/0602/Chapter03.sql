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

-- 입사일이 2007년 01월 01일보다 이전인 직원들을 출력하시오.
select *
from HR.employees
where hire_date < '07/01/01';

-- to_date()
select *
from HR.employees
where hire_date < to_date('01/01/07', 'DD/MM/YY');

-- 사원번호, 직무, 입사일을 출력하는데 사원들이 입사일로 부터 몇 주가 되었는지 같이 출력하시오.
select employee_id, job_id, hire_date, (sysdate - hire_date) / 7
from HR.employees;

-- 입사한지 몇 달이 되었는지 출력하시오. - months_between
select employee_id, job_id, hire_date, months_between(sysdate, hire_date)
from HR.employees;

-- 입사이후 6개월이 된 날짜는 언제입니까?
-- 사원번호, 직무, 입사일
select employee_id, job_id, hire_date, add_months(hire_date, 6)
from HR.employees;

select hire_date, sysdate - 14
from HR.employees;

-- 오늘 날짜에서 14일 전에 입사한 직원은?
select *
from HR.employees
where hire_date = sysdate - 14;

-- 입사일로부터 다음 금요일은 몇일 입니까?
select employee_id, job_id, hire_date, next_day(hire_date, '금요일') 
from HR.employees;

-- 달의 마지막날을 출력
-- 입사한 달의 마지막 날은 언제입니까?
select employee_id, job_id, hire_date, last_day(hire_date)
from HR.employees;

-- 입사일로 부터 36개월이 지난 사원들을 출력하시오.
select *
from HR.employees
where months_between(sysdate, hire_date) > 36; -- 월

select *
from HR.employees
where sysdate - hire_date > 36; -- 일

-- 입사일로 부터 며칠이 지났는지 구하시고.
select trunc(sysdate - hire_date)
from HR.employees;

-- 사원번호, 직무, 입사일을 출력하는데 입사일을 년 4자리로 출력하시오.
-- 날짜 표기를 yyyy-mm-dd
-- to_char(data, 'yyyy-mm-dd hh mi ss am') = 날짜를 원하는 형태의 문자로 바꿀때 사용
select employee_id, job_id, hire_date, to_char(hire_date, 'yyyy-mm-dd hh : mi : ss am')
from HR.employees;

select sysdate, to_char(sysdate, 'yyyy-mm-dd hh : mi : ss am')
from dual;

-- 사원번호 직무 급여를 출력하는데 급여 앞에 $를 붙이고 세자리마다 , 를 찍어서 출력하시오.
select employee_id, job_id, salary, to_char(salary, '$999,999'), to_char(salary, 'L999,999'), to_char(salary, 'L999,999mi')
from HR.employees;

-- 날짜가 10-10-2002 이후에 입사한 직원을 출력하시오.
select *
from HR.employees
where to_char(hire_date, 'dd-mm-yyyy') > '10-10-2002';

select *
from HR.employees
where hire_date > to_date('10-10-2002', 'dd-mm-yyyy');


-- 일반 함수 : NVL(Null Value), NVL2, NULLIF
select *
from HR.employees;
-- 사원번호, 직무, 커미션을, 포함한 급여를 출력하시오.
select employee_id, job_id, salary + salary * nvl(commission_pct, 0)
from HR.employees;

-- 사원번호, 직무, 연봉을 구하시오
select employee_id, job_id, salary * (1 + nvl(commission_pct, 0)) * 12
from HR.employees;

select employee_id, job_id, nvl2(commission_pct, salary + salary * commission_pct, salary)
from HR.employees;

--select nvl2(null, 'not null', 'null')
--from dual;

-- 많이 사용하는 방법
select employee_id, job_id, nvl2(commission_pct, 'sal+comm', 'sal')
from HR.employees;

-- 조건 표현식
-- 직무가 'IT_PROG' 일 때 급여에 1.1배를 하고
-- 직무가 'ST_CLERK' 일 때 급여에 1.15배를 하고
-- 직무가 'SA_REP' 일 때 급여에 1.2배를 한다.
-- 나머지 직원은 급여만 지급한다.
-- 사원번호, 급여, 직무, 조건에 따른 값
select employee_id, salary, job_id,
    case job_id when 'IT_PROG' then 1.10 * salary
                when 'ST_CLERK' then 1.15 * salary
                when 'SA_REP' then 1.20 * salary
    else salary end sal, hire_date
from HR.employees;

select employee_id, salary, job_id,
    decode( job_id  , 'IT_PROG', 1.10 * salary
                    , 'ST_CLERK', 1.15 * salary
                    , 'SA_REP', 1.20 * salary
    , salary ) sal, hire_date
from HR.employees;

-- 급여가 10000이상이면 "이사"
--          7000이상 "부장"
--          5000이상 "과장"
--          나머지는 "사원"
--      성과 급여를 같이 출력한다.
select last_name, salary, job_id,
    case when salary >= 10000 then '이사'
        when salary >= 7000 then '부장'
        when salary >= 5000 then '과장'
    else '사원' end "직급"
from HR.employees;

-- 문제) 급여를 2000으로 나눈 값의 몫이
--        0이면 0.00
--        1이면 0.09
--        2이면 0.20
--        3이면 0.30
--        4이면 0.40
--        5이면 0.42
--        6이면 0.44
--              0.45 만큼 세금이 부여된다.
-- 부여되는 세금을 출력하시오.
-- 성과 급여도 같이 출력하시오. (단, 부서가 80인 사원만)
-- decode 를 사용하시오.
select last_name, salary, trunc(salary / 2000) "나눈 값",
    decode (
        trunc(salary / 2000),0 , salary * 0.00
                            ,1 , salary * 0.09
                            ,2 , salary * 0.20
                            ,3 , salary * 0.30
                            ,4 , salary * 0.40
                            ,5 , salary * 0.42
                            ,6 , salary * 0.44
                                , salary * 0.45
    ) "세금", department_id
from HR.employees
where department_id = 80;
