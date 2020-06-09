-- create_table.sql
DROP TABLE member;
CREATE TABLE member (
    user_id VARCHAR2(20) not null,
    user_pw VARCHAR2(200) not null,
    user_name VARCHAR2(40) not null,
    user_birth TIMESTAMP not null,
    user_gender VARCHAR2(1) not null,
    user_addr VARCHAR2(200) null,
    user_ph1 VARCHAR2(13) not null,
    user_ph2 VARCHAR2(13),
    user_email VARCHAR2(200),
    user_regist TIMESTAMP default sysdate,
    join_ok VARCHAR2(500)
);

DROP TABLE board;
CREATE TABLE board (
    board_num NUMBER not null,
    user_id VARCHAR2(20) not null,
    board_name VARCHAR2(20) not null,
    board_pass VARCHAR2(200) not null,
    board_subject VARCHAR2(100) not null,
    board_content VARCHAR2(2000),
    board_date TIMESTAMP default sysdate,
    ip_addr VARCHAR2(15),
    read_count NUMBER default 0
);

DROP TABLE goods;
CREATE TABLE goods (
    goods_num VARCHAR2(200),
    user_id VARCHAR2(20),
    goods_price NUMBER,
    goods_content VARCHAR2(2000),
    goods_image VARCHAR2(200)
);

ALTER TABLE goods
ADD (ip_addr VARCHAR2(20), goods_visit NUMBER);

DROP TABLE goods_ipgo;
CREATE TABLE goods_ipgo (
    ipgo_seq NUMBER,
    goods_num VARCHAR2(200) not null,
    goods_qty NUMBER,
    goods_register TIMESTAMP(6),
    goods_price NUMBER
);

DROP TABLE cart;
CREATE TABLE cart (
    cart_num NUMBER,
    goods_num VARCHAR2(200) not null,
    user_id VARCHAR2(20),
    goods_price NUMBER not null,
    goods_image VARCHAR2(200),
    qty NUMBER not null,
    total_price NUMBER not null
);

DROP TABLE wish;
CREATE TABLE wish (
    user_id VARCHAR2(20) not null,
    goods_num VARCHAR2(200) not null
);

DROP TABLE comment1;
CREATE TABLE comment1 (
    comment_no NUMBER not null,
    cuser_id VARCHAR2(20) not null,
    reg_date TIMESTAMP default sysdate,
    comment_subject VARCHAR2(200) not null,
    comment_content VARCHAR2(2000)
);

DROP TABLE reply;
CREATE TABLE reply (
    reply_no NUMBER not null,
    ruser_id VARCHAR2(20) not null,
    comment_no NUMBER not null,
    cuser_id VARCHAR2(20) not null,
    reg_date TIMESTAMP default sysdate,
    reply_content VARCHAR2(2000)
);