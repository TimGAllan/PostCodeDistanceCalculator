CREATE FUNCTION distanceLatLonInKm(
	 @latitude1 float
	,@longitude1 float
	,@latitude2 float
	,@longitude2 float
) 
RETURNS FLOAT
AS
BEGIN

--The radius of the earth stored in km.
declare @radiusEarth	float= 6371 

--the latitudinal difference in radians
declare @deltaLatitude	float	= radians(@latitude2-@latitude1)

--the longitudinal difference in radians
declare @deltaLongitude float	= radians(@longitude2-@longitude1)

--haversine Formula
declare @a float = 
    sin(@deltaLatitude/2) * sin(@deltaLatitude/2) +
	cos(radians(@latitude1)) * cos(radians(@latitude2)) * 
	sin(@deltaLongitude/2) * sin(@deltaLongitude/2)
 
--calculating the radial distance between the two radii extend from the earth's core
declare @c float= 2 * atn2(sqrt(@a), sqrt(1-@a)); 

--calculating the distance in kms 
declare @distance float = @radiusEarth * @c

return @distance


END