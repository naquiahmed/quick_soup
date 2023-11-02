ALTER DATABASE [DATABASE_NAME]
SET RECOVERY BULK_LOGGED;

------------------------------------------------------------------------
DECLARE	@LoopId SMALLINT
	,	@TableName VARCHAR(150)
	,	@SQLQuery VARCHAR(8000)
	,	@InsertedCount INT = 0

SET	@LoopId =	(	SELECT	TOP 1 RecId FROM [TABLE_NAME] 
				WHERE	[CONDITION]
				ORDER BY [ORDER_BY]
			)

WHILE	@LoopId IS NOT NULL

BEGIN
	UPDATE	[TABLE_NAME]						--Update Status
	SET	Status = 'Start'
	,	StartDateTime = GETDATE() 
	WHERE	RecId = @LoopId 

	SELECT @TableName = StaginationTableName FROM [TABLE_NAME] WHERE RecId = @LoopId

------------------------------------------------------------------------
	SET @SQLQuery =
	'INSERT INTO [FACT_TABLE] WITH (TABLOCK)
	SELECT [COLUMN_NAME]
	FROM ['+@TableName+'] STG WITH (NOLOCK)

	PRINT @SQLQuery
	EXEC (@SQLQuery)
	
	SET @InsertedCount = @@ROWCOUNT
	DBCC SHRINKFILE ('[DATABASE_NAME]_log', 1); 

--------------------------------------	
	UPDATE	[TABLE_NAME]						--Update Current Status
	SET	Status = 'Completed'
	,	EndDateTime = GETDATE() 
	WHERE	RecId = @LoopId 

--------------------------------------

	DBCC SHRINKFILE ('[DATABASE_NAME]_log', 1); 

------------------------------------------------------------------------	
SET	@LoopId =	(	SELECT	TOP 1 RecId FROM [TABLE_NAME] 
				WHERE	[CONDITION]
				ORDER BY [ORDER_BY]
			)

END

ALTER DATABASE [DATABASE_NAME]
SET RECOVERY SIMPLE;