select * from hr.employees;

--포함하는 
select * from hr.employees
where last_name like '%o%' or email like '%o%';

-- 시작하는
-- 문제 'A'로 시작하는 이름을 출력하시오.
select * from hr.employees
where first_name like 'A%';
-- 끝나는
--문제 이름이 'a'로 끝나는 사원을 검색하시오.
select * from hr.employees
where first_name like '%a';

-- 2002년도에 입사한 사원들을 출력하시오.
select * from hr.employees
where hire_date like '02%';

-- 두번째 글자에 'o'가 이름에 포함된 사원을 출력하시오.
select * from hr.employees
where first_name like '_o%';

-- 세번째 글자에 'o'가 포함되어 있는 사원을 출력하시오.
select * from hr.employees
where first_name like '__o%';

-- 뒤에서 이름에 두번째에 'o'가 포함되어 있는 사원을 출력하시오.
select * from hr.employees
where first_name like '%o_';

-- 이름과 이메일에 sa가 포함된 사원을 출력하시오.
select * from hr.employees
where first_name like '%sa%' or email like '%sa%';

select  last_name, job_id, commission_pct
from hr.employees;

-- 커미션을 받지 못하는 사원 출력하시오.
select * from hr.employees
where commission_pct is null;

-- 커미션을 받는 사원 출력하시오.
select * from hr.employees
where commission_pct is not null;
-- 부서가 없는 사원을 출력하시오.
select * from hr.employees
where department_id is null;

-- and | or
-- 급여가 10000이거나 직무가 MAN을 포함하고 있는 사원을 출력하시오.
select * from hr.employees
where salary = 10000 or job_id like '%MAN%';

-- 급여가 15000이상이면서 직무가 'SA_REP'이거나 'Ad_PRES'인 
-- 사원을 출력하시오.
select * from hr.employees
where salary >= 15000 and (job_id = 'SA_REP' or job_id = 'Ad_PRES'); 

select * from hr.employees
where salary >= 15000 and job_id in( 'SA_REP', 'Ad_PRES');

-- 부서가 30이고 60인 부서에서 급여가 10000이상인 사원들을 출력하시오.
select * from hr.employees
where (department_id = 30 or department_id = 60)
and salary >= 10000;

-- 정렬
--- 이름을 오름차순으로 정렬하여 출력
select * from hr.employees
order by first_name ;

-- 입사일이 빠른 사원부터 출력하시오.
select * from hr.employees
order by hire_date asc;

-- 최근에 입사한 사원부터 출력하시오.
select * from hr.employees
order by hire_date desc;
-- table 정보 확인
DESCRIBE HR.employees;

-- 사원번호, 성, 년봉을 출력하는데 년봉을 ansal로 출력하시오.
select employee_id, last_name, salary * 12 ansal
from hr.employees;
-- 위 내용에서 년봉을 오름차순으로 출력하시오.
select employee_id , last_name, salary * 12 ansal
from hr.employees
order by ansal; -- 정렬시에 별칭을 사용할 수 있다.
select employee_id , last_name, salary * 12 ansal
from hr.employees
order by 3;

-- 부서를 오름차순으로 정렬하고
-- 같은 부서의 사원들의 급여를 내림사순으로 정렬하시오 
select * from hr.employees
order by department_id asc, salary desc;

-- 50인부서의 사원들을 직무를 내림차순으로 정렬하고 
-- 직무에 대한 급여를 오름 차순으로 정렬하시오.
select * 
from hr.employees
where department_id = 50
order by job_id desc, salary asc;
-- 급여가 10000이 아닌 사원들을 출력하시오.
select * from hr.employees
where salary != 10000;
-- where salary ^= 10000;
-- where salary <> 10000;

-- 직무가 'SA_REP', 'Ad_PRES'에 속해있지 않은 사원들을 출력하시오.
select * from hr.employees
where job_id not in ('SA_REP','Ad_PRES');
select * from hr.employees
where job_id != 'SA_REP' and job_id != 'Ad_PRES';

-- 문제 사원의 급여가 3000보다 작고 10000보다는 큰 사원을 출력하시오.
select * from hr.employees
where salary not between 3000 and 10000;


-- 사원들 중 Higgins라는 사원을 출력하시오.
select * from HR.employees
where last_name = 'Higgins';

-- 사원들 중 higgins라는 사원을 출력하시오.
select * from HR.employees
where lower(last_name) = 'higgins';

select last_name , lower(last_name) from hr.employees;

-- 성과 이름을 붙여서 출력하시오. 급여와 직무도 같이 출력하시오.
select last_name || first_name name , salary, job_id
from hr.employees;
select concat(last_name , first_name) name , salary, job_id
from hr.employees;

-- 성과 이름을 출력하는데 이름의 길이를 같이 출력하시오.
select last_name, first_name, length(first_name)
from HR.employees;

-- 사원번호와 이름 , 직무, 급여를 출력하는데 직무의 4번째글짜가 REF로
-- 시작하는 사원을 구하시오.
select employee_id, first_name, job_id, salary
from hr.employees
where job_id like '___REP';

select employee_id, first_name, job_id, salary
from hr.employees
where substr(job_id,4) = 'REP%';

-- 직무에 4번재 부터 3글짜가 PRO인 직원을 출력하시오.
select * from hr.employees
where substr(job_id,4,3) = 'PRO';

-- 사원번호와 급여, 직무를 출력하는 데 직무는 4번째부터 3글짜만 출력하시오.
select employee_id, salary, job_id, substr(job_id,4,3)
from hr.employees;

-- 사원번호와 급여, 직무를 출력하는 데 
-- 직무를 뒤에서 3글짜부터 2글짜도 출력하시오.
select employee_id, salary, job_id, substr(job_id, -3, 2)
from hr.employees;

-- 직무가 뒤에서 3글짜부터 2글짜가 RE인 사원들을 출력하시오.
select * from hr.employees
where substr(job_id,-3,2) = 'RE'; 

-- 이름에 s라는 글짜가 있는 경우 몇번째인지 출력하시오.(indexOf())
select first_name, instr(first_name,'s')
from hr.employees;
--- firstName.indexOf('s') // 자바스타일
--이름에 's'가 6번째에 있는 사원을 출력하시오.
select * from HR.employees
where instr(first_name,'s') = 6;

-- 사원번호, 성, 이름, 직무, 이름의 길이 그리고 성에 'a'가 있는 위치를
-- 출력하는데  직무에 4번째 글짜부터 3글짜가 'REP'인 사원만 출력하시오.
select employee_id, last_name, first_name, length(first_name),
instr(last_name,'a')
from hr.employees
where substr(job_id,4,3) = 'REP';

select * from hr.employees;
-- 사원번호, 성, 직무, 급여를 출력하는데 급여에 1234를 뺀한 후 1000으로
-- 나눈 값을 출력하시오.
select employee_id, last_name, job_id, (salary-1234)/1000
from hr.employees;
--위 내용에서 출력된 급여를 소숫점 두자만 출력하게 하시오.
--반올림
select employee_id, last_name, job_id, 
        (salary-1235)/1000, round((salary-1235)/1000, 2),
        round((salary-1235)/1000, 1), 
        round((salary-1235)/1000, 0),
        round((salary-1235)/1000, -1)
from hr.employees;

SELECT ROUND(45.923,2), ROUND(45.923,0),
       ROUND(45.923,-1),ROUND(45.923,-2)
FROM   DUAL;

--절삭 trunc
SELECT trunc(45.925,2), trunc(45.923,0),
       trunc(45.923,-1),trunc(45.923,-2)
FROM   DUAL;

-- 성과 급여를 출력하는데 급여를 5000으로 나눈 나머지도 같이 출력하시오.
-- 단, 직무가 'SA_REP'인 사원만 출력하시오.
select last_name, salary, mod(salary, 5000)
from hr.employees
where job_id= 'SA_REP';


-- 날짜 
-- 현재 날짜 출력 (new Date()) System.out.println(new Date());
select sysdate from dual;
--
-- 입사일이 2007년 01월 01일보다 이전인 직원들을 출력하시오.
select * from hr.employees
where hire_date < '07/01/01';
select * from hr.employees
where hire_date < to_date('01/01/07','DD/MM/YY');

-- 사원번호, 직무 입사일을 출력하는데 
-- 사원들이 입사일로 부터 몇주가 되었는지 같이 출력하시오.
select employee_id, job_id, hire_date, (sysdate-hire_date) /7
from hr.employees;

-- 몇년이 되었는지 출력하시오.
select employee_id, job_id, hire_date, (sysdate-hire_date) /365
from hr.employees;

-- 입사한지 몇달이 되었는지 출력하시오.
-- 사원번호, 직무, 입사일, 몇달
select employee_id, job_id, hire_date, 
        months_between(sysdate,hire_date)
from hr.employees;

-- 입사이후 6개월이 된 날짜는 언제입니까?
-- 사원번호, 직무, 입사일
select employee_id, job_id, hire_date, add_months(hire_date,6)
from hr.employees;

select hire_date, sysdate - 14
from hr.employees;

-- 오늘 날짜에서 14일 전에 입사한 직원은?
select * from hr.employees
where hire_date = sysdate - 14;

-- 입사일로부터 다음 금요일은 몇일 입니까.?
select employee_id, job_id, hire_date, 
       next_day(hire_date,'금요일')
from hr.employees;

-- 달의 마지막날을 출력
-- 입사한 달의 마지막 날은 언제입니까.
select employee_id, job_id, hire_date, last_day(hire_date)
from hr.employees;

-- 입사일로 부터 36개월이 지난 사원들을 출력하시오.
select * 
from hr.employees
where months_between(sysdate, hire_dated) > 36;
-------
select * from hr.employees
where sysdate - hire_date > 36; -- 일

-- 입사일로 부터 몇일이 지났는지 구하시오.
select sysdate - hire_date
from hr.employees;

--- 사원번호, 직무, 입사일을 출력하는데 입사일을 년4자리로 출력하시오.
-- 날짜 표기를 yyyy-MM-DD
select employee_id, job_id, hire_date, 
        to_char(hire_date, 'yyyy-MM-DD')
from hr.employees;

select employee_id, job_id, hire_date, 
        to_char(hire_date, 'yyyy-MM-DD HH : MI : SS AM')
from hr.employees;

select sysdate, to_char(sysdate, 'YYYY-MM-DD HH24 : MI : SS AM')
from dual;

-- 사원번호 직무 급여를 출력하는데 급여 앞에 $를 붙이 세자리마다 ','를 
-- 찍어주자.
select employee_id, job_id, to_char(salary, '$999,999')
from hr.employees;
-- 사원번호 직무 급여를 출력하는데 급여 앞에 지역화폐 단위를 
-- 붙이고 세자리마다 ','를 찍어주자.
select employee_id, job_id, to_char(salary, 'L999,999MI')
from hr.employees;

--- 날짜가 10-10-2002이후에 입사한 직원을 출력하시오.
select * from hr.employees
where to_char(hire_date,'mm-dd-yyyy') > '10-10-2002';

select * from hr.employees
where hire_date > to_date('10-10-2002','dd-mm-yyyy');


-- 일반 함수 : NVL NVL2 NULLIF
select * from hr.employees;
-- 사원번호, 직무, 커미션을 포함한 급여를 출력하시오.
select employee_id, job_id, 
       salary + salary * nvl(commission_pct,0)
from hr.employees;

select employee_id, job_id, 
    nvl2(commission_pct, salary + salary * commission_pct, salary)
from hr.employees;
--사원번호, 직무, 년봉을 구하시오.
select employee_id, job_id, 
       salary * (1 + nvl(commission_pct,0)) *12
from hr.employees;

-------------- 많이 사용하는 방법
select employee_id, job_id, 
    nvl2(commission_pct, 'sal+comm' ,'sal')
from hr.employees;

-- 조건 표현식
-- 직무가 'IT_PROG'라면 급여에 1.1배를 하고
--       'ST_CLERK'라면 급여에 1.15배를 하고 
--       'SA_REP'라면 급여에 1.2배를한다.
-- 나머지직원은 급여만 지급한다.
-- 사원번호, 급여 , 직무, 조건에 따른 값을 출력
select employee_id, salary, job_id,
    case job_id when 'IT_PROG' then 1.10 * salary
                when 'ST_CLERK' then 1.12 * salary
                when 'SA_REP' then 1.20 * salary
    else salary end sal, hire_date
from hr.employees;
--decode
select employee_id, salary, job_id,
    decode( job_id , 'IT_PROG' , 1.10 * salary
                   , 'ST_CLERK' , 1.12 * salary
                   , 'SA_REP' , 1.20 * salary
                   , salary ) sal, hire_date
from hr.employees;

-- 급여가 10000이상이면 "이사급입니다"
--             7000이상이면 "부장급입니다"
 --            5000이상이면 "과장급입니다"
 --            나머지는 사원으로 출력하시오.
 --     성과 급여를 같이 출력한다.
select employee_id, salary, job_id,
case  when salary >= 10000 then '이사급입니다'
      when salary >= 7000 then '부장급입니다'
      when salary >= 5000 then '과장급입니다'
      else '사원입니다.'  end
from hr.employees;


--문제) 급여를 2000으로 나눈 값의 몫이 
--       0이면 0.00
--       1이면 0.09
--       2이면 0.20
--       3이면 0.30
--       4이면 0.40
--       5이면 0.42
--       6이면 0.44
--             0.45 만큼 세금이 부여된다.
--부여되는 세금을 출력하시오.-
--성과 급여도 같이 출력하시오.(단, 부서가 80인 사원만)
--decode를 사용하시오.
select employee_id, salary, last_name,
 decode (trunc(salary/2000, 0), 0, salary * 0.00
			      , 1, salary * 0.09
                              , 2, salary * 0.20
 			      , 3, salary * 0.30
			      , 4, salary * 0.40
			      , 5, salary * 0.42
			      , 6, salary * 0.44
			      , salary * 0.45) tex
from hr.employees
where department_id = 80;







