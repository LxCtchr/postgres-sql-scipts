/*������ �� ���������� �������� � ���������� ������������� + �� ���������� ����������� (���������)*/
select
	is_active,
	count(*) as ����������,
	round(count(id)* 100.0 / (select count(*) from users), 2) as �����������
from
	users
group by
	is_active

/*������ �� ���������� �������������, ������� ������������������ �� ������������ ��������*/
select
	c.name as ��������,
	count(*) as ����������_�������������
from
	users u
join company c
on
	u.company_id = c.id
group by
	c.name
order by
	����������_������������� desc

/*������ �� ���������� �������������, ������� ������������������ �� ������������ �������� + ������������ ��� ��������*/
select
	coalesce(c.name, '��� ��������') as ��������,
	count(*) as ����������_�������������
from
	users u
left join company c
on
	u.company_id = c.id
group by
	c.name
order by
	����������_������������� desc

/*
select *, to_char(entry_at, 'YYYY-MM-DD') as ����_����� 
from userentry u
group by user_id 
*/


/*������ �� ���������� ����������� ��� ������� ������������*/
select
	user_id ,
	count(*) as ����������_�����������
from
	userentry u
group by
	user_id
order by
	����������_����������� desc

/*CTE - Common Table Expressions - ���������� �������, ������� ����� ������������ ��������� ��� � ������ ��������*/
/*���������� ��������� ��������� - ��������� �������, ������� ����� ���� ������ �� ����� ���������� �������, ����� ������������ � �������� ������������ ��������� ������*/
with temp_cte as (
select
	user_id ,
	count(*) as ����������_�����������
from
	userentry u
group by
	user_id
)
select
	*,
	case
		when temp_cte.����������_����������� > 50 then 'A'
		when temp_cte.����������_����������� > 20 then 'B'
		when temp_cte.����������_����������� > 1 then 'C'
		else 'D'
	end ������_�������������
from
	temp_cte
order by
	����������_����������� desc
	
/*����������� ������������ � ����������� �� ����, ��������� ������ ������������ ������ ������*/
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
	
/*����������� ������������ � ����������� �� ����, ��������� ������ ������������ ������ ������ + ������ � ���������� �������� ���� ��� ������� ������������*/
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
