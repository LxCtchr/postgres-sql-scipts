/*Запрос на количество активных и неактивных пользователей + их процентное соотношение (подзапрос)*/
select is_active,
	count(*) as Количество,
	round(count(id)*100.0 / (select count(*) from users), 2) as Соотношение
from users
group by is_active

/*Запрос на количество пользователей, которые зарегестрировались от определенной компании*/
select c.name as Компания, count(*) as Количество_пользователей  
from users u
join company c
on u.company_id = c.id
group by c.name
order by Количество_пользователей desc

/*Запрос на количество пользователей, которые зарегестрировались от определенной компании + пользователи без компаний*/
select coalesce(c.name, 'Без компании') as Компания, count(*) as Количество_пользователей  
from users u
left join company c
on u.company_id = c.id
group by c.name
order by Количество_пользователей desc

/*
select *, to_char(entry_at, 'YYYY-MM-DD') as Дата_входа 
from userentry u
group by user_id 
*/


/*Запрос на количество авторизаций для каждого пользователя*/
select user_id , count(*) as Количество_авторизаций 
from userentry u
group by user_id
order by Количество_авторизаций desc

/*CTE - Common Table Expressions - результаты запроса, которые можно использовать множество раз в других запросах*/
/*Обобщенные табличные выражения - временные таблицы, которые будут жить только во время выполнения запроса, можно использовать в качестве виртуального источника данных*/
with temp_cte as (
select user_id , count(*) as Количество_авторизаций 
from userentry u
group by user_id
)
select *
from temp_cte
order by Количество_авторизаций desc