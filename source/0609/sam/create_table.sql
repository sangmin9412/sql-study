----create_table.sql----
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
drop table board;
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
drop table goods; 
create table goods(
	GOODS_NUM        VARCHAR2(200),
	USER_ID          VARCHAR2(20) null,
	GOODS_NAME       VARCHAR2(20) not null,
	GOODS_CONTENT    VARCHAR2(2000),
	GOODS_IMAGE      VARCHAR2(200)
);
drop table goods_ipgo;
create table goods_ipgo(
	ipgo_SEQ         NUMBER not null,	
	GOODS_NUM         VARCHAR2(200) not null,
	GOODS_QTY         NUMBER,
	GOODS_REGISTER    TIMESTAMP(6),
	GOODS_PRICE      NUMBER
);

drop table cart;
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
drop table wish;
create table wish(
	user_id varchar2(2) not null,
	goods_num varchar2(200) not null
);
drop table comment1;
create table comment1(
	comment_no number not null,
	cuser_id varchar2(20) not null,
	reg_date Timestamp default sysdate,
	comment_subject varchar2(200) not null,
	comment_content varchar2(2000)
);

drop table reply;
create table reply(
	reply_no number not null,
	ruser_id varchar2(20) not null,
	comment_no number not null
	cuser_id varchar2(20) not null,
	reg_date Timestamp default sysdate,
	reply_content varchar2(2000)
);