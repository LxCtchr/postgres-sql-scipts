/*������ �� ���������� �������� � ���������� ������������� + �� ���������� �����������*/
select is_active,
	count(*) as ����������,
	round(count(id)*100.0 / (select count(*) from users), 2) as �����������
from users
group by is_active

select * from company c 