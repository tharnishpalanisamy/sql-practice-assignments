create table accounts(
accno int primary key , 
balance decimal(10,2) 
)

insert into accounts values
(1,10000) , 
(2,20000) , 
(3,15000)  


create login test with password = 'test' ;
use tharnish
create user test for login test 
grant select on accounts to test

grant control on accounts to test -- all access to the user 

grant select on accounts to test with grant option  --the user can give access to other user
 
revoke insert on accounts to test --revoke insert access

select * from accounts
insert into accounts values(9,7000)

DENY SELECT ON accounts TO test; -- no other can give select access to test