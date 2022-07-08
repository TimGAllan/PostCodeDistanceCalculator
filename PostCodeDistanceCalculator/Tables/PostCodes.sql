CREATE TABLE PostCodes(
	 id			integer			not null
	,postcode	varchar(10)		not null primary key
	,latitude	float			null
	,longitude	float			null
)