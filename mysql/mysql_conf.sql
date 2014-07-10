create database jhousedb;
show databases;
use mysql
select host, user from user;
grant select on jhousedb.* to jhouse@172.17.42.1 identified by 'redhat';
