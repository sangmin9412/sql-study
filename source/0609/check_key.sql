-- check_key.sql
ALTER TABLE cart
DROP CONSTRAINT cart_qty_CK
DROP CONSTRAINT cart_total_price_CK;
ALTER TABLE cart
ADD CONSTRAINT cart_qty_CK CHECK (qty > 0)
ADD CONSTRAINT cart_total_price_CK CHECK (total_price = goods_price * qty);