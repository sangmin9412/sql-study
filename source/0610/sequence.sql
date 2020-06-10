-- sequence
desc member;

INSERT INTO member(user_id, user_pw, user_name, user_birth, user_gender, user_addr, user_ph1, user_email)
VALUES ('test', '111111', 'testName', '1994-12-24', 1, '서울', '010-2323-2323', 'test@gmail.com');

SELECT
    *
FROM member;

desc board;

-- 문제 24) 10부터 시작하고 2씩 증가하는 숫자 생성기를 만드는데 최대값은 999999이도록 한다. 생성기의 이름은 board_seq
CREATE SEQUENCE board_seq
INCREMENT BY 2 -- 증감 값
START WITH 10 -- 시작 값
MAXVALUE 999999
--NOCYCLE
--NOCACHE
;

DROP SEQUENCE board_seq;

-- nextval : 증가 된 값
-- currval : 현재 값
SELECT 
    board_seq.nextval
FROM dual;

SELECT
    board_seq.currval
FROM dual;

-- 문제 25) sequence 값을 board 의 board_num 에 사용하여 게시글을 저장
INSERT INTO board(board_num, user_id, board_name, board_pass, board_subject, board_content, ip_addr, read_count)
VALUES (board_seq.nextval, 'test', 'boardName', '111', '제목', '내용', '111.111.111.111', default);

SELECT
    *
FROM board;

-- 문제 26) comment 에 sequence 를 사용하지 말고 comment_no 에 1씩 증가하는 값을 가지도록 하자.
desc comment1;

-- 증가 하는 값을 얻기 위해 INSERT 에 서브쿼리를 사용하거나, CREATE SEQUENCE 를 사용하여 만들 수 있다.
-- 중복 값을 허용하지 않는 증감 값을 설정 해야할 경우 CREATE SEQUENCE 가 적합하고
-- 예) 게시판 넘버
-- 1부터 순차적으로 증가하는 값을 구해야 하는 경우 아래 서브쿼리를 사용하는 것이 적합하다
-- 예) 댓글 넘버
INSERT INTO comment1(comment_no, cuser_id, reg_date, comment_subject, comment_content)
VALUES ((
    SELECT
        nvl(max(comment_no), 0)+1
    FROM comment1
), 'test', default, '제목', '내용');

SELECT
    *
FROM comment1;

-- INDEX
-- 조건절에 사용하는 컬럼에 INDEX 를 사용한다. ex) primary key
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
