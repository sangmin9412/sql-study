alter table cart
drop constraint cart_qty_CK
drop constraint cart_total_price_CK;

alter table cart
add constraint cart_qty_CK check (qty > 0)
add constraint cart_total_price_CK check(total_price = GOODS_PRICE*qty);
]
alter table member
drop constraint member_UK;

alter table member
add constraint member_UK unique(user_id)