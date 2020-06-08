-- DDL (Data Definition languege) - CREATE(����), DROP(����), ALTER(����)

-- TABLE ����
CREATE TABLE dept(
    deptno NUMBER(02),
    dname VARCHAR2(20),
    loc VARCHAR2(13),
    -- �÷��� default �� �ָ� ���� �Է����� �ʾ��� �� default ���� ����ȴ�.
    create_date date default sysdate
);
/*
    public class Dept { -- //DTO./VO
        int deptNo;
        String dName;
        String loc;
        Date createDate;
        
        // getter / setter
    }
*/

CREATE TABLE dept1(
    deptno NUMBER(02),
    dname VARCHAR2(14),
    loc VARCHAR2(13) default '����',
    create_date date default sysdate
);

desc dept;

INSERT INTO dept(deptno, dname, loc, create_date)
VALUES (11, '�ѹ���', '����', sysdate);

INSERT INTO dept(deptno, dname, loc)
VALUES (12, '�λ��', '�λ�');

INSERT INTO dept(deptno, dname, loc, create_date)
VALUES (13, '������', '����', default);

SELECT
    *
FROM dept;

desc dept1;

INSERT INTO dept1(deptno, dname)
VALUES (12, '�λ��');

INSERT INTO dept1(deptno, dname, loc)
VALUES (12, '�λ��', '�λ�');

SELECT
    *
FROM dept1;



CREATE TABLE member(
    user_id VARCHAR(20) not null,
    user_pw VARCHAR2(200) not null,
    user_name VARCHAR2(40) not null,
    user_birth TIMESTAMP not null,
    user_gender VARCHAR2(1) not null,
    user_addr VARCHAR2(200) null, -- null �� ��� ���� ����.
    user_ph1 VARCHAR2(13) not null,
    user_ph2 VARCHAR2(13),
    user_email VARCHAR2(200),
    user_regist TIMESTAMP default sysdate,
    join_ok VARCHAR2(500)
);

CREATE TABLE board(
    board_num number not null,
    user_id VARCHAR(20) not null,
    board_name VARCHAR2(20) not null,
    board_pass VARCHAR2(200) not null,
    board_subject VARCHAR2(100) not null,
    board_content VARCHAR2(2000),
    board_date TIMESTAMP default sysdate,
    read_count NUMBER default 0,
    ip_addr VARCHAR2(15)
);

INSERT INTO member(user_id, user_pw, user_name, user_birth, user_gender, user_addr, user_ph1, user_ph2, user_email, user_regist)
VALUES ('test', '111111', 'test', '1999-12-12', '1', '����', '010-1234-2345', null, null, default);

SELECT
    *
FROM member;

INSERT INTO board(board_num, user_id, board_name, board_pass, board_subject, board_content, ip_addr)
VALUES (1, 'test', 'QnA', '111', '����', '����', '000.000.000.000');

INSERT INTO board(board_num, user_id, board_name, board_pass, board_subject, board_content, ip_addr)
VALUES (2, 'aaaaa', 'QnA2', '111', '����2', '����2', '000.000.000.111');

SELECT
    *
FROM board;



-------------------------------------------------------------

DROP TABLE member;
DROP TABLE board;

CREATE TABLE member(
    user_id VARCHAR(20) not null constraint member_user_id_PK primary key,
    user_pw VARCHAR2(200) not null,
    user_name VARCHAR2(40) not null,
    user_birth TIMESTAMP not null,
    user_gender VARCHAR2(1) not null,
    user_addr VARCHAR2(200) null, -- null �� ��� ���� ����.
    user_ph1 VARCHAR2(13) not null,
    user_ph2 VARCHAR2(13),
    user_email VARCHAR2(200),
    user_regist TIMESTAMP default sysdate,
    join_ok VARCHAR2(500)
);

CREATE TABLE board(
    board_num NUMBER not null constraint board_board_num_PK primary key,
    user_id VARCHAR(20) not null constraint board_user_id_FK references member(user_id), -- member ���̺��� user_id �� ����
    board_name VARCHAR2(20) not null,
    board_pass VARCHAR2(200) not null,
    board_subject VARCHAR2(100) not null,
    board_content VARCHAR2(2000),
    board_date TIMESTAMP default sysdate,
    read_count NUMBER default 0,
    ip_addr VARCHAR2(15)
);

INSERT INTO member(user_id, user_pw, user_name, user_birth, user_gender, user_addr, user_ph1, user_ph2, user_email, user_regist)
VALUES ('test', '111111', 'test', '1999-12-12', '1', '����', '010-1234-2345', null, null, default);

INSERT INTO board(board_num, user_id, board_name, board_pass, board_subject, board_content, ip_addr)
VALUES (1, 'test', 'QnA', '111', '����', '����', '000.000.000.000');

INSERT INTO board(board_num, user_id, board_name, board_pass, board_subject, board_content, ip_addr)
VALUES (2, 'aaaaa', 'QnA2', '111', '����2', '����2', '000.000.000.111');

SELECT
    *
FROM member;

SELECT
    *
FROM board;

-- �ڽ� TABLE���� �θ� TABLE�� ���� �����͸� �����ϴ� ��� �θ� TABLE �� ������ �� ����.
-- �θ� TABLE�� ���� �ϴ� ��� �θ� TABLE�� �����Ϸ��� �ڽ� TABLE�� ���� �����ؾ� �Ѵ�.
drop table member;
drop table board;

/*
 unique key
 -    �����Ͱ� �����ؾ� �ϴ�.
 -    null���� ������ �� �ִ�.
 -    �⺻ Ű�� �ƴϴ�.
 -    TABLE�� �������� ������ �� �ִ�.
      
 Primary key
 -    �����Ͱ� �����ؾ� �Ѵ�.
 -    null�� �������� ���Ѵ�.
 -    row(���ڵ�)�� ��ǥ�� �� �ִ�. (�⺻ Ű)
 -    TABLE�� �Ѱ��� �����Ѵ�.
*/

CREATE TABLE member(
    user_id VARCHAR(20) not null constraint member_user_id_PK primary key,
    user_pw VARCHAR2(200) not null,
    user_name VARCHAR2(40) not null,
    user_birth TIMESTAMP not null,
    user_gender VARCHAR2(1) not null,
    user_addr VARCHAR2(200) null, -- null �� ��� ���� ����.
    user_ph1 VARCHAR2(13) not null,
    user_ph2 VARCHAR2(13),
    user_email VARCHAR2(200) constraint member_user_email_UK unique,
    user_regist TIMESTAMP default sysdate,
    join_ok VARCHAR2(500)
);

CREATE TABLE board(
    board_num NUMBER not null constraint board_board_num_PK primary key,
    user_id VARCHAR(20) not null constraint board_user_id_FK references member(user_id), -- member ���̺��� user_id �� ����
    board_name VARCHAR2(20) not null,
    board_pass VARCHAR2(200) not null,
    board_subject VARCHAR2(100) not null,
    board_content VARCHAR2(2000),
    board_date TIMESTAMP default sysdate,
    read_count NUMBER default 0,
    ip_addr VARCHAR2(15)
);

INSERT INTO member(user_id, user_pw, user_name, user_birth, user_gender, user_addr, user_ph1, user_ph2, user_email, user_regist)
VALUES ('test', '111111', 'test', '1999-12-12', '1', '����', '010-1234-2345', null, null, default);

INSERT INTO member(user_id, user_pw, user_name, user_birth, user_gender, user_addr, user_ph1, user_ph2, user_email, user_regist)
VALUES ('test2', '111111', 'test', '1999-12-12', '1', '����', '010-1234-2345', null, 'test@naver.com', default);

INSERT INTO member(user_id, user_pw, user_name, user_birth, user_gender, user_addr, user_ph1, user_ph2, user_email, user_regist)
VALUES ('test3', '111111', 'test', '1999-12-12', '1', '����', '010-1234-2345', null, 'test@naver.com', default);

SELECT
    *
FROM member;

INSERT INTO board(board_num, user_id, board_name, board_pass, board_subject, board_content, ip_addr)
VALUES (1, 'test', 'QnA', '111', '����', '����', '000.000.000.000');

INSERT INTO board(board_num, user_id, board_name, board_pass, board_subject, board_content, ip_addr)
VALUES (2, 'aaaaa', 'QnA2', '111', '����2', '����2', '000.000.000.111');

SELECT
    *
FROM board;

-- �� ���� ��

-- TABLE ���� ��

DROP TABLE board;
DROP TABLE member;

CREATE TABLE member (
    user_id VARCHAR2(20) not null,
    USER_PW VARCHAR2(200) not null,
    USER_NAME VARCHAR2(40) not null,
    USER_BIRTH TIMESTAMP not null,
    USER_GENDER VARCHAR2(1) not null,
    USER_ADDR VARCHAR2(200) not null,
    USER_PH1 VARCHAR2(13),
    USER_PH2 VARCHAR2(13),
    USER_REGIST TIMESTAMP default sysdate,
    USER_EMAIL VARCHAR2(200),
    JOIN_OK VARCHAR2(500),
    CONSTRAINT member_user_id_PK PRIMARY KEY(user_id),
    CONSTRAINT member_USER_EMAIL_UK UNIQUE(USER_EMAIL)
);

CREATE TABLE board (
    BOARD_NUM NUMBER not null,
    user_id VARCHAR2(20) not null,
    BOARD_NAME VARCHAR2(20) not null,
    BOARD_PASS VARCHAR2(200) not null,
    BOARD_SUBJECT VARCHAR2(100) not null,
    BOARD_CONTENT VARCHAR2(2000) not null,
    BOARD_DATE TIMESTAMP default sysdate,
    READ_COUNT NUMBER default 0,
    IP_ADDR VARCHAR2(15),
    CONSTRAINT board_BORAD_NUM_PK PRIMARY KEY(BOARD_NUM),
    CONSTRAINT board_USER_ID_FK FOREIGN KEY(user_id) REFERENCES member(user_id)
);

INSERT INTO member(user_id, user_pw, user_name, user_birth, user_gender, user_addr, user_ph1, user_ph2, user_email, user_regist)
VALUES ('test', '111111', 'test', '1999-12-12', '1', '����', '010-1234-2345', null, 'test@naver.com', default);

INSERT INTO member(user_id, user_pw, user_name, user_birth, user_gender, user_addr, user_ph1, user_ph2, user_email, user_regist)
VALUES ('test', '111111', 'test', '1999-12-12', '1', '����', '010-1234-2345', null, 'test@naver.com', default);

INSERT INTO member(user_id, user_pw, user_name, user_birth, user_gender, user_addr, user_ph1, user_ph2, user_email, user_regist)
VALUES ('test2', '111111', 'test', '1999-12-12', '1', '����', '010-1234-2345', null, 'test@naver.com', default);

SELECT
    *
FROM member;

INSERT INTO board(board_num, user_id, board_name, board_pass, board_subject, board_content, ip_addr)
VALUES (1, 'test', 'QnA', '111', '����', '����', '000.000.000.000');

INSERT INTO board(board_num, user_id, board_name, board_pass, board_subject, board_content, ip_addr)
VALUES (2, 'aaaaa', 'QnA2', '111', '����2', '����2', '000.000.000.111');

SELECT
    *
FROM board;



DROP TABLE board;
DROP TABLE member;

-- alter : Object ����
-- create_table.sql
CREATE TABLE member (
    user_id VARCHAR2(20) not null,
    USER_PW VARCHAR2(200) not null,
    USER_NAME VARCHAR2(40) not null,
    USER_BIRTH TIMESTAMP not null,
    USER_GENDER VARCHAR2(1) not null,
    USER_ADDR VARCHAR2(200) not null,
    USER_PH1 VARCHAR2(13),
    USER_PH2 VARCHAR2(13),
    USER_REGIST TIMESTAMP default sysdate,
    USER_EMAIL VARCHAR2(200),
    JOIN_OK VARCHAR2(500)
);

CREATE TABLE board (
    BOARD_NUM NUMBER not null,
    user_id VARCHAR2(20) not null,
    BOARD_NAME VARCHAR2(20) not null,
    BOARD_PASS VARCHAR2(200) not null,
    BOARD_SUBJECT VARCHAR2(100) not null,
    BOARD_CONTENT VARCHAR2(2000) not null,
    BOARD_DATE TIMESTAMP default sysdate,
    READ_COUNT NUMBER default 0,
    IP_ADDR VARCHAR2(15)
);

-- primary_key.sql
-- alter �� �̿��Ͽ� table ���� ����
-- constraint �߰�
ALTER TABLE member
ADD CONSTRAINT member_user_id_PK PRIMARY KEY(user_id);
ALTER TABLE member
ADD CONSTRAINT member_user_email_UK UNIQUE(user_email);

ALTER TABLE board
ADD CONSTRAINT board_board_num_PK PRIMARY KEY(board_num, user_id);

-- foreign_key.sql
ALTER TABLE board
ADD CONSTRAINT board_user_id_FK FOREIGN KEY(user_id) REFERENCES member(user_id);

INSERT INTO member(user_id, user_pw, user_name, user_birth, user_gender, user_addr, user_ph1, user_ph2, user_email, user_regist)
VALUES ('test', '111111', 'test', '1999-12-12', '1', '����', '010-1234-2345', null, 'test@naver.com', default);

INSERT INTO member(user_id, user_pw, user_name, user_birth, user_gender, user_addr, user_ph1, user_ph2, user_email, user_regist)
VALUES ('test', '111111', 'test', '1999-12-12', '1', '����', '010-1234-2345', null, 'test@naver.com', default);

INSERT INTO member(user_id, user_pw, user_name, user_birth, user_gender, user_addr, user_ph1, user_ph2, user_email, user_regist)
VALUES ('test2', '111111', 'test', '1999-12-12', '1', '����', '010-1234-2345', null, 'test@naver.com', default);

SELECT
    *
FROM member;

INSERT INTO board(board_num, user_id, board_name, board_pass, board_subject, board_content, ip_addr)
VALUES (1, 'test', 'QnA', '111', '����', '����', '000.000.000.000');

INSERT INTO board(board_num, user_id, board_name, board_pass, board_subject, board_content, ip_addr)
VALUES (2, 'aaaaa', 'QnA2', '111', '����2', '����2', '000.000.000.111');

SELECT
    *
FROM board;

DELETE FROM board
WHERE user_id = 'test';

DELETE FROM member
WHERE user_id = 'test';

-- �θ� ���� �� �� �ڽ� �����͵� ���� ���� �� �� �ְ� ����.
ALTER TABLE board
DROP CONSTRAINT board_user_id_FK;

ALTER TABLE board
ADD CONSTRAINT board_user_id_FK FOREIGN KEY(user_id) REFERENCES member(user_id) on delete cascade;