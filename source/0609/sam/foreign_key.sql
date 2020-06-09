alter table board
drop constraint board_user_id_FK

alter table board
add constraint board_user_id_FK foreign key(user_id)
references member(user_id)  on delete cascade;


alter table goods
drop constraint goods_user_id_FK

alter table goods
add constraint goods_user_id_FK foreign key(user_id)
references member(user_id) ON DELETE SET NULL;

alter table goods_ipgo
drop constraint goods_ipgo_goods_num_FK; 

alter table goods_ipgo
add constraint goods_ipgo_goods_num_FK foreign key(goods_num)
references goods(goods_num) on delete cascade;

alter table cart
drop constraint cart_GOODS_SEQ_FK;

alter table cart
add constraint cart_GOODS_SEQ_FK foreign key(GOODS_NUM)
    references goods(goods_num) on delete cascade; 


alter table cart
drop constraint cart_goods_user_id_FK;

alter table cart
add constraint cart_goods_user_id_FK foreign key(user_id)
     references member(user_id) on delete cascade;

alter table wish
drop constraint wish_user_id_FK; 

alter table wish
add constraint wish_user_id_FK foreign key(user_id)
    references member(user_id) on delete cascade;

alter table wish
drop constraint wish_goods_num_FK;

alter table wish
add constraint wish_goods_num_FK foreign key(goods_num)	 
	references goods(goods_num) on delete cascade;

alter table comment1
drop constraint comment1_user_id_FK;

alter table comment1
add constraint comment1_user_id_FK foreign key(cuser_id)
	references member(user_id) on delete cascade;

alter table reply
drop constraint reply_ruser_id_FK;

alter table reply
add constraint reply_ruser_id_FK foreign key(ruser_id)
	references member(user_id)on delete cascade;

alter table reply
drop constraint reply_comment1_FK;

alter table reply
add constraint reply_comment1_FK foreign key(comment_no,cuser_id)
	references comment1(comment_no,cuser_id)on delete cascade;


