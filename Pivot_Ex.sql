/*
CREATE TABLE Product(Cust VARCHAR(25), Product VARCHAR(20), QTY INT)
GO
*/
------------------------------------- Inserting Data into Table
--INSERT INTO Product(Cust, Product, QTY)
--VALUES('KATE','VEG',2)
--INSERT INTO Product(Cust, Product, QTY)
--VALUES('KATE','SODA',6)
--INSERT INTO Product(Cust, Product, QTY)
--VALUES('KATE','MILK',1)
--INSERT INTO Product(Cust, Product, QTY)
--VALUES('KATE','BEER',3)
--INSERT INTO Product(Cust, Product, QTY)
--VALUES('KATE','BEER',4)
--INSERT INTO Product(Cust, Product, QTY)
--VALUES('KATE','VEG',5)
--INSERT INTO Product(Cust, Product, QTY)
--VALUES('KATE','VEG',5)
--INSERT INTO Product(Cust, Product, QTY)
--VALUES('KATE','BEER',12)
--INSERT INTO Product(Cust, Product, QTY)
--VALUES('FRED','MILK',3)
--INSERT INTO Product(Cust, Product, QTY)
--VALUES('FRED','BEER',24)
--INSERT INTO Product(Cust, Product, QTY)
--VALUES('KATE','VEG',3)
--GO

select ROW_NUMBER() over (order by Cust, Product),* from Product

--update  a set a.cust = 'FRED'
--from	(select ROW_NUMBER() over (order by Cust, Product) id, Cust from Product) a
--where   ID >= 8
GO

--with pr_CTE (id, Qty) as (select ROW_NUMBER() over (order by Cust, Product) id, QTY from Product )
--select AVG(qty) qty_Avg, AVG(ID) id_Avg from pr_CTE where id between 6 and 8
GO

SELECT * FROM Product

SELECT PRODUCT, FRED, KATE
FROM (	SELECT  PRODUCT, CUST, QTY
		FROM Product
	 ) up
PIVOT (SUM(QTY) FOR CUST IN (FRED, KATE)) AS pvt
ORDER BY PRODUCT


GO
/********************************************************************************/

--create table tbl (
--    color varchar(10), Paul int, John int, Tim int, Eric int);
--insert tbl select 
--    'Red' ,1 ,5 ,1 ,3 union all select
--    'Green' ,8 ,4 ,3 ,5 union all select
--    'Blue' ,2 ,2 ,9 ,1;

select * from Tbl    

select *
from tbl
unpivot (value for name in ([Paul],[John],[Tim],[Eric])) up
pivot (max(value) for color in ([Red],[Green],[Blue])) p

/********************************************************************************/

--CREATE TABLE dbo.Players
--(
--PlayerID INT
--, GoldBadge INT
--, SilverBadge INT
--, BronzeBadge INT
--);
--INSERT INTO dbo.Players (PlayerID, GoldBadge, SilverBadge, BronzeBadge)
--VALUES
--(5, 5, 4, 0),
--(6, 0, 9, 1),
--(7, 2, 4, 10);

select * from Players

declare @playerID int
declare @tbl table (id int, PlayerID int, Badge varchar(50), Value int)
declare curs cursor for 

	select playerID from players
	
	open curs
		fetch next from curs into @playerID
		while @@fetch_status = 0
			begin
				insert into @tbl
				select 1, PlayerID, 'Gold Badge'   Badge, GoldBadge   Value from Players where PlayerID = @playerID UNION
				select 2, PlayerID, 'Silver Badge' Badge, SilverBadge Value from Players where PlayerID = @playerID UNION 
				select 3, PlayerID, 'Bronze Badge' Badge, BronzeBadge Value from Players where PlayerID = @playerID

				fetch next from curs into @playerID
			end	
	close curs
deallocate curs

select * from @tbl order by playerID,ID