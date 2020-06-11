create table emp
as 
select * from employees
where 1=2;

select * from emp;

문제 1) 사원테이블에 있는 90인 부서의 사원만 emp에 저장하시오.
	
insert into emp(employee_id, last_name, email, hire_date , job_id, department_id)
select employee_id, last_name, email, hire_date , job_id, department_id
from employees
where department_id = 90;

select * from emp;


insert into emp(employee_id, last_name, email, hire_date , job_id, department_id)
values((select nvl(max(employee_id),0)+1 from emp),'LEE','SMLEE',sysdate,
'SA_REP', 90);

select * from emp;

문제 2) insert절에 컬럼리스트를 작성하는 것 대신 서브쿼리를 사용해보자.
INSERT INTO
        (SELECT employee_id, last_name, email, hire_date, job_id, 
                department_id
         FROM   emp
         WHERE  department_id = 90)
VALUES (99999, 'Taylor', 'DTAYLOR',TO_DATE('07-6월-20', 'DD-MON-RR'),
        'ST_CLERK', 90);

문제 3) emp에 90인 부서만 저장될 수 있게 insert문을 작성하시오.
INSERT INTO
        (SELECT employee_id, last_name, email, hire_date, job_id, 
                department_id
         FROM   emp
         WHERE  department_id = 90
	 with check option) 
VALUES (100000, 'Taylor', 'DTAYLOR',TO_DATE('07-6월-20', 'DD-MON-RR'),
        'ST_CLERK', 80);
---ORA-01402: view WITH CHECK OPTION where-clause violation
---- 90인부서인 데이터만 저장이 된다.

문제 3)emp에 있는 입사일의 기본 값을 sysdate로 주자.
alter table emp
modify (hire_date default sysdate);

문제 4) emp에 있는 103인 사원의 입사일을 기본값으로 변경하시오.
update emp
set hire_date = default
where employee_id = 103;


문제 5) 103인 사원이 있다면 커미션을 0.003을 주고 
	103인 사원없으면 사원 데이터를 입력하시오.
merge into emp e1
using (select employee_id from employees where employee_id = 103) e2
on( e1.employee_id = e2.employee_id)
When MATCHED THEN 
update set commission_pct = nvl(commission_pct,1) * 0.03
When NOT MATCHED THEN 
insert(e1.employee_id, e1.last_name, e1.email, e1.hire_date, 
	e1.job_id, e1.department_id)
values(103,'RHEE','SMRHEE',default,'SA_MAN',90);


select * from emp;


문제 6) 50인 부서번호가  있으면 커미션을 0.5로 수정하고
	없으면 105,'RHEE','SMRHEE',default,'SA_MAN',90를 입력하세요.
merge into emp e1
using (select employee_id from employees where department_id = 50) e2
on( e1.employee_id = e2.employee_id)
When MATCHED THEN 
	update set commission_pct = 0.5,
		   hire_date = default
WHEN NOT MATCHED THEN 
insert(employee_id, last_name, email, hire_date, job_id, department_id)
values(105,'RHEE','SMRHEE',default,'SA_MAN',90);

---- 45개 insert됨

문제 7) 104인 사원이 있다면 커미션을 0.003을 주고 
	104인 사원없으면 사원 데이터를 입력하시오.
merge into emp e1
using (select employee_id from employees where employee_id = 104) e2
on( e1.employee_id = e2.employee_id)
When MATCHED THEN 
update set commission_pct = 0.03
When NOT MATCHED THEN 
insert(e1.employee_id, e1.last_name, e1.email, e1.hire_date, 
	e1.job_id, e1.department_id)
values(104,'RHEE','SMRHEE',default,'SA_MAN',90);


문제 8) 105인사원이 있으면 emp에서 105인 사원을 삭제하고 
	없으면 107,'SJ','SJRHEE', sysdate, 'SA_MAN',90
merge into emp e1
using (select employee_id from employees where employee_id = 105) e2
on( e1.employee_id = e2.employee_id)
When MATCHED THEN
	update set commission_pct = 0.03
	delete where employee_id = 105
When not MATCHED THEN
insert(e1.employee_id, e1.last_name, e1.email, e1.hire_date, 
	e1.job_id, e1.department_id)
values(107,'SJ','SJRHEE', sysdate, 'SA_MAN',90);	


merge
using
on 
When MATCHED THEN
	update
When not MATCHED THEN
insert
values

문제 9) 107인사원이 있으면 emp에서 107인 사원을 삭제하고 
	없으면 107,'SJ','SJYI', sysdate, 'SA_MAN',90
merge into emp e1
using (select employee_id from employees where employee_id = 107) e2
on( e1.employee_id = e2.employee_id)
When MATCHED THEN
	update set commission_pct = 0.03
	delete where employee_id = 107
When not MATCHED THEN
insert(e1.employee_id, e1.last_name, e1.email, e1.hire_date, 
	e1.job_id, e1.department_id)
values(107,'SJ','SJRHEE', sysdate, 'SA_MAN',90);

select * from emp where employee_id = 107;


문제 10)employees에 있는 사원이 emp에도 있는 경우 emp에서 삭제 하시오.
delete from emp
where employee_id IN (select employee_id from employees);


문제 11) emp에 있는 102 사원의 job_id를 employees에 있는 평균급여가 높은 직무로 변경하시오.

update emp
set job_id = (select job_id 
	      from employees
	      group by job_id
	      having avg(salary) = (select max(avg(salary))
			            from employees
				     group by job_id) 
		)
where employee_id = 102;


select * from emp where employee_id = 102;

문제 12) 179번 사원과 200번 사원의 상사이면서
	 179번 사원과 200번 사원의 부서와 같은 부서인 사원들을 구하시오.

select * from employees
where manager_id IN ( select manager_id from employees
		   where employee_id in (179, 200)) -- 149, 101
and department_id IN (select department_id from employees
			where employee_id in (179,200));


select * from employees
where manager_id IN ( 149,101) and department_id IN (80,10);


문제 13) 149번의 직무와 부서가 같은 직원을 출력하시오.
	단 149번은 제외
select * from employees
where (job_id , department_id) = (select job_id, department_id
				  from employees
			          where employee_id = 149)
and employee_id <> 149;

문제 14) 199번과 174번의 상사와 부서가 같은 직원들을 구하시오.
	단, 199번과 174번은 제외
select * from employees
where (manager_id, epartment_id) in 
			(select manager,department_id
			 from employees
			 where employee_id in (174,199)
			)
and employee_id not in (174, 199);

문제 15)사원 번호, 성, 그리고 부서번호를 출력하는데 부서번호가 주소번호(location_id) 1800에 해당하는 부서인 경우 'KOR'로 출력하고 나머지는 'USA'로 출력하시오. employee_id, last_name , department_id (location으로) 출력 (20인 부서만 KOR, 나머지는 'USA')
단, 조인사용하지 말고 서브쿼리를 사용할 것

select  employee_id, last_name,
	case  when department_id in (
			select department_id from departments
			where location_id = 1800
		) then 'KOR' else 'USA' end location    
 from employees;


select  employee_id, last_name,
	decode (department_id , (
				select department_id from departments
				where location_id = 1800
			), 'KOR' , 'USA') location
 from employees;

-- inline view
from절에 사용되는 서브쿼리를 인라인 뷰라고한다.
select *
from (select deaprtment_id ,job_id
      from employees)

문제 16) 부서별 최고 급여에 해당하는 사원의 상세정보를 출력하시오.
select * from employees
where salary in (select max(salary) from employees
		 group by department_id);



문제 17)  부서별 최대 급에 해당하는 사원들의 정보를 구하시오.

--부서별 최고 급여
select department_id , max(salary)
from employees
group by department_id;

select employee_id, last_name, salary, d.department_id
from employees e, (select department_id , max(salary) sal
		   from employees
		   group by department_id) d
where e.department_id = d.department_id and e.salary = d.sal;


문제 18) 부서에서 최고 급여보다 작은 급여를 받는 직원들만 출력하시오.
select employee_id, last_name, salary, d.department_id
from employees e, (
			select department_id, max(salary) maxsal
			from employees
			group by department_id 
		)
where e.department_id = d.department_id and salary < maxsal;


---- TOP - N
문제 19) 최근 입사한 사원중 5명만 출력하시오,
select rownum , employee_id, last_name, salary, department_id
from (select employee_id, last_name, salary, department_id
      from employees
      order by employee_id desc)
where rownum <= 5;

문제 20) 최근 입사한 사원중 11번째 부터 20번째까지 employee_id, last_name, salary, department_id 출력
select rownum, rn, employee_id, last_name, salary, department_id
from	(select rownum rn, employee_id, last_name, salary, department_id
	from (select employee_id, last_name, salary, department_id
      		from employees
      		order by employee_id desc))
where rn >= 11 and rn <= 20;






































































