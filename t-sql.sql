--transact sql

declare 
@empno int,
@empname varchar(20),
@salary int,
@job varchar(20),
@deptno int;
begin
set @empno=231
set @empname='shaik'
set @salary =6000
set @job ='dev'
set @deptno =651
select @empno as emno,@empname as empname,@salary as sal
end

--same as above but wit procedure
create procedure sks
as
declare 
@empno int,
@empname varchar(20),
@salary int,
@job varchar(20),
@deptno int;
begin
set @empno=231
set @empname='shaik'
set @salary =6000
set @job ='dev'
set @deptno =651
select @empno as emno,@empname as empname,@salary as sal
end

exec sks


--procedure with emp number from emp table

create procedure sks1
as
declare 
@empno int,
@empname varchar(20),
@salary int,
@job varchar(20),
@deptno int;
begin
select @empno=empno ,@empname=empname,@job=job,@salary=salary,@deptno=deptno
from emp where deptno=10
select @empno as empno,@empname as empname
end

exec sks1

--procedure with parameters
create procedure sks2(@eno int)
as
declare 
@empno int,
@empname varchar(20),
@salary int,
@job varchar(20),
@deptno int;
begin
select @empno=empno ,@empname=empname,@job=job,@salary=salary,@deptno=deptno
from emp where deptno=@eno
select @empno as empno,@empname as empname
end

exec sks2 20

--procedure with if else
create procedure sks3(@eno int)
as
declare 
@empno int,
@empname varchar(20),
@salary int,
@job varchar(20),
@deptno int,
@tax int,
@netsal int;
begin
select @empno=empno ,@empname=empname,@job=job,@salary=salary,@deptno=deptno
from emp where deptno=@eno

if(@salary>=5000 and @salary<=7000)
begin
set @tax=@salary*5/100
set @netsal =@salary-@tax
end
else 
begin
set @tax=@salary*10/100
set @netsal =@salary-@tax
end
select @empno as empno,@empname as empname,@salary as sal,@tax as tax,@netsal as netsal
end

exec sks3 30

--the above one is only printing one record for printing all we need courcer to print all


create procedure getrec2
as
declare empcur cursor for select empno,empname,job,deptno,salary from emp
declare
@empno1 int,
@empname1 varchar(20),
@job1 varchar(20),
@deptno1 int,
@salary1 int,
@tax1 int,
@netsal1 int
begin
open empcur

fetch next from empcur into @empno1,@empname1,@job1,@deptno1,@salary1

while @@fetch_status=0
begin
if(@salary1 >= 8000 and @salary1 < 10000)
begin
set @tax1=@salary1*10/100;
set @netsal1=@salary1-@tax1;
end
else if(@salary1 >= 6000 and @salary1 < 8000)
begin
set @tax1=@salary1*6/100;
set @netsal1=@salary1-@tax1;
end
else if(@salary1 >= 4000 and @salary1 < 6000)
begin
set @tax1=@salary1*4/100;
set @netsal1=@salary1-@tax1;
end
else
begin
set @tax1=@salary1*2/100;
set @netsal1=@salary1-@tax1;
end
select @empno1 as empno, @empname1 as empname, @job1 as job,
@deptno1 as deptno ,@salary1 as salary ,@tax1 as tax,@netsal1 as netsalary 

fetch next from empcur into @empno1,@empname1,@job1,@deptno1,@salary1
end 
close empcur
deallocate empcur
end
exec getrec2

--simple courcer program
create procedure printall
as
declare emcourcer cursor for select empno,empname,job,deptno,salary from emp 
declare
@empno1 int,
@empname1 varchar(20),
@empjob1 varchar(20),
@deptno1 int,
@empsalary1 int;
begin
open emcourcer
fetch next from emcourcer into @empno1,@empname1,@empjob1,@deptno1,@empsalary1;
while @@FETCH_STATUS=0
begin
select @empno1 as empno,@empname1 as emname,@empjob1 as job,@empsalary1 as salary ,@deptno1 as deptno
fetch next from emcourcer into @empno1,@empname1,@empjob1,@deptno1,@empsalary1;
end
close emcourcer
deallocate emcourcer
end
exec printall


--functioms
create function f1(@eno int)
returns int
begin
declare @salary int
select @salary=salary from emp where empno=@eno
return @salary
end
select dbo.f1(1001)
select empno,empname,dbo.f1(empno) as salary from emp

--funtion with some logic
create function f2(@empno int)
returns varchar(20)
as
begin
declare @salary int,
@taxable varchar(20)
select @salary=salary from emp where empno=@empno
if(@salary >=6000)
set @taxable='taxable'
else
set @taxable='not taxable'
return @taxable
end

select empno,empname,salary,dbo.f2(empno) as taxable from emp

--ex-3
create function f3(@empno int)
returns int
as
begin
declare @salary1 int,
@tax1 int
select @salary1=salary from emp where empno=@empno
if(@salary1 >= 8000 and @salary1 < 10000)
begin
set @tax1=@salary1*10/100;
end
else if(@salary1 >= 6000 and @salary1 < 8000)
begin
set @tax1=@salary1*6/100;
end
else if(@salary1 >= 4000 and @salary1 < 6000)
begin
set @tax1=@salary1*4/100;
end
else
begin
set @tax1=@salary1*2/100;
end
return @tax1
end

select empno,empname,salary,dbo.f3(empno) as tax from emp

---accessing function in procedure


create procedure getrec4
as
declare empcur cursor for select empno,empname,job,deptno,salary from emp
declare
@empno1 int,
@empname1 varchar(20),
@job1 varchar(20),
@deptno1 int,
@salary1 int,
@tax1 int,
@netsal1 int
begin
open empcur

fetch next from empcur into @empno1,@empname1,@job1,@deptno1,@salary1

while @@fetch_status=0
begin

set @tax1=dbo.f3(@empno1)
select @empno1 as empno, @empname1 as empname, @job1 as job,
@deptno1 as deptno ,@salary1 as salary ,@tax1 as tax

fetch next from empcur into @empno1,@empname1,@job1,@deptno1,@salary1
end 
close empcur
deallocate empcur
end

exec getrec4

create function dbo.tab_val2()
returns table
as
return
select a.empno,a.empname,a.job,a.deptno,a.salary,b.deptname,b.locid,c.loc_name from 
emp a,dept b,location c where a.deptno=b.deptno and b.locid=c.locid

select empno,empname,deptname,loc_name from dbo.tab_val2();

--exception handling
create table log_table(id int,msg varchar(200))
begin try
declare @sal tinyint,@res tinyint
set @sal=250
set @res=@sal*100
select @sal as sal,@res as res
end try
begin catch
insert into log_table values(101,ERROR_MESSAGE());
end catch
select * from log_table