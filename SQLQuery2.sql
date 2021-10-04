--creating database
create database emp
use emp
--creating tables
create table emp (empno int primary key,empname varchar(20),job varchar(20),deptno int,
salary int)

create table dept(deptno int primary key,deptname varchar(20),loc_name varchar(20))

create table location(locid int,loc_name varchar(20))
insert into location(locid,loc_name)
values (10,'hyderabad'),(20,'bang'),(30,'chennai');

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
---droping view
drop view full_details

--ex2 on view
create view netsalary
as
select empname,empno,salary,salary*10/100 as tax from emp
select empname,empno,salary,tax,salary-tax as netsal from netsalary

--working as objects ex-3
create view joinview
as
select a.empno,a.empname,a.job,a.deptno,a.salary,b.deptname,b.locid,c.loc_name from 
emp a,dept b,location c 
where a.deptno=b.deptno and b.locid=c.locid
select * from joinview

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

--using sequence
create sequence seq1 as int
start with 1002
increment by 1
maxvalue 9999
no cycle

create table tempEmp(empno int primary key,empname varchar(20),salary int)
--user1
insert into tempEmp values(1001,'sks',2000)
select * from tempEmp
--user2
insert into tempEmp values(next value for seq1,'peter',7000)
select * from tempEmp
--user3
insert into tempEmp values(next value for seq1,'rahul',8000)

insert into tempEmp values(next value for seq1,'sam',6000)
select * from tempEmp
drop table tempEmp

--adding all fields on coulmns
create table empCons(empno int primary key,empname varchar(20) not null,
emailid varchar(20) unique, deptno int constraint f_key_cons foreign key(deptno)
references dept(deptno),salary int check(salary between 5000 and 20000))
insert into empCons values(1001,'sam','sam@123',10,10000)
insert into empCons values(1004,'peter','pt@gmail',20,1220)
select * from empCons


---dropping tables
drop table emp,dept


---delete values
delete from emp where job='se'
delete from  emp where empname='afnan'
select * from emp order by salary


----printing
select * from emp
select * from dept
select * from full_details order by empno
