CREATE PROCEDURE PopPostCodes
AS
BEGIN

BULK INSERT PostCodes
FROM 'C:\Users\timga\source\repos\PostCodeDistanceCalculator\PostCodeDistanceCalculator\Files\ukpostcodes.csv'
WITH ( 
	 FORMAT = 'CSV'
	,FIRSTROW = 2);

END