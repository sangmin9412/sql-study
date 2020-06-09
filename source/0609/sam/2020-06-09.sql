drop table board;
drop table member;

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
	BOARD_NUM   NUMBER   not null ,
	USER_ID   VARCHAR2(20),
   	BOARD_NAME    VARCHAR2(20)  not null,
   	BOARD_PASS VARCHAR2(200)  NOT NULL,
   	BOARD_SUBJECT VARCHAR2(100)  NOT NULL,
   	BOARD_CONTENT VARCHAR2(2000) ,
   	BOARD_DATE TIMESTAMP default sysdate,
   	IP_ADDR VARCHAR2(15)  ,
   	READ_COUNT NUMBER default 0
);
---- primary_key
alter table member
add constraint member_user_id_PK primary key(user_id);
---- foreign key
alter table board
add constraint board_user_id_FK foreign key(user_id)
references member(user_id);
-------
------- ������ ����
insert into member(user_id, USER_PW, USER_NAME,USER_BIRTH,USER_GENDER,
		  USER_ADDR,USER_PH1,USER_PH2,USER_REGIST,USER_EMAIL)
values('highland1','111111','�̼���','1999-12-12','1','����',
	'010-1234-5678', null, default,'aaaa');

insert into board(BOARD_NUM,USER_ID,BOARD_NAME,BOARD_PASS,BOARD_SUBJECT,
		 BOARD_CONTENT,IP_ADDR)
values(1, 'highland1', '����� �ƺ�', '1111','����','�ù�',
       '111.111.111.111');

select * from member;
select * from board;

----- member�� �ִ� �����͸� ����
delete from member
where user_id = 'highland1';
���� ���� -
ORA-02292: integrity constraint (STUDY.BOARD_USER_ID_FK) violated - child record found

--- �ڽĵ����Ͱ� �־ ������ ���� �ʴ´�.
-- �� member�� board���� ����(primary key(�θ�)�� foreign key(�ڽ�)�� ����) 
foreign key�� ���� ������ ���� ������ �� �θ����͸� �����ؾ� �Ѵ�.

delete from board
where user_id = 'highland1';
delete from member
where user_id = 'highland1';

--- �θ����͸� �����Ҷ� �ڽĵ����͵� ������ �Ǿ�� �ϴµ�
-- �ڽĵ����Ͱ� ���� �־�� �ϴ� ��쵵 �ִ�..
-- �׷��� ���� ���� �ĺ������ ��ĺ� �����̴�.

--- �ĺ����踦 ������.
-- �θ� �����Ͱ� ���� �ɶ� �ڽ� �����͵� ���� ������.
alter table board 
drop constraint board_user_id_FK;

alter table board
add constraint board_user_id_FK foreign key(user_id)
	references member(user_id) on delete cascade;

select * from member;
select * from board;

delete from member
where user_id = 'highland1';
-- on delete cascade �ɼ��� �ֹǷμ� �ĺ����踦 ����� �� �� �ִ�.

--- ��ĺ�����
--- �θ����̺� �ִ� �����͸� ���� �ϴ��� �ڽ� �����ʹ� �����Ѵ�.
alter table board 
drop constraint board_user_id_FK;

alter table board
add constraint board_user_id_FK foreign key(user_id)
	references member(user_id) ON DELETE SET NULL;

insert into member(user_id, USER_PW, USER_NAME,USER_BIRTH,USER_GENDER,
		  USER_ADDR,USER_PH1,USER_PH2,USER_REGIST,USER_EMAIL)
values('highland1','111111','�̼���','1999-12-12','1','����',
	'010-1234-5678', null, default,'aaaa');

insert into board(BOARD_NUM,USER_ID,BOARD_NAME,BOARD_PASS,BOARD_SUBJECT,
		 BOARD_CONTENT,IP_ADDR)
values(1, 'highland1', '����� �ƺ�', '1111','����','�ù�',
       '111.111.111.111');


delete from member
where user_id = 'highland1';

select * from member;
select * from board;


--- �ĺ������ ��ĺ����� �����ϵ��� ����.
---- ��ĺ������� ��� �ڽ� ���̺�
alter table board
add constraint board_board_num_PK primary key(board_num);

alter table board 
drop constraint board_user_id_FK;

alter table board
add constraint board_user_id_FK foreign key(user_id)
	references member(user_id) ON DELETE SET NULL;

---- �ĺ������� ��� �ڽ� ���̺�
delete from board;

alter table board
modify (user_id varchar2(20) not null);

alter table board
drop constraint board_board_num_PK;


alter table board
add constraint board_board_num_PK primary key(board_num,user_id);


alter table board 
drop constraint board_user_id_FK;

alter table board
add constraint board_user_id_FK foreign key(user_id)
	references member(user_id) on delete cascade;

----- �ĺ������� ���
foreign key�� ���鶧 on delete cascade�� �������־�� �Ѵ�.
foreirn key�� �ش� table�� primary key�� ���ϰ� �Ǵ� ���
----- ��ĺ������� ��� 
foreign key�� ���鶧 on delete set null�� �������־�� �Ѵ�.
foreirn key�� �ش� table�� primary key�� ������ �ʰ� foreign key�θ� ����� �Ǵ� ���
 
drop table member;
drop table board;

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

create table goods(
	GOODS_NUM        VARCHAR2(200),
	USER_ID          VARCHAR2(20) null,
	GOODS_NAME       VARCHAR2(20) not null,
	GOODS_CONTENT    VARCHAR2(2000),
	GOODS_IMAGE      VARCHAR2(200)
);
alter table goods
add (ip_addr varchar2(20),
     GOODS_VISIT NUMBER);

create table goods_ipgo(
	ipgo_SEQ         NUMBER not null,	
	GOODS_NUM         VARCHAR2(200) not null,
	GOODS_QTY         NUMBER,
	GOODS_REGISTER    TIMESTAMP(6),
	GOODS_PRICE      NUMBER
);
	

---- primary key
alter table member
add constraint member_user_id_PK primary key(user_id);

alter table board
add constraint board_board_num_user_id_PK primary key(board_num,user_id);

alter table goods
add constraint goods_goods_num_pk primary key(goods_num);

alter table goods_ipgo
add constraint goods_ipgo_SEQ_goods_num_PK primary key(ipgo_SEQ,goods_num);


--- foreign key
alter table board 
add constraint board_user_id_FK foreign key(user_id)
references member(user_id);

alter table goods
add constraint goods_user_id_FK foreign key(user_id)
references member(user_id);
 
alter table goods_ipgo
add constraint goods_ipgo_goods_num_FK foreign key(goods_num)
references goods(goods_num);

create table cart(
	CART_NUM       NUMBER not null,
	GOODS_NUM      VARCHAR2(200) not null,
	USER_ID        VARCHAR2(20) not null, 
	GOODS_NAME     VARCHAR2(20)not null,
	GOODS_PRICE    NUMBER not null,
	GOODS_IMAGE    VARCHAR2(200) ,
	QTY            NUMBER not null ,
	total_PRICE    NUMBER not null
);
- primary key 
alter table cart
add constraint cart_PK primary key(CART_NUM, GOODS_NUM, USER_ID);

--- foreign key
alter table cart
add constraint cart_GOODS_SEQ_FK foreign key(GOODS_NUM)
    references goods(goods_num); 

alter table cart
add constraint cart_goods_user_id_FK foreign key(user_id)
     references member(user_id);

---constraint ����----
alter table  cart
drop constraint cart_user_id_FK 
drop constraint cart_GOODS_SEQ_FK;

--- check constraint
alter table cart
add constraint cart_qty_CK check (qty > 0);

alter table cart 
add constraint cart_total_price_CK check(total_price = GOODS_PRICE*qty);


-----------�߰�����-----------------
alter table cart
drop constraint cart_qty_CK
drop constraint cart_total_price_CK

alter table cart
add constraint cart_qty_CK check (qty > 0)
add constraint cart_total_price_CK check(total_price = GOODS_PRICE*qty);
------------�߰���--------------------

create table wish(
	user_id varchar2(2) not null,
	goods_num varchar2(200) not null
);
-----primary key----
alter table wish
add constraint wish_PK primary key(user_id, goods_num)

---- foreign key

alter table wish
add constraint wish_user_id_FK foreign key(user_id)
    references member(user_id);

alter table wish
add constraint wish_goods_num_FK foreign key(goods_num)	 
	references goods(goods_num);


create table comment1(
	comment_no number not null,
	cuser_id varchar2(20) not null,
	reg_date Timestamp default sysdate,
	comment_subject varchar2(200) not null,
	comment_content varchar2(2000)
);
--- primary key---
alter table comment1
add constraint comment_PK primary key(comment_no,cuser_id);

----foreign key ----
alter table comment1
add constraint comment1_user_id_FK foreign key(cuser_id)
	references member(user_id);


create table reply(
	reply_no number not null,
	ruser_id varchar2(20) not null,
	comment_no number not null
	cuser_id varchar2(20) not null,
	reg_date Timestamp default sysdate,
	reply_content varchar2(2000)
);
---- primary key---
alter table reply
add constraint reply_PK primary key(reply_no,ruser_id,comment_no,cuser_id);

--- foreign key ----
alter table reply
add constraint reply_ruser_id_FK foreign key(ruser_id)
	references member(user_id);

alter table reply
add constraint reply_comment1_FK foreign key(comment_no,cuser_id)
	references comment1(comment_no,cuser_id);



 
 






