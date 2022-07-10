# SQL Server UK PostCode Distance Calculator

A tool for calculating the distance between two UK Post distances and finding a list of all post codes within a certain number of kilometers.

## Finding all Postcodes within X kilometers

To find a list of postcodes within X kilometers, use the Table Function `postCodesWithinXkm`. For example, to find all Postcodes with 5 kilometers of SW1A 0AA, you can use the below code.

    SELECT * FROM postCodesWithinXkm('SW1A 0AA',5)

## Calculating the distance between two Postcodes

To determine the distance between two postcodes, use the Scalar function `distanceBetweenPostCodes`. For Example: to find the distance between SW1A 0AA and SE10 0DX, you can use the below code.

    SELECT distanceBetweenPostCodes('SW1A 0AA','SE10 0DX')

## Returning a table with distance from one post to all Others

To find a list of all post codes and their distance to particular post, use the table function `distanceToAllPostCodes`

    SELECT * FROM dbo.distanceToAllPostCodes('SW1A 0AA') a


## Use Cases

Supose we have a CRM database containing a `Prospects` table containing a list of prospective client addresses and a `Branch` table containing all the addresses of our branches.

### Using `postCodesWithinXkm`

If we a particular Branch was running a prompotion and we want to notify all Prospective clients within 5 km of the branch, we could use the below code to obtain a list of all the Prospective clients we should contact.

    SELECT      a.ProspectName, a.ProspectEmail, a.PostCode
    FROM        CRM..Prospects a
    INNER JOIN  postCodesWithinXkm('PO19 1EL',5) b on a.PostCode = b.PostCode

The output would like something like:

| ProspectName      |ProspectEmail        | PostCode     |
| -----------       | -----------         |-----------   |
| Acme Corp Ltd     | jo@acme.co.uk       |PO18 0AE      |
| Tools4u Ltd       | Ned@tools4u.com     |PO20 2GU      |
| Hal's meats       | hal@halsmeats.co.uk |PO19 7EY      |

### Using `distanceBetweenPostCodes`

 We could use the code below to determine the number of Prospects within 5 km of each of our branches.

    SELECT      a.PostCode As BranchPostcode, a.BranchName, count(b.Id) As CustomerCount
    FROM        CRM..Branches a
    INNER JOIN  CRM..Prospects b 
    ON PostCodeDistanceCalculator.dbo.distanceBetweenPostCodes(a.PostCode,b.PostCode)<5
    GROUP BY    a.PostCode

The output would like something like:

| Branch Postcode   | Branch        | Customers    |
| -----------       | -----------   |-----------   |
| BN1 2RE           | Brighton      |15            |
| PO19 1EL          | Chicester     |37            |
| W4 5TA            | Chiswick      |89            |

### Using `distanceToAllPostCodes`

Suppose we wanted to determine the closest Branch for each Prospective Client. We can make use of `distanceToAllPostCodes` to determine the distance of each branch to each Prospective client and order by the closet.

    SELECT  a.ProspectName, c.BranchName, b.distance, 
            ROW_NUMBER() OVER (PARTITION BY a.ProspectName ORDER BY b.distance ) As DistanceRank
    FROM        CRM..Prospects a
    CROSS APPLY PostCodeDistanceCalculator.dbo.distanceToAllPostCodes(a.PostCode) b
    INNER JOIN  CRM..Branches c on b.Postcode = c.Postcode

The output would like something like:

| ProspectName      | BranchName    | Distance          |
| -----------       | -----------   |-----------        |
| Acme Corp Ltd     | Brighton      |7.477788367078679  |
| Acme Corp Ltd     | Chicester     |82.13621491096778  |
| Acme Corp Ltd     | Chiswick      |86.65279491895977  |


## How to deploy the database to your local SQL Server instance

1. Clone the repo
2. Open the Solution in Visual Studio
3. Open `PopPostCodes.sql` and edit the file location `'C:\Users\timga\source\repos\PostCodeDistanceCalculator\PostCodeDistanceCalculator\Files\ukpostcodes.csv'` to point to the correct location.
4. Open the `PostCodeDistanceCalculator.publish.xml` and select the target Instance and database to deploy to.

 ***

*Contains Ordnance Survey data © Crown copyright and database right 2021*

*Contains Royal Mail data © Royal Mail copyright and database right 2021*

*Source: Office for National Statistics licensed under the Open Government Licence v.3.0*
