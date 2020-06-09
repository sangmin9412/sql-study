-- unique_key.sql
ALTER TABLE member
DROP CONSTRAINT member_user_email_UK;
ALTER TABLE member
ADD CONSTRAINT member_user_email_UK UNIQUE(user_email);