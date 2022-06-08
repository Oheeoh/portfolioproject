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
