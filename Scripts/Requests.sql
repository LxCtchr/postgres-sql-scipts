/*������ �� ���������� �������� � ���������� ������������� + �� ���������� ����������� (���������)*/
select is_active,
	count(*) as ����������,
	round(count(id)*100.0 / (select count(*) from users), 2) as �����������
from users
group by is_active

/*������ �� ���������� �������������, ������� ������������������ �� ������������ ��������*/
select c.name as ��������, count(*) as ����������_�������������  
from users u
join company c
on u.company_id = c.id
group by c.name
order by ����������_������������� desc

/*������ �� ���������� �������������, ������� ������������������ �� ������������ �������� + ������������ ��� ��������*/
select coalesce(c.name, '��� ��������') as ��������, count(*) as ����������_�������������  
from users u
left join company c
on u.company_id = c.id
group by c.name
order by ����������_������������� desc

/*
select *, to_char(entry_at, 'YYYY-MM-DD') as ����_����� 
from userentry u
group by user_id 
*/


/*������ �� ���������� ����������� ��� ������� ������������*/
select user_id , count(*) as ����������_����������� 
from userentry u
group by user_id
order by ����������_����������� desc

/*CTE - Common Table Expressions - ���������� �������, ������� ����� ������������ ��������� ��� � ������ ��������*/
/*���������� ��������� ��������� - ��������� �������, ������� ����� ���� ������ �� ����� ���������� �������, ����� ������������ � �������� ������������ ��������� ������*/
with temp_cte as (
select user_id , count(*) as ����������_����������� 
from userentry u
group by user_id
)
select *
from temp_cte
order by ����������_����������� desc