CREATE FUNCTION distanceBetweenPostCodes
(
	@postCode1 varchar(10),
	@postCode2 varchar(10)
)
RETURNS FLOAT
AS
BEGIN

declare	
 @latitude1	 float
,@longitude1 float
,@latitude2	 float
,@longitude2 float

SELECT @latitude1=a.latitude, @longitude1=a.longitude FROM PostCodes a where a.postcode = @postCode1
SELECT @latitude2=a.latitude, @longitude2=a.longitude FROM PostCodes a where a.postcode = @postCode2

return dbo.distanceLatLonInKm(@latitude1,@longitude1,@latitude2,@longitude2)

END
