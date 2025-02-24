DROP SCHEMA IF EXISTS sample;
CREATE SCHEMA sample;
USE sample;

DROP TABLE IF EXISTS user;

create table user (id int, name varchar(32), email varchar(32));
insert user (id, name, email) values (1, 'John', 'john@examp.com');
insert user (id, name, email) values (2, 'Kon', 'kon@examp.com');