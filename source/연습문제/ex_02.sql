----몇년, 몇주
---- 몇개월



--문제) 직원이 오늘날짜로 입사한지 몇개월되었는지 출력하시오.
--직원번호 직무 입사일 입사개월( MONTHS_BETWEEN)
select employee_id, job_id, hire_date, 
trunc(MONTHS_BETWEEN(SYSDATE,hire_date)) "입사 후 개월수"
from HR.employees;


--문제) 직원이 입사한 날로부터 6개월후는 몇일입니까?
--직원번호 성 입사일 6개월후(ADD_MONTHS)
select employee_id, last_name, hire_date, add_months(hire_date, 6)
from HR.employees;

--문제) 직원이 입사한지 180개월이 넘은 사원을 출력하시오.
--직원번호 성 입사일
select employee_id, last_name, hire_date, add_months(hire_date, 36), trunc((sysdate - hire_date) / 365) "yeyeye"
from HR.employees
where MONTHS_BETWEEN(SYSDATE,hire_date) > 180;

--문제) 직원이 입사한지 180개월 미만인 사원을 출력하시오.
--직원번호 성 입사일
select employee_id, last_name, hire_date, add_months(hire_date, 36), trunc((sysdate - hire_date) / 365) "yeyeye"
from HR.employees
where MONTHS_BETWEEN(SYSDATE,hire_date) < 180;

--문제)오늘부터 다음 금요일은 몇일 입니까?(NEXT_DAT)
select sysdate, next_day(sysdate, '금요일')
from dual;

--문제) 게시판리스트에서 제목을 5글자****
--직원의 성을 3글자만 출력 뒤에 *을 세번찍어서 출력하시오.
--직원번호, 입사일, 성
select *
from HR.employees;

--문제) 홍길동은 몇글자입니까? 3
select length('홍길동')
from dual;

--문제)"홍길동 \n"으로 되어 있는 것을 html에서 행 바꿈이되도록
--     "홍길동 <br>"변경하시오.
select replace('홍길동 \n', '\n', '<br>')
from dual;

--문제) 입사일이 'YYYY-MM-DD'인 날짜를 31-05-2019 16:24:30 오전
--인 형태로 출력하자.
select to_char(hire_date, 'dd-mm-yyyy hh24: mi : ss am')
from HR.employees;


--문제) 숫자(3333333)를 3자리마다 쉼표를 찍어서 출력
select trim(to_char(3333333, '999,999,999'))
from dual;

--문제) 직원테이블에서 급여를 W33,333,333식으로 출력하시오.
select salary, trim(to_char(salary, 'L999,999,999'))
from HR.employees;

--문제) 직원의 2018-10-25까지의 근무일수를 계산하시오.
--직원번호, 부서번호, 입사일, 근무일수
select employee_id, department_id, hire_date, (to_date('2018-10-25', 'yyyy-mm-dd') - hire_date) "근무일수"
from HR.employees;


--문제) 직원의 25-10-2018까지의 근무일수를 계산하시오.
--직원번호, 부서번호, 입사일, 근무일수
select employee_id, department_id, hire_date, (to_date('25-10-2018', 'dd-mm-yyyy') - hire_date) "근무일수"
from HR.employees;


--문제) 직원의 10-25-2018까지의 근무일수를 계산하시오.
--직원번호, 부서번호, 입사일, 근무일수
select employee_id, department_id, hire_date, (to_date('10-25-2018', 'mm-dd-yyyy') - hire_date) "근무일수"
from HR.employees;

--문제) '10-25-2002'에 입사한 사원을 출력하시오.
--직원번호, 부서번호, 입사일, 근무일수
select employee_id, department_id, hire_date, (to_date('10-25-2018', 'mm-dd-yyyy') - hire_date) "근무일수"
from HR.employees
where to_date('10-25-2002', 'mm-dd-yyyy') >= hire_date;


--문제) 년말정산을 하려고 합니다.
--      년봉(급여*12) : 급여는 커미션까지 포함된다.
--직원의 년봉을 구하시오.
-- 직원번호, 부서번호, 급여, 년봉
select employee_id, department_id, salary, (salary + salary * nvl(commission_pct, 0)) * 12 "연봉", nvl(commission_pct, 0)
from HR.employees;


--문제) 부서가 90이거나 30인 부서의 직원의 년봉을 구하시오
--직원번호, 부서번호, 급여, 년봉
select employee_id, department_id, salary, (salary + salary * nvl(commission_pct, 0)) * 12 "연봉", nvl(commission_pct, 0)
from HR.employees
where department_id in (90, 30);


---- nvl2
--문제)직원번호와 성과 급여 그리고 년봉을 출려하시오.
select employee_id, department_id, salary, (salary + salary * nvl2(commission_pct, commission_pct, 0)) * 12 "연봉", nvl(commission_pct, 0)
from HR.employees;


---- 조건식
--문제) 급여가 10000이상이면 "이사급입니다"
--             7000이상이면 "부장급입니다"
--             5000이상이면 "과장급입니다"
--             나머지는 사원으로 출력하시오.
--      성과 급여를 같이 출력한다.
--
--
----case
select employee_id, last_name, salary,
    case when salary >= 10000 then '이사'
        when salary >= 7000 then '부장'
        when salary >= 5000 then '과장'
        else '사원' end "직급"
from HR.employees;


----decode
--
--
--문제) 급여를 2000으로 나눈 값의 몫이 
--       0이면 0.00
--       1이면 0.09
--       2이면 0.20
--       3이면 0.30
--       4이면 0.40
--       5이면 0.42
--       6이면 0.44
--             0.45 만큼 세금이 부여된다.
--부여되는 세금을 출력하시오.
--성과 급여도 같이 출력하시오.(단, 부서가 80인 사원만)
select employee_id, last_name, salary,
    decode( trunc(salary / 2000),0 , salary * 0.00
                                ,1 , salary * 0.09
                                ,2 , salary * 0.20
                                ,3 , salary * 0.30
                                ,4 , salary * 0.40
                                ,5 , salary * 0.42
                                ,6 , salary * 0.44
                                , salary * 0.45) "세금"
from HR.employees
where department_id = 80;

--문제) 직원 전체에서 입사일이 제일빠른 사람과 최근에 입사한 
--사원을 출력하시오.




--문제) 사원의 수를 출력하시오.
--
--
---- null은 count되질 않으므로 값의 차이가 있을 수 있다.
--select avg(commiddion_pct), sum(commission_pct)/sum(employee_id)
--from hr.employees;
--
--select avg(nvl(commission_pct,0)), sum(commission_pct)/count(employee_id)
--from hr.employees;
--
--
--문제) 직원테이블에서 부서가 몇개인지를 출력하시오.
--
--
--
--
--
--문제)사원 테이블에서 각부서별 급여평균을 구하자.
--
--
--
--문제) 위 문제에서 부서를 오름차순으로 정렬하여 출력하시오.
--
--
--
---- select 문의 구성 순서
--select
--from
--where
--group by 
--having
--order by
--
--문제) 각부서별 급여의 평균을 구하는 평균값이 낮은 것부터 
--출력하시오.
--
--
--문제) 각 부서에 있는 사원의 직무별 급여의 평균을 구하시오.
--


SELECT TO_DATE(SYSDATE, 'yyyy mm dd') AS "현재시간"  FROM DUAL;
 
SELECT TO_CHAR(SYSDATE, 'RRRR-MM-DD HH24:MI:SS') AS "현재시간"  FROM DUAL;
 
-- 1일 전
SELECT TO_CHAR(SYSDATE-1, 'RRRR-MM-DD HH24:MI:SS') AS "현재시간"  FROM DUAL;
 
-- 1시간 전
SELECT TO_CHAR(SYSDATE-1/24, 'RRRR-MM-DD HH24:MI:SS') AS "현재시간"  FROM DUAL;
 
-- 1분 전
SELECT TO_CHAR(SYSDATE-1/24/60, 'RRRR-MM-DD HH24:MI:SS') AS "현재시간"  FROM DUAL;
 
-- 1초 전
SELECT TO_CHAR(SYSDATE-1/24/60/60, 'RRRR-MM-DD HH24:MI:SS') AS "현재시간"  FROM DUAL;
 
-- 5시간 30분 10초 전
SELECT TO_CHAR(SYSDATE-(5/24+30/24/60+10/24/60/60), 'RRRR-MM-DD HH24:MI:SS') AS "현재시간"  FROM DUAL;
 
-- ADD_MONTHS(a,b) a 날짜에 b 달을 더한 값을 반환
SELECT TO_CHAR(ADD_MONTHS(SYSDATE,4),'RRRR-MM-DD') AS "MONTH" FROM DUAL;
 
-- b에 음수가 들어가면 빼준다.
SELECT TO_CHAR(ADD_MONTHS(SYSDATE,-4),'RRRR-MM-DD') AS "MONTH" FROM DUAL;
SELECT TO_CHAR(ADD_MONTHS(SYSTIMESTAMP,4),'RRRR-MM-DD') AS "MONTH" FROM DUAL;
 
-- 4) MONTHS_BETWEEN(day1, day2) : day1 과 day2 사이의 달수를 NUMBER 타입으로 반환한다.
SELECT MONTHS_BETWEEN(TO_DATE('2017-11-10','YYYY-MM-DD'), TO_DATE('2017-09-12','YYYY-MM-DD'))
AS "month" FROM DUAL;
 
-- 일(day) 구하기 ★★★
SELECT TO_DATE('2017-11-10','YYYY-MM-DD') - TO_DATE('2017-09-12','YYYY-MM-DD')
AS "day" FROM DUAL;
 
-- LAST_DAY(m) : 지정한 달의 마지막 날짜 가져오기 앞에 항상 다른 컬럼과 같이 사용해야함
SELECT SYSDATE TODAY,LAST_DAY(SYSDATE) AS "lastDay" FROM DUAL;

