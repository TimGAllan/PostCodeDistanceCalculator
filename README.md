# SQL Server UK PostCode Distance Calculator

A tool for calculating the distance between two UK Post distances and finding a list of all post codes within a certain number of kilometers.

## Finding all Postcodes within X kilometers

To find a list of postcodes within X kilometers, use the Table Function `postCodesWithinXkm`. For example, to find all Postcodes with 5 kilometers of SW1A 0AA, you can use the below code.

    SELECT * FROM postCodesWithinXkm('SW1A 0AA',5)


## Calculating the distance between two Postcodes

To determine the distance between two postcodes, use the Scalar function `distanceBetweenPostCodes`. For Example: to find the distance between SW1A 0AA and SE10 0DX, you can use the below code.

    SELECT distanceBetweenPostCodes('SW1A 0AA','SE10 0DX')

## How to deploy the database to your local SQL Server instance

1. Clone the repo
2. Open the Solution in Visual Studio
3. Open `PopPostCodes.sql` and edit the file location `'C:\Users\timga\source\repos\PostCodeDistanceCalculator\PostCodeDistanceCalculator\Files\ukpostcodes.csv'` to point to the correct 
4. Open the `PostCodeDistanceCalculator.publish.xml` and select the target Instance and database to deploy to.

 ***

*Contains Ordnance Survey data © Crown copyright and database right 2021*

*Contains Royal Mail data © Royal Mail copyright and database right 2021*

*Source: Office for National Statistics licensed under the Open Government Licence v.3.0*
