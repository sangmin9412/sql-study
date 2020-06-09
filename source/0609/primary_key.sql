-- primary_key.sql
ALTER TABLE member
DROP CONSTRAINT member_user_id_PK;
ALTER TABLE member
ADD CONSTRAINT member_user_id_PK PRIMARY KEY(user_id);

ALTER TABLE board
DROP CONSTRAINT board_board_num_user_id_PK;
ALTER TABLE board
ADD CONSTRAINT board_board_num_user_id_PK PRIMARY KEY(board_num, user_id);

ALTER TABLE goods
DROP CONSTRAINT goods_goods_num_PK;
ALTER TABLE goods
ADD CONSTRAINT goods_goods_num_PK PRIMARY KEY(goods_num);

ALTER TABLE goods_ipgo
DROP CONSTRAINT ipgo_seq_goods_num_PK;
ALTER TABLE goods_ipgo
ADD CONSTRAINT ipgo_seq_goods_num_PK PRIMARY KEY(ipgo_seq, goods_num);

ALTER TABLE cart
DROP CONSTRAINT cart_PK;
ALTER TABLE cart
ADD CONSTRAINT cart_PK PRIMARY KEY(cart_num, goods_num, user_id);

ALTER TABLE wish
DROP CONSTRAINT wish_PK;
ALTER TABLE wish
ADD CONSTRAINT wish_PK PRIMARY KEY(user_id, goods_num);

ALTER TABLE comment1
DROP CONSTRAINT comment_PK;
ALTER TABLE comment1
ADD CONSTRAINT comment_PK PRIMARY KEY(comment_no, cuser_id);

ALTER TABLE reply
DROP CONSTRAINT reply_PK;
ALTER TABLE reply
ADD CONSTRAINT reply_PK PRIMARY KEY(reply_no, ruser_id, comment_no, cuser_id);