-- sequence
desc member;

INSERT INTO member(user_id, user_pw, user_name, user_birth, user_gender, user_addr, user_ph1, user_email)
VALUES ('test', '111111', 'testName', '1994-12-24', 1, '����', '010-2323-2323', 'test@gmail.com');

SELECT
    *
FROM member;

desc board;

-- ���� 24) 10���� �����ϰ� 2�� �����ϴ� ���� �����⸦ ����µ� �ִ밪�� 999999�̵��� �Ѵ�. �������� �̸��� board_seq
CREATE SEQUENCE board_seq
INCREMENT BY 2 -- ���� ��
START WITH 10 -- ���� ��
MAXVALUE 999999
--NOCYCLE
--NOCACHE
;

DROP SEQUENCE board_seq;

-- nextval : ���� �� ��
-- currval : ���� ��
SELECT 
    board_seq.nextval
FROM dual;

SELECT
    board_seq.currval
FROM dual;

-- ���� 25) sequence ���� board �� board_num �� ����Ͽ� �Խñ��� ����
INSERT INTO board(board_num, user_id, board_name, board_pass, board_subject, board_content, ip_addr, read_count)
VALUES (board_seq.nextval, 'test', 'boardName', '111', '����', '����', '111.111.111.111', default);

SELECT
    *
FROM board;

-- ���� 26) comment �� sequence �� ������� ���� comment_no �� 1�� �����ϴ� ���� �������� ����.
desc comment1;

-- ���� �ϴ� ���� ��� ���� INSERT �� ���������� ����ϰų�, CREATE SEQUENCE �� ����Ͽ� ���� �� �ִ�.
-- �ߺ� ���� ������� �ʴ� ���� ���� ���� �ؾ��� ��� CREATE SEQUENCE �� �����ϰ�
-- ��) �Խ��� �ѹ�
-- 1���� ���������� �����ϴ� ���� ���ؾ� �ϴ� ��� �Ʒ� ���������� ����ϴ� ���� �����ϴ�
-- ��) ��� �ѹ�
INSERT INTO comment1(comment_no, cuser_id, reg_date, comment_subject, comment_content)
VALUES ((
    SELECT
        nvl(max(comment_no), 0)+1
    FROM comment1
), 'test', default, '����', '����');

SELECT
    *
FROM comment1;

-- INDEX
-- �������� ����ϴ� �÷��� INDEX �� ����Ѵ�. ex) primary key
SELECT
    *
FROM member;

CREATE INDEX member_reg
ON member(user_regist);

CREATE INDEX dept_job
ON employees(department_id, job_id);







SELECT
    *
FROM user_constraints
WHERE table_name = 'MEMBER';

SELECT
    *
FROM user_indexes
WHERE table_name = 'MEMBER';

SELECT
    *
FROM user_cons_columns
WHERE table_name = 'EMPLOYEES';
