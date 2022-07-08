CREATE FUNCTION postCodesWithinXkm
(
	@postCode varchar(10),
	@distance float
)
RETURNS @t TABLE
(
	PostCode varchar(10)
)
AS
BEGIN
	INSERT @t
	SELECT a.postcode
	FROM PostCodes a
	WHERE dbo.distanceBetweenPostCodes(@postCode,a.postcode)<@distance
	RETURN
END
