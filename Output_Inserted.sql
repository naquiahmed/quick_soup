
declare @got table (insertedID int)

declare @tbl table
(id int identity(1, 1)
, txt varchar(50)
)


insert into @tbl (txt)
output inserted.id into @got(insertedID)
select 'a' union  
select 'B' union 
select 'c' union 
select 'd' union 
select 'e' 


select * from @tbl
select * from @got