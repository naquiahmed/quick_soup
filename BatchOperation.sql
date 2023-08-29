DECLARE @min bigint, @max bigint, @batch bigint = 5000

SELECT @min = MIN(PRIMARY_COLUMN_NAME), @max = MAX(PRIMARY_COLUMN_NAME)
FROM [TABLE_NAME] WITH (NOLOCK)
where FESP_MODULE_PROVIDER_DEFINITION_ID_BRMP = 1

WHILE @min <= @max

BEGIN 

	[PERFORM BATCH OPERATIONS WITH BELOW WHERE CLAUSE]

	WHERE [PRIMARY_COLUMN_NAME] BETWEEN @min and (@min + @batch)

SET @min = @min + @batch

END