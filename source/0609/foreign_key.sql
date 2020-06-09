-- foreign_key.sql
ALTER TABLE board
DROP CONSTRAINT board_user_id_FK;
ALTER TABLE board
ADD CONSTRAINT board_user_id_FK FOREIGN KEY(user_id) REFERENCES member(user_id) ON DELETE CASCADE;

ALTER TABLE goods
DROP CONSTRAINT goods_user_id_FK;
ALTER TABLE goods
ADD CONSTRAINT goods_user_id_FK FOREIGN KEY(user_id) REFERENCES member(user_id) ON DELETE SET NULL;

ALTER TABLE goods_ipgo
DROP CONSTRAINT goods_ipgo_goods_num_FK;
ALTER TABLE goods_ipgo
ADD CONSTRAINT goods_ipgo_goods_num_FK FOREIGN KEY(goods_num) REFERENCES goods(goods_num) ON DELETE CASCADE;

ALTER TABLE cart
DROP CONSTRAINT cart_goods_seq_FK;
ALTER TABLE cart
ADD CONSTRAINT cart_goods_seq_FK FOREIGN KEY(goods_num) REFERENCES goods(goods_num) ON DELETE CASCADE;

ALTER TABLE cart
DROP CONSTRAINT cart_user_id_FK;
ALTER TABLE cart
ADD CONSTRAINT cart_user_id_FK FOREIGN KEY(user_id) REFERENCES member(user_id) ON DELETE CASCADE;

ALTER TABLE wish
DROP CONSTRAINT wish_user_id_FK;
ALTER TABLE wish
ADD CONSTRAINT wish_user_id_FK FOREIGN KEY(user_id) REFERENCES member(user_id) ON DELETE CASCADE;

ALTER TABLE wish
DROP CONSTRAINT wish_goods_num_FK;
ALTER TABLE wish
ADD CONSTRAINT wish_goods_num_FK FOREIGN KEY(goods_num) REFERENCES goods(goods_num) ON DELETE CASCADE;

ALTER TABLE comment1
DROP CONSTRAINT comment_user_id_FK;
ALTER TABLE comment1
ADD CONSTRAINT comment_user_id_FK FOREIGN KEY(cuser_id) REFERENCES member(user_id) ON DELETE CASCADE;

ALTER TABLE reply
DROP CONSTRAINT reply_ruser_id_FK;
ALTER TABLE reply
ADD CONSTRAINT reply_ruser_id_FK FOREIGN KEY(ruser_id) REFERENCES member(user_id) ON DELETE CASCADE;

ALTER TABLE reply
DROP CONSTRAINT reply_comment1_FK;
ALTER TABLE reply
ADD CONSTRAINT reply_comment1_FK FOREIGN KEY(comment_no, cuser_id) REFERENCES comment1(comment_no, cuser_id) ON DELETE CASCADE;