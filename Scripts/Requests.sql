/*Запрос на количество активных и неактивных пользователей + их процентное соотношение (подзапрос)*/
select
	is_active,
	count(*) as Количество,
	round(count(id)* 100.0 / (select count(*) from users), 2) as Соотношение
from
	users
group by
	is_active

/*Запрос на количество пользователей, которые зарегестрировались от определенной компании*/
select
	c.name as Компания,
	count(*) as Количество_пользователей
from
	users u
join company c
on
	u.company_id = c.id
group by
	c.name
order by
	Количество_пользователей desc

/*Запрос на количество пользователей, которые зарегестрировались от определенной компании + пользователи без компаний*/
select
	coalesce(c.name, 'Без компании') as Компания,
	count(*) as Количество_пользователей
from
	users u
left join company c
on
	u.company_id = c.id
group by
	c.name
order by
	Количество_пользователей desc

/*
select *, to_char(entry_at, 'YYYY-MM-DD') as Дата_входа 
from userentry u
group by user_id 
*/


/*Запрос на количество авторизаций для каждого пользователя*/
select
	user_id ,
	count(*) as Количество_авторизаций
from
	userentry u
group by
	user_id
order by
	Количество_авторизаций desc

/*CTE - Common Table Expressions - результаты запроса, которые можно использовать множество раз в других запросах*/
/*Обобщенные табличные выражения - временные таблицы, которые будут жить только во время выполнения запроса, можно использовать в качестве виртуального источника данных*/
with temp_cte as (
select
	user_id ,
	count(*) as Количество_авторизаций
from
	userentry u
group by
	user_id
)
select
	*,
	case
		when temp_cte.Количество_авторизаций > 50 then 'A'
		when temp_cte.Количество_авторизаций > 20 then 'B'
		when temp_cte.Количество_авторизаций > 1 then 'C'
		else 'D'
	end Группы_пользователей
from
	temp_cte
order by
	Количество_авторизаций desc
	
/*Сегментация пользователй в зависимости от того, насколько хорошо пользователи решают задачи*/
select
	user_id,
	sum(1 - is_false) as count_correct,
	count(*) as all_tries,
	round(sum(1 - is_false)* 100.0 / count(*), 2) as winrate
from
	codesubmit c
group by
	user_id
having
	sum(1 - is_false) > 5
order by
	winrate desc
	
/*Сегментация пользователй в зависимости от того, насколько хорошо пользователи решают задачи + данные о количестве запусков кода для каждого пользователя*/
with temp_cte2 as (
select
	user_id,
	0 as is_correct,
	problem_id
from
	coderun c
union all
select
	user_id,
	1 - is_false,
	problem_id
from
	codesubmit cs 
)
select
	user_id,
	sum(is_correct) as count_correct,
	count(*) as all_tries,
	round(sum(is_correct)* 100.0 / count(*), 2) as winrate
from
	temp_cte2
group by
	user_id
having
	sum(is_correct) > 5
order by
	winrate desc
