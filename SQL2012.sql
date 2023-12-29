USE Lords
GO
-----------------------------------------------------------------------------

select * from Product
select * from tbl

-----------------------------------------------------------------------------
-- FIRST_VALUE() and LAST_VALUE()

SELECT
    Cust, Product, Qty
    , FIRST_VALUE (Qty) OVER (PARTITION BY Cust ORDER BY Qty ASC) AS LeastExpensive
    , LAST_VALUE (Qty) OVER (PARTITION BY Cust ORDER BY Qty ASC) AS MostExpensive
	, PERCENT_RANK() OVER (ORDER BY Qty ASC)
FROM Product;
 
-----------------------------------------------------------------------------
-- LAG()-- LEAD()

SELECT
    Product, Qty
 ,  LAG (Qty, 1, -1) OVER (ORDER BY Qty) AS LAG
 ,	LEAD (Qty, 1, -1) OVER (ORDER BY Qty) AS LEAD
FROM Product

-----------------------------------------------------------------------------
-- This will skip first 2 records and show next 3 records

select * from Product order by QTY, product, Cust

SELECT * FROM Product
ORDER BY QTY, product, Cust
OFFSET 2 ROWS
FETCH NEXT 3 ROWS ONLY;

-----------------------------------------------------------------------------
--Create a simple Sequence

CREATE SEQUENCE CountBy1
    START WITH 1
    INCREMENT BY 1 
	--MINVALUE 1
 --   MAXVALUE 5
 --   CYCLE ;
GO
 
-- Assign new ID sorted by First Name:

SELECT QTY, product, Cust,
    NEXT VALUE FOR CountBy1 OVER(ORDER BY Cust) as New_ID
FROM Product;
GO

--DROP SEQUENCE CountBy1

-----------------------------------------------------------------------------