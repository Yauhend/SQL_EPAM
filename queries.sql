use courierservice;

-- выбираем имя и фамилию всех пользователей женского пола
SELECT 
    first_name, last_name
FROM
    user
WHERE
    sex = 0;

-- выбираем почтовые адреса для рассылки неподтвержденным пользователям
SELECT 
    e_mail
FROM
    user
WHERE
    is_verified IS FALSE;

-- ищем пользователя по телефону и паролю
SELECT 
    *
FROM
    user
WHERE
    phone = '375445956256'
        AND password = SHA1('1Password');

-- ищем заказы сделанные в определенный день

SELECT 
    *
FROM
    courierservice.order
WHERE
    CAST(time_placed AS DATE) = '2018-05-25';
    
-- вывести имена пользователей курьеров

SELECT 
    user.first_name, user.last_name, role.role
FROM
    user
        JOIN
    users_has_role ON user.id = users_id
        JOIN
    role ON role_role = role.role
WHERE
    role_role = 'courier';
    
 -- вывести общее количество пользователей по ролям, там где более одного пользователя в роли   
SELECT 
    COUNT(user.id), role.role
FROM
    user
        JOIN
    users_has_role ON user.id = users_id
        JOIN
    role ON role_role = role.role
GROUP BY role.role
HAVING COUNT(user.id) > 1;

-- вывести всех пользователей из Гродно и Витебска

SELECT 
    *
FROM
    user
WHERE
    adress LIKE 'Гродно%' 
UNION SELECT 
    *
FROM
    user
WHERE
    adress LIKE 'Витебск%';
    
    
    
    