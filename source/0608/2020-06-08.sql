INSERT INTO employees
VALUES      ((select max(employee_id)+1 from employees), 
             'Den', 'Raphealy', 
             'DRAPHEAL', '515.127.4561',
             TO_DATE('6월 8, 2020', 'MON DD, YYYY'),
             'AC_ACCOUNT', 11000, NULL, 100, 30);


INSERT INTO employees
VALUES      ((select max(employee_id)+1 from employees), 
             'Den', 'Raphealy', 
             'DRAPHEAL', '515.127.4561',
             '2020/05/30',
             'AC_ACCOUNT', 11000, NULL, 100, 30);


select * from employees
where hire_date in ('2020/06/08', '2020/05/30');


update employees
set department_id = 20;

문제) 사원번호 114번의 급여를 15000으로 변경하고 직무를 'SA_MAN'로 
변경하시오.

update employees
set salary = 15000, job_id = 'SA_MAN'
where employee_id = 114;


문제) 사원번호 114번의 급여는 127번 사원급여와 같게 변경하시고,
                      직무는 200번사원의 직무와 같게 변경하시오.
select * from employees where employee_id = 114;

update employees
set salary = (select salary from employees
              where employee_id = 127), 
    job_id = (select job_id from employees
	      where employee_id = 200)
where employee_id = 114;

select * from employees where employee_id = 114;


---- delete
delete from table명
where condition(조건절)

select * from departments;

문제) 부서명 NOC인 부서를 삭제하시오.
delete from departments
where department_name = 'NOC';

문제) delete 에 where절을 사용하지 않으면 어떻게 되나?
delete from departments;


문제) 'REP'를 포함하고 있는 부서의 사원들을 모두 삭제하시오..
delete employees
where  job_id like '%REP%';


문제) 부서명이 'IT'인 부서의 사람들을 삭제하시오.
delete from employees
where department_id in (select department_id 
			from departments
			where department_name  = 'IT');
rollbak;

문제)사원들을 모두 삭제하시오.
delete from employees;   -- rollback이 가능
			 -- 삭제 속도가 느리다.
commit;
TRUNCATE table employees; -- rollback이 가능하지 않다.
			 --  삭제 속도가 빠르다.
                         --  rollback하지 않아도 되는 table에 사용


DDL (create(생성), drop(삭제) , alter(수정))
---- table 생성

create table dept(               ---   public class Dept {-- //DTO./VO
	deptno      number(2),   --         int     deptNo;
	dname 	    varchar2(20), --	    String  dName;
	loc 	    varchar2(13), -- 	    String loc;
	create_date date default sysdate -- Date createDate;
                                          -- getter/setter
);				     ---}
--- 컬럼에 default 를 주면 값이 저장되지 않을 default값이 저장되게 된다.
desc dept; -- table 확인

insert into dept(deptno, dname , loc , create_date)
values(11, '총무부', '서울', sysdate);

select * from dept;

insert into dept(deptno, dname, loc)
values(12, '인사과', '부산');

select * from dept;


insert into dept(deptno, dname , loc , create_date)
values(13, '영업부', '전주', default )


CREATE TABLE dept1 (                               
        deptno      NUMBER(2),                     
         dname       VARCHAR2(14),                  
         loc         VARCHAR2(13) default '서울',    
         create_date DATE DEFAULT SYSDATE           
); 

insert into dept1(deptno, dname)
values(11, '총무부');
select * from dept1;

insert into dept1(deptno, dname,loc )
values(12,'인사과', '부산');




create table member(
	user_id VARCHAR2(20) not null,
	USER_PW  VARCHAR2(200) not null,
	USER_NAME VARCHAR2(40) not null,
	USER_BIRTH TIMESTAMP not null,
	USER_GENDER VARCHAR2(1) not null, 
	USER_ADDR  VARCHAR2(200) null,   
	USER_PH1 VARCHAR2(13)  not null, 
	USER_PH2 VARCHAR2(13),
	USER_EMAIL VARCHAR2(200),
	USER_REGIST TIMESTAMP  default sysdate,
	JOIN_OK  VARCHAR2(500)
 );

create table board(
	BOARD_NUM   NUMBER   not null,
	user_id VARCHAR2(20) not null,
	BOARD_NAME    VARCHAR2(20)  not null,
	BARD_PASS VARCHAR2(200)  NOT NULL,
	BOARD_SUBJECT VARCHAR2(100)  NOT NULL,
	BOARD_CONTENT VARCHAR2(2000) ,
	BOARD_DATE TIMESTAMP default sysdate,
	IP_ADDR VARCHAR2(15)  ,
	READ_COUNT NUMBER DEFAULT 0
);

insert into member(user_id, USER_PW, USER_NAME,USER_BIRTH,USER_GENDER,
		  USER_ADDR,USER_PH1,USER_PH2,USER_REGIST,USER_EMAIL)
values('highland0','111111','이숭무','1999-12-12','1','성남',
	'010-1234-5678', null, default,null);

insert into board(BOARD_NUM,USER_ID,BOARD_NAME,BOARD_PASS,BOARD_SUBJECT,
		 BOARD_CONTENT,IP_ADDR)
values(1, 'highland0', '상장범 아빠', '1111','제목','냉무',
       '111.111.111.111');

insert into board(BOARD_NUM,USER_ID,BOARD_NAME,BOARD_PASS,BOARD_SUBJECT,
		 BOARD_CONTENT,IP_ADDR)
values(2, 'aaaaa', '상장범 아빠', '1111','제목','냉무',
       '111.111.111.111');


select * from member;
select * from board;


drop table member;
drop table board;
create table member(
	user_id VARCHAR2(20) not null 
		constraint member_user_id_PK primary key ,
	USER_PW  VARCHAR2(200) not null,
	USER_NAME VARCHAR2(40) not null,
	USER_BIRTH TIMESTAMP not null,
	USER_GENDER VARCHAR2(1) not null, 
	USER_ADDR  VARCHAR2(200) null,   
	USER_PH1 VARCHAR2(13)  not null, 
	USER_PH2 VARCHAR2(13),
	USER_EMAIL VARCHAR2(200),
	USER_REGIST TIMESTAMP  default sysdate,
	JOIN_OK  VARCHAR2(500)
 );

create table board(
	BOARD_NUM   NUMBER   not null 
		constraint board_BOARD_NUM_PK primary key,
	user_id VARCHAR2(20) not null 
		constraint board_user_id_FK references member(user_id),
	BOARD_NAME    VARCHAR2(20)  not null,
	BOARD_PASS VARCHAR2(200)  NOT NULL,
	BOARD_SUBJECT VARCHAR2(100)  NOT NULL,
	BOARD_CONTENT VARCHAR2(2000) ,
	BOARD_DATE TIMESTAMP default sysdate,
	IP_ADDR VARCHAR2(15)  ,
	READ_COUNT NUMBER DEFAULT 0
);

insert into member(user_id, USER_PW, USER_NAME,USER_BIRTH,USER_GENDER,
		  USER_ADDR,USER_PH1,USER_PH2,USER_REGIST,USER_EMAIL)
values('highland0','111111','이숭무','1999-12-12','1','성남',
	'010-1234-5678', null, default,null);

insert into board(BOARD_NUM,USER_ID,BOARD_NAME,BOARD_PASS,BOARD_SUBJECT,
		 BOARD_CONTENT,IP_ADDR)
values(1, 'highland0', '상장범 아빠', '1111','제목','냉무',
       '111.111.111.111');

---- 실행 안됨--- 제약조건 오류 발생---
--- ORA-02291: integrity constraint (STUDY.BOARD_USER_ID_FK) violated 
--- parent key not found

insert into board(BOARD_NUM,USER_ID,BOARD_NAME,BOARD_PASS,BOARD_SUBJECT,
		 BOARD_CONTENT,IP_ADDR)
values(2, 'aaaaa', '상장범 아빠', '1111','제목','냉무',
       '111.111.111.111');
----------------------------------------

----- 실행 안됨 ---- 제약조건 오류 발생
insert into member(user_id, USER_PW, USER_NAME,USER_BIRTH,USER_GENDER,
		  USER_ADDR,USER_PH1,USER_PH2,USER_REGIST,USER_EMAIL)
values('highland0','111111','이숭무','1999-12-12','1','성남',
	'010-1234-5678', null, default,null);


--- user_id에 primary key 제약조건을 주었으므로 user_id에 중복값이 
--- 없으면 됨
--ORA-00001: unique constraint (STUDY.MEMBER_USER_ID_PK) violated

insert into member(user_id, USER_PW, USER_NAME,USER_BIRTH,USER_GENDER,
		  USER_ADDR,USER_PH1,USER_PH2,USER_REGIST,USER_EMAIL)
values('highland1','111111','이숭무','1999-12-12','1','성남',
	'010-1234-5678', null, default,null);


drop table member;
-- 자식 table에서 부모 테이블로 부터 데이터를 참조하는 경우 부모 table 을 
-- 삭제 할 수 없다.
-- ORA-02449: unique/primary keys in table referenced by foreign keys

-- 부모 table을 참조하는 경우 부모 table을 삭제하려면 
-- 자식table을 먼저 삭제해야 한다.
drop table board;
drop table member; 
 
---- unique key : primary key처럼 데이터 유일해야 한다.
----              null값을 포함할 수 있다.
----              기본키 아니다. 
----              여러개가 존재할 수있다.
---- primary key : 데아터가 유일해야한다.
----               null을 포함하지 못한다. 
---- 		   row(레코드)를 대표할 수 있다.: 기본 키
----               table 오직한개만 존재한다.


create table member(
	user_id VARCHAR2(20) not null 
		constraint member_user_id_PK primary key ,
	USER_PW  VARCHAR2(200) not null,
	USER_NAME VARCHAR2(40) not null,
	USER_BIRTH TIMESTAMP not null,
	USER_GENDER VARCHAR2(1) not null, 
	USER_ADDR  VARCHAR2(200) null,   
	USER_PH1 VARCHAR2(13)  not null, 
	USER_PH2 VARCHAR2(13),
	USER_EMAIL VARCHAR2(200) 
		constraint member_user_email_UK unique,
	USER_REGIST TIMESTAMP  default sysdate,
	JOIN_OK  VARCHAR2(500)
 );

create table board(
	BOARD_NUM   NUMBER   not null 
		constraint board_BOARD_NUM_PK primary key,
	user_id VARCHAR2(20) not null 
		constraint board_user_id_FK references member(user_id),
	BOARD_NAME    VARCHAR2(20)  not null,
	BOARD_PASS VARCHAR2(200)  NOT NULL,
	BOARD_SUBJECT VARCHAR2(100)  NOT NULL,
	BOARD_CONTENT VARCHAR2(2000) ,
	BOARD_DATE TIMESTAMP default sysdate,
	IP_ADDR VARCHAR2(15)  ,
	READ_COUNT NUMBER DEFAULT 0
);


insert into member(user_id, USER_PW, USER_NAME,USER_BIRTH,USER_GENDER,
		  USER_ADDR,USER_PH1,USER_PH2,USER_REGIST,USER_EMAIL)
values('highland0','111111','이숭무','1999-12-12','1','성남',
	'010-1234-5678', null, default,'aaaa');

--- 실행 오류가  발생---
--- ORA-00001: unique constraint (STUDY.MEMBER_USER_EMAIL_UK) violated
insert into member(user_id, USER_PW, USER_NAME,USER_BIRTH,USER_GENDER,
		  USER_ADDR,USER_PH1,USER_PH2,USER_REGIST,USER_EMAIL)
values('highland1','111111','이숭무','1999-12-12','1','성남',
	'010-1234-5678', null, default,'aaaa');
--- 이메일에 같은 값이 들어가면 안된다. 


insert into member(user_id, USER_PW, USER_NAME,USER_BIRTH,USER_GENDER,
		  USER_ADDR,USER_PH1,USER_PH2,USER_REGIST,USER_EMAIL)
values('highland1','111111','이숭무','1999-12-12','1','성남',
	'010-1234-5678', null, default,'bbbbb');

insert into member(user_id, USER_PW, USER_NAME,USER_BIRTH,USER_GENDER,
		  USER_ADDR,USER_PH1,USER_PH2,USER_REGIST,USER_EMAIL)
values('highland2','111111','이숭무','1999-12-12','1','성남',
	'010-1234-5678', null, default,null);


------ 
drop table board;

create table board(
	BOARD_NUM   NUMBER   not null 
		constraint board_BOARD_NUM_PK primary key,
	user_id VARCHAR2(20) not null 
		constraint board_user_id_FK references member(user_id),
	BOARD_NAME    VARCHAR2(20)  
		constraint board_BOARD_NAME_nn not null,
	BOARD_PASS VARCHAR2(200)  NOT NULL,
	BOARD_SUBJECT VARCHAR2(100)  NOT NULL,
	BOARD_CONTENT VARCHAR2(2000) ,
	BOARD_DATE TIMESTAMP default sysdate,
	IP_ADDR VARCHAR2(15)  ,
	READ_COUNT NUMBER DEFAULT 0
);
----- 열 레벨
=========================================================
drop table board;
drop table member;
----table 레벨

create table member(
	user_id VARCHAR2(20) not null,
	USER_PW  VARCHAR2(200) not null,
	USER_NAME VARCHAR2(40) not null,
	USER_BIRTH TIMESTAMP not null,
	USER_GENDER VARCHAR2(1) not null,  
	USER_ADDR  VARCHAR2(200)   not null,  
	USER_PH1 VARCHAR2(13),
	USER_REGIST TIMESTAMP default sysdate,
	USER_EMAIL VARCHAR2(200),
	JOIN_OK  VARCHAR2(500), 
	constraint member_user_id_PK primary key(user_id),
	constraint member_USER_EMAIL_UK unique(USER_EMAIL)
);

create table board(
	BOARD_NUM   NUMBER   not null ,
	USER_ID   VARCHAR2(20)  not null ,
   	BOARD_NAME    VARCHAR2(20)  not null,
   	BOARD_PASS VARCHAR2(200)  NOT NULL,
   	BOARD_SUBJECT VARCHAR2(100)  NOT NULL,
   	BOARD_CONTENT VARCHAR2(2000) ,
   	BOARD_DATE TIMESTAMP default sysdate,
   	IP_ADDR VARCHAR2(15)  ,
   	READ_COUNT NUMBER default 0 ,
	constraint board_BOARD_NUM_PK primary key(BOARD_NUM),
	constraint board_user_id_FK foreign key(user_id)
	REFERENCES member(user_id)
);

--- alter : object 수정
---create_table.sql
 create table member(
	user_id VARCHAR2(20) not null,
	USER_PW  VARCHAR2(200) not null,
	USER_NAME VARCHAR2(40) not null,
	USER_BIRTH TIMESTAMP not null,
	USER_GENDER VARCHAR2(1) not null,  
	USER_ADDR  VARCHAR2(200)   not null,  
	USER_PH1 VARCHAR2(13),
	USER_PH2 VARCHAR2(13),
	USER_REGIST TIMESTAMP default sysdate,
	USER_EMAIL VARCHAR2(200),
	JOIN_OK  VARCHAR2(500)
);

create table board(
	BOARD_NUM   NUMBER   not null ,
	USER_ID   VARCHAR2(20)  not null ,
   	BOARD_NAME    VARCHAR2(20)  not null,
   	BOARD_PASS VARCHAR2(200)  NOT NULL,
   	BOARD_SUBJECT VARCHAR2(100)  NOT NULL,
   	BOARD_CONTENT VARCHAR2(2000) ,
   	BOARD_DATE TIMESTAMP default sysdate,
   	IP_ADDR VARCHAR2(15)  ,
   	READ_COUNT NUMBER default 0
);

---- alter를 이용하여 table 내용 수정
---constraint 추가
--- primary_key.sql
alter table member
add constraint member_user_id_PK primary key(user_id);

alter table board
add constraint board_board_num primary key(board_num,user_id);

---- foreign key
alter table board
add constraint board_user_id_FK foreign key(user_id)
references member(user_id)

--- 식별관계
부모 테이블(member)에 있는 데이터가 삭제 될때 자식 테이블(board)의 데이터도 같이 삭제가 될 때를 말한다.
자식 테이블인 board가 식별관계인 경우 부모 테이블로부터 넘어온 user_id가 
board에 primary key 속성에 포함된다.
foreign key속성도 그대로 유지

alter table board
add constraint board_board_num primary key(board_num,user_id);

alter table board
add constraint board_user_id_FK foreign key(user_id)
references member(user_id)

-- 비식별 관계
부모 테이블(member)에 있는 데이터가 삭제 될때 자식 테이블(board)의 데이터는 그대로 남아있는 것을 말한다.
부모 테이블로 넘어온 foreign key는 foreign key 성격만 갖는다.
 
alter table board
add constraint board_board_num primary key(board_num);

alter table board
add constraint board_user_id_FK foreign key(user_id)
references member(user_id)


=======================

insert into member(suser_id, USER_PW, USER_NAME,USER_BIRTH,USER_GENDER,
		  USER_ADDR,USER_PH1,USER_PH2,USER_REGIST,USER_EMAIL)
values('highland0','111111','이숭무','1999-12-12','1','성남',
	'010-1234-5678', null, default,'aaaa');

insert into board(BOARD_NUM,USER_ID,BOARD_NAME,BOARD_PASS,
            BOARD_SUBJECT, BOARD_CONTENT,IP_ADDR)
values(1, 'highland0', '상장범 아빠', '1111','제목','냉무',
       '111.111.111.111');

delete from member
where user_id = 'highland0';

ORA-02292: integrity constraint (STUDY.BOARD_USER_ID_FK) violated - child record found

delete from board
where user_id = 'highland0';

delete from member
where user_id = 'highland0';


-------부모가 삭제 될 때 자식 데이터도 동반 삭제 될 수 있게 하자.
alter table board 
drop constraint board_user_id_FK;

alter table board
add constraint board_user_id_FK foreign key(user_id)
	references member(user_id) on delete cascade;


insert into member(suser_id, USER_PW, USER_NAME,USER_BIRTH,USER_GENDER,
		  USER_ADDR,USER_PH1,USER_PH2,USER_REGIST,USER_EMAIL)
values('highland0','111111','이숭무','1999-12-12','1','성남',
	'010-1234-5678', null, default,'aaaa');

insert into board(BOARD_NUM,USER_ID,BOARD_NAME,BOARD_PASS,
            BOARD_SUBJECT, BOARD_CONTENT,IP_ADDR)
values(1, 'highland0', '상장범 아빠', '1111','제목','냉무',
       '111.111.111.111');


delete from member
where user_id = 'highland0';

select * from member;
select * from board;

