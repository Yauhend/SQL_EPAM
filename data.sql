use courierservice;

insert into role
values ('admin'), ('customer'), ('courier');

alter table `user` change column `e-mail` `e_mail` varchar(45) not null unique;

insert into user (e_mail, password, first_name, last_name, sex, phone, adress, is_verified)
values	('tom@soyer.by', sha1('1Password'), 'Евгений', 'Дашкевич', 1, '375295646256', 'Минск, Толбухина 11', true),
		('chuk@soyer.by', sha1('2Password'), 'Петр', 'Пашкевич', 1, '375448945756', 'Минск, Гая 24', true),
        ('joke@soyer.by', sha1('3Password'), 'Сергей', 'Хлестов', 1, '375296889787', 'Минск, Левкова 15', true),
        ('tom@tut.by', sha1('4Password'), 'Анна', 'Петрова', 0, '375255646454', 'Минск, Бурдейного 31', true),
        ('t.yu@game.by', sha1('5Password'), 'Люция', 'Драгомилова', 0, '74955564478', 'Минск, Толбухина 11', true),
        ('luck@over.me', sha1('6Password'), 'Евгений', 'Дашкевич', 1, '375445952226', 'Минск, Нефтянников 211', true),
        ('pol@kiop.by', sha1('7Password'), 'Семен', 'Шарапов', 1, '375443336256', 'Минск, Ювелирная 7-11', true),
        ('brick@lego.by', sha1('8Password'), 'Александр', 'Дашкевич', 1, '375447776256', 'Минск, Жукова 14', true),
        ('box@post.by', sha1('9Password'), 'Виктория', 'Дашкевич', 0, '375447897894', 'Минск, Фролова 61', true),
        ('kruto@edem.by', sha1('10Password'), 'Андрей', 'Желтов', 1, '375297544487', 'Минск, Петрова 1', true),
        ('what@canitbe.by', sha1('11Password'), 'Виктор', 'Синий', 1, '375296555645',NULL, true),
        ('blog@yer.by', sha1('12Password'), 'Виктор', 'Дранчук', 1, '375296903241', NULL, false),
        ('huk@boxing.by', sha1('13Password'), 'Юрий', 'Гончаревич', 1, '375445958586', NULL, true),
        ('astero@phis.by', sha1('14Password'), 'Евгений', 'Петров', 1, '375445956666', 'Витебск, Толбухина 11', true),
        ('back@up.by', sha1('15Password'), 'Юлия', 'Шамкова', 0, '375445956897', 'Витебск, Мира 11', true),
        ('dog@cat.by', sha1('16Password'), 'Чу Ван', 'Ли', 0, '375445922556', 'Гродно, Орехова 5', true),
        ('yandex@tut.by', sha1('17Password'), 'Георгий', 'Георгиев', 1, '375445689856', 'Минск, Купревича 1-1', false),
        ('buffer@java.by', sha1('18Password'), 'Ральф', 'Шумахер', 1, '375441199256', 'Минск, Чернышевского 11', true),
        ('black@box.by', sha1('19Password'), 'Анатолий', 'Довнар', 1, '375445965487', 'Минск, Черного 11', false),
        ('asper@kasper.by', sha1('20Password'), 'Леонид', 'Дарков', 1, '375445222256', NULL, true);


insert into users_has_role
values	(1,'admin'),
		(2,'customer'),
        (3,'customer'),
        (4,'customer'),
        (5,'customer'),
        (6,'customer'),
        (7,'customer'),
        (8,'customer'),
        (9,'customer'),
        (10,'courier'),
        (11,'courier'),
        (12,'courier'),
        (13,'courier'),
        (14,'courier'),
        (15,'courier'),
        (16,'courier'),
        (17,'courier'),
        (18,'courier'),
        (19,'courier'),
        (20,'courier');
        
insert into users_has_role
values	
        (7,'courier'),
        (8,'courier'),
        (9,'courier'),        
        (17,'customer'),
        (18,'customer'),
        (19,'customer'),
        (20,'customer');
		
insert into transport (name, capacity, volume, user_id)
values	('велосипед с багажником',10, null, 10),
		('мопед',10, null, 10),
        ('автомобиль',150, 500, 7),
        ('велосипед с багажником',7, null, 18),
        ('грузовик',1000, 2500, 14),
        ('грузовик',1500, 2500, 20),
        ('грузовик',1500, 3000, 11);
        
insert into cargo_type
values ('почта'), ('грузы'), ('цветы'), ('документы'), ('продукты');

insert into courierservice.transport_has_cargo_type
values	(1, 'почта'),
		(1, 'цветы'),
        (1, 'документы'),
        (2, 'почта'),
        (2, 'цветы'),
        (2, 'документы'),
        (3, 'почта'),
        (4, 'почта'),
        (5, 'грузы'),
        (5, 'почта'),
        (6, 'грузы'),
        (6, 'почта'),
        (3, 'грузы'),
        (3, 'цветы'),
        (3, 'продукты');


insert into courierservice.order 
values 	(1,'Купревича 1', 'Одинцова 20', '2018-05-25 15:25:11', 10, '2018-05-26 22:00:00', null, 'placed', null, 17, 7, 'цветы', null),
		(2,'Купревича 1', 'Одинцова 20', '2018-05-25 16:20:01', 10, '2018-05-26 22:00:00', '2018-05-26 19:34:07', 'done', 4, 17, 10, 'цветы', 1),
        (3,'Толбухина 11', 'Горецкого 22', '2018-05-27 11:25:11', 10, null, '2018-05-27 19:05:41', 'done', 5, 20, 9, 'документы', null),
        (4,'Одинцова 20', 'Купревича 1', '2018-05-28 07:00:11', 10, '2018-05-28 13:00:00', null, 'done', null, 6, 10, 'почта', null);
        
