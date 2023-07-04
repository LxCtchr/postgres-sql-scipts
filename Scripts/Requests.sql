/*Запрос на количество активных и неактивных пользователей + их процентное соотношение*/
select is_active,
	count(*) as Количество,
	round(count(id)*100.0 / (select count(*) from users), 2) as Соотношение
from users
group by is_active

select * from company c 