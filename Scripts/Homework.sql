/*
 * ����� ������� ���� ��������� ��� email-��������. ����� �������
   ��������� � ����, � ��� ���/������� first_name � last_name - �� �
   ����. � ���������� ����� �������� 2 ����: email, full_name. �����
   email - �������� ����� �� ����, � full_name - ��� ��� � �������,
   ���������� ����� ������. ������ ���� ��� ��� ������� � ���� ��
   �������, �� ������ ������ ��� ������� ����� ������� ������� ����.
 * */
select
	email,
	coalesce(users.first_name || ' ' ||  users.last_name, '������� ����') as full_name
from
	users
	
/*
 * @> is the "contains" operator.
 * �������� ������ ���������� � ��� �������������, �������
 * ������������������ ����� 1 � 10 ������ 2022 ���� ������������.
 * */
select
	*
from
	users
where
	'[2022-04-01, 2022-04-10]'::daterange @> date_joined::date

/*
 * ����� �������� ������, ������� ��������� �������� ��� � ������� � ���������� ��� � ����� username.
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