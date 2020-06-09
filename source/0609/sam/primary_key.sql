alter table member
drop constraint member_user_id_PK;

alter table member
add constraint member_user_id_PK primary key(user_id);

alter table board
drop constraint board_board_num_PK;

alter table board
add constraint board_board_num_PK primary key(board_num);

alter table goods
drop constraint goods_goods_num_pk;

alter table goods
add constraint goods_goods_num_pk primary key(goods_num);

alter table goods_ipgo
drop constraint goods_ipgo_SEQ_goods_num_PK;

alter table goods_ipgo
add constraint goods_ipgo_SEQ_goods_num_PK primary key(ipgo_SEQ,goods_num);

alter table  cart
drop constraint cart_PK;

alter table cart
add constraint cart_PK primary key(CART_NUM, GOODS_NUM, USER_ID);

alter table wish
drop constraint wish_PK;

alter table wish
add constraint wish_PK primary key(user_id, goods_num)


alter table comment1;
drop constraint comment_PK;

alter table comment1
add constraint comment_PK primary key(comment_no,cuser_id);


alter table reply
drop constraint reply_PK;

alter table reply
add constraint reply_PK primary key(reply_no,ruser_id,comment_no,cuser_id);
