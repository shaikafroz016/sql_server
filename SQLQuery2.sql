--creating database
create database emp
use emp
--creating tables
create table emp (empno int primary key,empname varchar(20),job varchar(20),deptno int,
salary int)

create table dept(deptno int primary key,deptname varchar(20),loc_name varchar(20))

--inserting into tables

insert into emp values(1001,'sam','manager',10,7000)
insert into emp values(1002,'sanjay','admin',10,6000)
insert into emp values(1003,'sarath','admin',10,8000)
insert into emp values(1004,'raju','dev',20,9000)
insert into emp values(1005,'raghav','dev',20,5000)
insert into emp values(1006,'nanada','dev',20,7000)
insert into emp values(1007,'david','manager',30,5000)
insert into emp values(1008,'peter','tester',30,6000)


--adding multiple values in a table at a time
insert into emp(empno,empname,job,deptno,salary)
values (1009,'shaik','se',45,86776),
	   (1010,'afnan','sd',67,84534);

insert into dept values(10,'Development','bangalore')
insert into dept values(20,'Testing','chennai')
insert into dept values(30,'HR','mumbai')

--updating values
update dept
set loc_name='hyderabad'
where deptno=20

--nested query
update dept
set loc_name='hyd'
where deptno=(select deptno from dept where deptname='HR')

--adding columns into existing tables and updating
alter table dept add coountry varchar(20);
update dept 
set coountry='india'
where coountry is null

--------views and joins
--view is a creating virtual table form two or more tables
create view full_details
as
select  job,deptname,empname,empno from emp as e
inner join dept as d
on e.deptno=d.deptno

--min,maax etc
select min(empno) as leastemp from emp 
select empno,empname,job,salary from emp
where empno=(select max(empno) from emp)
select sum(distinct salary) as sal from emp
select count(empname) as em from emp

---operators
select avg(salary) as avgsal from emp
where salary>=30000
select * from emp
where empname!='afnan'

------intersect and union
select * from emp
union 
select * from dept

---droping view
drop view full_details

---dropping tables
drop table emp,dept

----printing
select * from emp
select * from dept
select * from full_details order by empno
