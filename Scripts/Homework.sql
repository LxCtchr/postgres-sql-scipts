/*
 * Нужно собрать базу контактов для email-рассылки. Почта указана
   абсолютно у всех, а вот имя/фамилия first_name и last_name - не у
   всех. В результате нужно получить 2 поля: email, full_name. Здесь
   email - почтовый адрес из базы, а full_name - это имя и фамилия,
   написанные через пробел. Причем если имя или фамилия в базе не
   указана, то вместо связки имя фамилия нужно вывести Дорогой друг.
 * */
select
	email,
	coalesce(users.first_name || ' ' ||  users.last_name, 'Дорогой друг') as full_name
from
	users
	
/*
 * @> is the "contains" operator.
 * Выведите полную информацию о тех пользователях, которые
 * зарегистрировались между 1 и 10 апреля 2022 года включительно.
 * */
select
	*
from
	users
where
	'[2022-04-01, 2022-04-10]'::daterange @> date_joined::date

/*
 * Нужно написать запрос, который «отрубает» доменное имя и собачку и сравнивает это с полем username.
 * */
select
	username,
	email,
	substr(email, 0, strpos(email, '@')) as email_trunc,
	substr(email, 0, strpos(email, '@')) = username as isEqual
from
	users
	
select
    username, email,
    left(email, position('@' in email) - 1) as email_trunc,
    lower(username) = lower(left(email, position('@' in email) - 1)) as isEqual
from users u

/**/
select *
from problem_to_company ptc 