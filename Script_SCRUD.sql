insert into users (id, firstname, lastname, email, phone)
values (1, 'Reuben', 'Nienow', 'test@test.ny', '1234567890');


insert into users (id, firstname, lastname, email, phone)
values (2, 'Reuben', 'Nienow', 'test2@test.org', null);


ALTER TABLE vk.users ADD is_deleted BIT DEFAULT 0 NOT NULL;

insert into users (id, firstname, lastname, email, phone, is_deleted)
values (3, 'Reuben', 'Nienow', 'test3@test.org', null, default);