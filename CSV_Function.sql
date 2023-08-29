

	DECLARE @CSV VARCHAR(MAX) = 'a123,b4567,c891011'
		,	@Delimiter CHAR(1) = ','

	CREATE TABLE #OutTable (ID INT IDENTITY(1,1), Field VARCHAR(MAX))
	DECLARE @CurrentPosition INT = 0
	DECLARE @NextPosition    INT = 1
	DECLARE @LengthOfString  INT    
  
	WHILE @NextPosition > 0  
	BEGIN  
		--Assign the next position to be the current index of delimiter + 1  
		SELECT @NextPosition = CHARINDEX(@Delimiter, @CSV, @CurrentPosition + 1) 
  
		--The position of delimiter and the length of the string segment in between.  
		SELECT @LengthOfString = CASE WHEN @NextPosition > 0 THEN @NextPosition ELSE LEN(@CSV) + 1 END - @CurrentPosition - 1  
  
		--After the length and position is found all we need to do is take the substring of the string passed in.  
		INSERT INTO #OutTable (Field)  
		VALUES (SUBSTRING(@CSV, @CurrentPosition + 1, @LengthOfString))
				
		SELECT	@CurrentPosition CurrentPosition
			,	@NextPosition NextPosition
			,	@LengthOfString LengthOfString
			,	@CSV Text
			,	SUBSTRING(@CSV, @CurrentPosition + 1, @LengthOfString) Field
  
		--Set the current position to the next position
		SELECT @CurrentPosition = @NextPosition
	END

	SELECT	* 
	FROM	#OutTable

	DROP TABLE #OutTable