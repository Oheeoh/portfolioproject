--Module 3

--How many albums does the artist Led Zeppelin
have? 

select count(*) from (select *
from artists
left join albums
on artists.ArtistId=albums.ArtistId)
where Name='Led Zeppelin';


--Create a list of album titles and the unit prices for the artist "Audioslave".

select albums.title
,invoice_items.UnitPrice
,artists.Name
From tracks left join invoice_items on tracks.trackId = invoice_items.trackId
left join albums on albums.albumid = tracks.albumid
left join artists on artists.artistid = albums. artistid
where Artists.Name = 'Audioslave'

--Create a list of album titles and the unit prices for the artist "Audioslave".

select albums.title
,invoice_items.UnitPrice
,artists.Name
From tracks left join invoice_items on tracks.trackId = invoice_items.trackId
left join albums on albums.albumid = tracks.albumid
left join artists on artists.artistid = albums. artistid
where Artists.Name = 'Audioslave'

--does not have an invoice. Are there any customers returned from the query?  

select customers.firstname
,customers.lastname
,customers.customerId
,invoices.invoiceId
From customers left join invoices on customers.customerId = invoices.customerId
where invoices.invoiceId is null
order by customers.customerId

--How many records are created when you apply a Cartesian join to the invoice and invoice items table?

select invoices.invoiceId
From invoices cross join invoice_items


-----------------------------------------------------------------------------
Module 3 Coding Assignment

Join and subquery

select name
,albumId
from tracks
where albumId in (select albumId
from Albums
where title = 'Californication') 

SELECT FirstName
,LastName
,City
,Email
,COUNT(I.CustomerId) AS Invoices
FROM Customers C INNER JOIN Invoices I
ON C.CustomerId = I.CustomerId
GROUP BY C.CustomerI

Select tracks.trackId
,Tracks.Name as Artist
,Albums.Title as albums
From ((Tracks inner join Albums on Tracks.AlbumId = Albums.AlbumId)
Inner join Artists a 
on a.ArtistId = Albums.ArtistId)


select
M.LastName as manager
,E. LastName as Employees
From Employees E inner join Employees M
on E.reportsTo = M.EmployeeId



SELECT Name AS Artist
,Artists.ArtistId
,Albums.Title AS Album
FROM Artists
LEFT JOIN Albums
ON Artists.ArtistId = Albums.ArtistId
WHERE Album IS NULL

----using union 

select FirstName
,LastName
from employees
UNION
SELECT FirstName
,LastName
FROM Customers
ORDER BY LastName DESC

------
SELECT C.FirstName
,C.LastName
,C.City AS CustomerCity
,I.BillingCity
FROM Customers C
INNER JOIN Invoices I
ON C.CustomerId = I.CustomerId
WHERE CustomerCity != BillingCity
