create database productdata;
use productdata;
create table productdetail(id int(5) not null auto_increment,
                           title varchar(50) not null,
                           type int not null,
                           image_urls json not null,
                           price double not null,
                           description text not null,
                           liked int(6) default null,
                           time Datetime not null,
						   longitude double(10,6) default null,
                           latitude double(10,6) default null,
                           primary key(id))DEFAULT CHARSET=utf8;