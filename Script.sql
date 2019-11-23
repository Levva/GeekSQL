drop database if exists vk;
create database vk;
use vk;

drop table if exists users;
create table users (
	id serial primary key,
	firstname varchar(100) comment 'Имя',
	lastname varchar(100) comment 'Фамилия',
	email varchar(120) unique,
	password_hach varchar(100),
	phone bigint,
	
	index users_phone_idx(phone),
	index (firstname, lastname)
	
);

drop table if exists profiles;
create table profiles (
	user_id serial primary key,
	gender char(1),
	birthday date,
	photo_id bigint unsigned null,
	hometown varchar(100),
	created_at datetime default now(),
	
	foreign key (user_id) references users(id) 	on update cascade on delete restrict
);
	
drop table if exists messages;
create table messages (
	id serial primary key,
	from_user_id bigint unsigned not null,
	to_user_id bigint unsigned null,
	body text, 
	created_at datetime default now(),
	
	index (from_user_id),
	index (to_user_id),
	foreign key (from_user_id) references users(id),
	foreign key (to_user_id) references users(id)
);

drop table if exists frend_request;
create table frend_request (
	initiator_user_id bigint unsigned not null,
	target_user_id bigint unsigned not null,
	status enum('requested', 'approved', 'declined', 'unfriended'),
	requested_at datetime default now(),
	updated_at datetime,
	
	primary key (initiator_user_id, target_user_id),
	
	index(initiator_user_id),
	index(target_user_id),
	
	foreign key (initiator_user_id) references users(id),
	foreign key (target_user_id) references users(id)
);

drop table if exists communities;
create table communities (
	id serial primary key,
	name varchar(150),
	
	index(name)
);

drop table if exists users_communities;
create table user_communities (
	user_id bigint unsigned not null,
	comminity_id bigint unsigned not null,
	
	primary key (user_id, comminity_id),
	
	foreign key (user_id) references users(id),
	foreign key (comminity_id) references communities(id)
);

drop table if exists media_types;
create table media_types (
	id serial primary key,
	name varchar(150),
	created_at datetime default now()
);

drop table if exists media;
create table media (
	id serial primary key,
	media_id bigint unsigned not null,
	user_id bigint unsigned not null,
	body text,
	file_name varchar(255),
	size_ int,
	metadata JSON,
	created_at datetime default now(),
	updated_at datetime default current_timestamp on update current_timestamp,
	
	index(user_id),
	foreign key (user_id) references users(id),
	foreign key (media_id) references media_types(id)
);

drop table if exists likes;
create table likes (
	id serial primary key,
	user_id bigint unsigned not null,
	media_id bigint unsigned not null,
	created_at datetime default now(),
	
	foreign key (user_id) references users(id),
	foreign key (media_id) references media(id)
);

drop table if exists photo_albums;
create table photo_albums (
	id serial primary key,
	name varchar(150),
	user_id bigint unsigned not null,
	
	foreign key (user_id) references users(id)
);

drop table if exists photos;
create table photos (
	id serial primary key,
	album_id bigint unsigned not null,
	media_id bigint unsigned not null,
	
	foreign key (album_id) references photo_albums(id),
	foreign key (media_id) references media(id)
);

alter table profiles
	add constraint
	foreign key (photo_id) references media(id);
