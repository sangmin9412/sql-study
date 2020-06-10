DROP TABLE board;
DROP TABLE member;

CREATE TABLE member (
    user_id VARCHAR2(20) not null,
    user_pw VARCHAR2(200) not null,
    user_name VARCHAR2(40) not null,
    user_birth TIMESTAMP not null,
    user_gender VARCHAR2(1) not null,
    user_addr VARCHAR2(200) not null,
    user_ph1 VARCHAR2(13) not null,
    user_ph2 VARCHAR2(13),
    user_email VARCHAR2(200) not null,
    user_regist TIMESTAMP default sysdate,
    join_ok VARCHAR2(500)
);

CREATE TABLE board (
    board_num NUMBER not null,
    user_id VARCHAR2(20) not null,
    board_name VARCHAR2(20) not null,
    board_pass VARCHAR2(200) not null,
    board_subject VARCHAR2(100) not null,
    board_content VARCHAR2(4000) not null,
    board_date TIMESTAMP default sysdate,
    ip_addr VARCHAR2(15),
    read_count NUMBER default 0
);

-- primary_key.sql
ALTER TABLE member
ADD CONSTRAINT member_user_id_PK PRIMARY KEY(user_id);

ALTER TABLE board
ADD CONSTRAINT board_board_num_PK PRIMARY KEY(board_num, user_id);

ALTER TABLE board
DROP CONSTRAINT board_board_num_PK;

-- foreign_key.sql
ALTER TABLE board
ADD CONSTRAINT board_user_id_FK FOREIGN KEY(user_id) REFERENCES member(user_id);

-- INSERT
INSERT INTO member(user_id, user_pw, user_name, user_birth, user_gender, user_addr, user_ph1, user_ph2, user_regist, user_email)
VALUES ('test', '111111', 'testName', '1999-12-12', '1', '서울', '010-1234-5678', null, default, 'aaaa');

INSERT INTO board(board_num, user_id, board_name, board_pass, board_subject, board_content, ip_addr)
VALUES (1, 'test', 'testBoardName', '111', '제목', '내용', '111.111.111.111');

-- SELECT
SELECT
    *
FROM member;

SELECT
    *
FROM board;

-- member 에 있는 데이터를 삭제
DELETE FROM member
WHERE user_id = 'test';
-- 자식데이터가 있어서 삭제가 안됨.

TRUNCATE TABLE board;

-- 부모 데이터를 삭제 할 때 자식 데이터도 같이 삭제되도록 하려면 ALTER ... ON DELETE CASCADE 를 사용 한다. (식별관계)
ALTER TABLE board
DROP CONSTRAINT board_user_id_FK;

ALTER TABLE board
ADD CONSTRAINT board_user_id_FK FOREIGN KEY(user_id) REFERENCES member(user_id) ON DELETE CASCADE;

-- 부모 데이터를 삭제 하더라도 자식 데이터는 존재한다. (비식별관계)
ALTER TABLE board
DROP CONSTRAINT board_user_id_FK;

ALTER TABLE board
MODIFY user_id VARCHAR2(20) null;

ALTER TABLE board
ADD CONSTRAINT board_user_id_FK FOREIGN KEY(user_id) REFERENCES member(user_id) ON DELETE SET NULL;

-- 식별관계와 비식별관계 구별하도록 하자.
--  비식별 관계인 경우 자식 테이블
ALTER TABLE board
MODIFY user_id VARCHAR2(20) not null;

ALTER TABLE board
DROP CONSTRAINT board_board_num_PK;

ALTER TABLE board
ADD CONSTRAINT board_board_num_PK PRIMARY KEY(board_num)
--ADD CONSTRAINT board_board_num_PK PRIMARY KEY(board_num, user_id)
;






-------------------------------------------------------------------






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

-- primary_key.sql
ALTER TABLE member
ADD CONSTRAINT member_user_id_PK PRIMARY KEY(user_id);

ALTER TABLE board
ADD CONSTRAINT board_board_num_user_id_PK PRIMARY KEY(board_num, user_id);

ALTER TABLE goods
ADD CONSTRAINT goods_goods_num_PK PRIMARY KEY(goods_num);

ALTER TABLE goods_ipgo
ADD CONSTRAINT ipgo_seq_goods_num_PK PRIMARY KEY(ipgo_seq, goods_num);

ALTER TABLE cart
ADD CONSTRAINT cart_PK PRIMARY KEY(cart_num, goods_num, user_id);

ALTER TABLE wish
ADD CONSTRAINT wish_PK PRIMARY KEY(user_id, goods_num);

ALTER TABLE comment1
ADD CONSTRAINT comment_PK PRIMARY KEY(comment_no, cuser_id);

ALTER TABLE reply
ADD CONSTRAINT reply_PK PRIMARY KEY(reply_no, ruser_id, comment_no, cuser_id);

-- foreign_key.sql
ALTER TABLE board
ADD CONSTRAINT board_user_id_FK FOREIGN KEY(user_id) REFERENCES member(user_id) ON DELETE CASCADE;

ALTER TABLE goods
ADD CONSTRAINT goods_user_id_FK FOREIGN KEY(user_id) REFERENCES member(user_id) ON DELETE SET NULL;

ALTER TABLE goods_ipgo
ADD CONSTRAINT goods_ipgo_goods_num_FK FOREIGN KEY(goods_num) REFERENCES goods(goods_num) ON DELETE CASCADE;

ALTER TABLE cart
ADD CONSTRAINT cart_goods_seq_FK FOREIGN KEY(goods_num) REFERENCES goods(goods_num) ON DELETE CASCADE;

ALTER TABLE cart
ADD CONSTRAINT cart_user_id_FK FOREIGN KEY(user_id) REFERENCES member(user_id) ON DELETE CASCADE;

ALTER TABLE wish
ADD CONSTRAINT wish_user_id_FK FOREIGN KEY(user_id) REFERENCES member(user_id) ON DELETE CASCADE;

ALTER TABLE wish
ADD CONSTRAINT wish_goods_num_FK FOREIGN KEY(goods_num) REFERENCES goods(goods_num) ON DELETE CASCADE;

ALTER TABLE comment1
ADD CONSTRAINT comment_user_id_FK FOREIGN KEY(cuser_id) REFERENCES member(user_id) ON DELETE CASCADE;

ALTER TABLE reply
ADD CONSTRAINT reply_ruser_id_FK FOREIGN KEY(ruser_id) REFERENCES member(user_id) ON DELETE CASCADE;

ALTER TABLE reply
ADD CONSTRAINT reply_comment1_FK FOREIGN KEY(comment_no, cuser_id) REFERENCES comment1(comment_no, cuser_id) ON DELETE CASCADE;

-- unique_key.sql
ALTER TABLE member
ADD CONSTRAINT member_user_email_UK UNIQUE(user_email);

-- check constraint
ALTER TABLE cart
ADD CONSTRAINT cart_qty_CK CHECK (qty > 0)
ADD CONSTRAINT cart_total_price_CK CHECK (total_price = goods_price * qty);

-- SELECT
SELECT * FROM member;
SELECT * FROM board;
SELECT * FROM goods;
SELECT * FROM goods_ipgo;
SELECT * FROM cart;
SELECT * FROM wish;


