DROP TABLE admin_users;
create table admin_users(
uname varchar(6) NOT NULL,
pw varchar(255),
PRIMARY KEY (uname)
);

insert into admin_users values ('admin', '81dc9bdb52d04dc20036dbd8313ed055');
insert into admin_users values ('akul', '6d00aa06c110d05eb2785f469a2442f8');