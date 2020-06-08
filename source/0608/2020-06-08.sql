INSERT INTO employees
VALUES      ((select max(employee_id)+1 from employees), 
             'Den', 'Raphealy', 
             'DRAPHEAL', '515.127.4561',
             TO_DATE('6�� 8, 2020', 'MON DD, YYYY'),
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

����) �����ȣ 114���� �޿��� 15000���� �����ϰ� ������ 'SA_MAN'�� 
�����Ͻÿ�.

update employees
set salary = 15000, job_id = 'SA_MAN'
where employee_id = 114;


����) �����ȣ 114���� �޿��� 127�� ����޿��� ���� �����Ͻð�,
                      ������ 200������� ������ ���� �����Ͻÿ�.
select * from employees where employee_id = 114;

update employees
set salary = (select salary from employees
              where employee_id = 127), 
    job_id = (select job_id from employees
	      where employee_id = 200)
where employee_id = 114;

select * from employees where employee_id = 114;


---- delete
delete from table��
where condition(������)

select * from departments;

����) �μ��� NOC�� �μ��� �����Ͻÿ�.
delete from departments
where department_name = 'NOC';

����) delete �� where���� ������� ������ ��� �ǳ�?
delete from departments;


����) 'REP'�� �����ϰ� �ִ� �μ��� ������� ��� �����Ͻÿ�..
delete employees
where  job_id like '%REP%';


����) �μ����� 'IT'�� �μ��� ������� �����Ͻÿ�.
delete from employees
where department_id in (select department_id 
			from departments
			where department_name  = 'IT');
rollbak;

����)������� ��� �����Ͻÿ�.
delete from employees;   -- rollback�� ����
			 -- ���� �ӵ��� ������.
commit;
TRUNCATE table employees; -- rollback�� �������� �ʴ�.
			 --  ���� �ӵ��� ������.
                         --  rollback���� �ʾƵ� �Ǵ� table�� ���


DDL (create(����), drop(����) , alter(����))
---- table ����

create table dept(               ---   public class Dept {-- //DTO./VO
	deptno      number(2),   --         int     deptNo;
	dname 	    varchar2(20), --	    String  dName;
	loc 	    varchar2(13), -- 	    String loc;
	create_date date default sysdate -- Date createDate;
                                          -- getter/setter
);				     ---}
--- �÷��� default �� �ָ� ���� ������� ���� default���� ����ǰ� �ȴ�.
desc dept; -- table Ȯ��

insert into dept(deptno, dname , loc , create_date)
values(11, '�ѹ���', '����', sysdate);

select * from dept;

insert into dept(deptno, dname, loc)
values(12, '�λ��', '�λ�');

select * from dept;


insert into dept(deptno, dname , loc , create_date)
values(13, '������', '����', default )


CREATE TABLE dept1 (                               
        deptno      NUMBER(2),                     
         dname       VARCHAR2(14),                  
         loc         VARCHAR2(13) default '����',    
         create_date DATE DEFAULT SYSDATE           
); 

insert into dept1(deptno, dname)
values(11, '�ѹ���');
select * from dept1;

insert into dept1(deptno, dname,loc )
values(12,'�λ��', '�λ�');




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
values('highland0','111111','�̼���','1999-12-12','1','����',
	'010-1234-5678', null, default,null);

insert into board(BOARD_NUM,USER_ID,BOARD_NAME,BOARD_PASS,BOARD_SUBJECT,
		 BOARD_CONTENT,IP_ADDR)
values(1, 'highland0', '����� �ƺ�', '1111','����','�ù�',
       '111.111.111.111');

insert into board(BOARD_NUM,USER_ID,BOARD_NAME,BOARD_PASS,BOARD_SUBJECT,
		 BOARD_CONTENT,IP_ADDR)
values(2, 'aaaaa', '����� �ƺ�', '1111','����','�ù�',
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
values('highland0','111111','�̼���','1999-12-12','1','����',
	'010-1234-5678', null, default,null);

insert into board(BOARD_NUM,USER_ID,BOARD_NAME,BOARD_PASS,BOARD_SUBJECT,
		 BOARD_CONTENT,IP_ADDR)
values(1, 'highland0', '����� �ƺ�', '1111','����','�ù�',
       '111.111.111.111');

---- ���� �ȵ�--- �������� ���� �߻�---
--- ORA-02291: integrity constraint (STUDY.BOARD_USER_ID_FK) violated 
--- parent key not found

insert into board(BOARD_NUM,USER_ID,BOARD_NAME,BOARD_PASS,BOARD_SUBJECT,
		 BOARD_CONTENT,IP_ADDR)
values(2, 'aaaaa', '����� �ƺ�', '1111','����','�ù�',
       '111.111.111.111');
----------------------------------------

----- ���� �ȵ� ---- �������� ���� �߻�
insert into member(user_id, USER_PW, USER_NAME,USER_BIRTH,USER_GENDER,
		  USER_ADDR,USER_PH1,USER_PH2,USER_REGIST,USER_EMAIL)
values('highland0','111111','�̼���','1999-12-12','1','����',
	'010-1234-5678', null, default,null);


--- user_id�� primary key ���������� �־����Ƿ� user_id�� �ߺ����� 
--- ������ ��
--ORA-00001: unique constraint (STUDY.MEMBER_USER_ID_PK) violated

insert into member(user_id, USER_PW, USER_NAME,USER_BIRTH,USER_GENDER,
		  USER_ADDR,USER_PH1,USER_PH2,USER_REGIST,USER_EMAIL)
values('highland1','111111','�̼���','1999-12-12','1','����',
	'010-1234-5678', null, default,null);


drop table member;
-- �ڽ� table���� �θ� ���̺�� ���� �����͸� �����ϴ� ��� �θ� table �� 
-- ���� �� �� ����.
-- ORA-02449: unique/primary keys in table referenced by foreign keys

-- �θ� table�� �����ϴ� ��� �θ� table�� �����Ϸ��� 
-- �ڽ�table�� ���� �����ؾ� �Ѵ�.
drop table board;
drop table member; 
 
---- unique key : primary keyó�� ������ �����ؾ� �Ѵ�.
----              null���� ������ �� �ִ�.
----              �⺻Ű �ƴϴ�. 
----              �������� ������ ���ִ�.
---- primary key : �����Ͱ� �����ؾ��Ѵ�.
----               null�� �������� ���Ѵ�. 
---- 		   row(���ڵ�)�� ��ǥ�� �� �ִ�.: �⺻ Ű
----               table �����Ѱ��� �����Ѵ�.


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
values('highland0','111111','�̼���','1999-12-12','1','����',
	'010-1234-5678', null, default,'aaaa');

--- ���� ������  �߻�---
--- ORA-00001: unique constraint (STUDY.MEMBER_USER_EMAIL_UK) violated
insert into member(user_id, USER_PW, USER_NAME,USER_BIRTH,USER_GENDER,
		  USER_ADDR,USER_PH1,USER_PH2,USER_REGIST,USER_EMAIL)
values('highland1','111111','�̼���','1999-12-12','1','����',
	'010-1234-5678', null, default,'aaaa');
--- �̸��Ͽ� ���� ���� ���� �ȵȴ�. 


insert into member(user_id, USER_PW, USER_NAME,USER_BIRTH,USER_GENDER,
		  USER_ADDR,USER_PH1,USER_PH2,USER_REGIST,USER_EMAIL)
values('highland1','111111','�̼���','1999-12-12','1','����',
	'010-1234-5678', null, default,'bbbbb');

insert into member(user_id, USER_PW, USER_NAME,USER_BIRTH,USER_GENDER,
		  USER_ADDR,USER_PH1,USER_PH2,USER_REGIST,USER_EMAIL)
values('highland2','111111','�̼���','1999-12-12','1','����',
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
----- �� ����
=========================================================
drop table board;
drop table member;
----table ����

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

--- alter : object ����
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

---- alter�� �̿��Ͽ� table ���� ����
---constraint �߰�
--- primary_key.sql
alter table member
add constraint member_user_id_PK primary key(user_id);

alter table board
add constraint board_board_num primary key(board_num,user_id);

---- foreign key
alter table board
add constraint board_user_id_FK foreign key(user_id)
references member(user_id)

--- �ĺ�����
�θ� ���̺�(member)�� �ִ� �����Ͱ� ���� �ɶ� �ڽ� ���̺�(board)�� �����͵� ���� ������ �� ���� ���Ѵ�.
�ڽ� ���̺��� board�� �ĺ������� ��� �θ� ���̺�κ��� �Ѿ�� user_id�� 
board�� primary key �Ӽ��� ���Եȴ�.
foreign key�Ӽ��� �״�� ����

alter table board
add constraint board_board_num primary key(board_num,user_id);

alter table board
add constraint board_user_id_FK foreign key(user_id)
references member(user_id)

-- ��ĺ� ����
�θ� ���̺�(member)�� �ִ� �����Ͱ� ���� �ɶ� �ڽ� ���̺�(board)�� �����ʹ� �״�� �����ִ� ���� ���Ѵ�.
�θ� ���̺�� �Ѿ�� foreign key�� foreign key ���ݸ� ���´�.
 
alter table board
add constraint board_board_num primary key(board_num);

alter table board
add constraint board_user_id_FK foreign key(user_id)
references member(user_id)


=======================

insert into member(suser_id, USER_PW, USER_NAME,USER_BIRTH,USER_GENDER,
		  USER_ADDR,USER_PH1,USER_PH2,USER_REGIST,USER_EMAIL)
values('highland0','111111','�̼���','1999-12-12','1','����',
	'010-1234-5678', null, default,'aaaa');

insert into board(BOARD_NUM,USER_ID,BOARD_NAME,BOARD_PASS,
            BOARD_SUBJECT, BOARD_CONTENT,IP_ADDR)
values(1, 'highland0', '����� �ƺ�', '1111','����','�ù�',
       '111.111.111.111');

delete from member
where user_id = 'highland0';

ORA-02292: integrity constraint (STUDY.BOARD_USER_ID_FK) violated - child record found

delete from board
where user_id = 'highland0';

delete from member
where user_id = 'highland0';


-------�θ� ���� �� �� �ڽ� �����͵� ���� ���� �� �� �ְ� ����.
alter table board 
drop constraint board_user_id_FK;

alter table board
add constraint board_user_id_FK foreign key(user_id)
	references member(user_id) on delete cascade;


insert into member(suser_id, USER_PW, USER_NAME,USER_BIRTH,USER_GENDER,
		  USER_ADDR,USER_PH1,USER_PH2,USER_REGIST,USER_EMAIL)
values('highland0','111111','�̼���','1999-12-12','1','����',
	'010-1234-5678', null, default,'aaaa');

insert into board(BOARD_NUM,USER_ID,BOARD_NAME,BOARD_PASS,
            BOARD_SUBJECT, BOARD_CONTENT,IP_ADDR)
values(1, 'highland0', '����� �ƺ�', '1111','����','�ù�',
       '111.111.111.111');


delete from member
where user_id = 'highland0';

select * from member;
select * from board;

