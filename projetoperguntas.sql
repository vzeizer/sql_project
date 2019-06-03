
-- AQUI SERAO EXIBIDAS AS PERGUNTAS QUE SERÃO RESPONDIDAS 
-- ATRAVÉS DE CONSULTAS SQL DO BANCO DE DADOS CHINOOK


1. Quais são os quatro melhores clientes alemães?
O melhor cliente é considerado como aquele que gastou mais.

SELECT Invoice.Customerid,Customer.FirstName,
sum(InvoiceLine.Quantity*InvoiceLine.UnitPrice)
FROM Invoice
join Customer
on Customer.Customerid=Invoice.Customerid
join InvoiceLine
on Invoice.Invoiceid=InvoiceLine.InvoiceId
where Customer.Country='Germany'
group by 1
order by 3 desc
LIMIT 4;





2. Determine todos os clientes que compram mais do que 21
dólares no total do gênero rock.


SELECT distinct Customer.Email,Customer.FirstName,
Customer.LastName,Genre.GenreId,sum(InvoiceLine.Quantity*InvoiceLine.UnitPrice)
FROM Invoice
join Customer
on Customer.Customerid=Invoice.Customerid
join InvoiceLine
on Invoice.Invoiceid=InvoiceLine.InvoiceId
join Track
on Track.TrackId=InvoiceLine.TrackId
join Genre
on Genre.GenreId=Track.GenreId
where Genre.Name='Rock'
group by 2
having sum(InvoiceLine.Quantity*InvoiceLine.UnitPrice)> 21.
order by 5 desc


--limit, top, sum()

3. Quais foram os top 5 compositores para o gênero Rock que 
mais venderam em quantidade? Faça a sua tabela com colunas
contendo o compositor e a quantidade vendida.


select distinct Track.Composer,sum(InvoiceLine.Quantity)
from Track 
join InvoiceLine 
on Track.TrackId = InvoiceLine.TrackId
join Genre 
on Genre.GenreId=Track.GenreId
where Genre.Name='Rock'
group by 1
order by 2 desc
limit 7

-- coloquei 7 em limit porque há um null e J. C. Fogerty aparece
-- duas vezes, que é devido a um espaço deletado em uma forma de escrever
-- o nome dele na database. Então, o correto é colocar J. C. Fogerty
-- em segundo com 35 (19+16).






-- usar Playlist e PlaylistTrack

4. Qual tipo de playlist tem mais faturas?
Dê como resultado o tipo de playlist que tem mais faturas
e o seu correspondente total de faturas.
Mostre os cinco primeiros.

select Playlist.Name,count(Invoice.Total)
from Track
join PlaylistTrack
on Track.TrackId=PlaylistTrack.TrackId
join Playlist
on PlaylistTrack.PlaylistId=Playlist.PlaylistId
join InvoiceLine
on InvoiceLine.TrackId=Track.TrackId
join Invoice
on Invoice.InvoiceId=InvoiceLine.InvoiceId
group by 1
order by 2 desc
limit 5
