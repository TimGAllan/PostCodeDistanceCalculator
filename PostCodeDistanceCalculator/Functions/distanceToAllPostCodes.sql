CREATE FUNCTION distanceToAllPostCodes
(
	@postcode varchar(10)
)
RETURNS @t TABLE
(
	 postcode varchar(10)
	,distance float
)
AS
BEGIN
	INSERT @t
	SELECT 

	  a.postcode
	 ,dbo.distanceBetweenPostCodes(@postCode,a.postcode) As Distance

	FROM PostCodes a
	RETURN
END
