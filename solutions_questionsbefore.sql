Pergunta 1: Quais países possuem mais faturas?
Use a tabela Invoice (Fatura) para determinar quais países possuem mais faturas. 
Forneça as tabelas de BillingCountry (país de cobrança) e Invoices (faturas) 
ordenadas pelo número de faturas para cada país. 
O país com mais faturas deve aparecer primeiro.

-- solucao

SELECT BillingCountry,count(Invoice.Total)
FROM Invoice
join Customer
on Customer.Customerid=Invoice.Customerid
group by 1
order by 2 desc
LIMIT 10;


Pergunta 2: Qual cidade tem os melhores clientes?
Gostaríamos de lançar um festival de música promocional na cidade que nos gerou 
mais dinheiro. Escreva uma consulta que retorna a cidade que possui a maior 
soma dos totais de fatura. 
Retorne tanto o nome da cidade quanto a soma de todos os totais de fatura.

-- solucao

SELECT Invoice.BillingCity,
sum(Total)
FROM Invoice
join Customer
on Customer.Customerid=Invoice.Customerid
group by 1
order by 2 desc
LIMIT 10;


Verifique sua solução
A cidade com mais dólares em fatura foi Prague (Praga) com uma quantia de 90.24.





Pergunta 3: Quem é o melhor cliente?
O cliente que gastou mais dinheiro será declarado o melhor cliente. 
Crie uma consulta que retorna a pessoa que mais gastou dinheiro. 
Eu encontrei essa informação ao linkar três tabelas: Invoice (fatura), 
InvoiceLine (linha de faturamento), e Customer (cliente). Você provavelmente 
consegue achar a solução com menos tabelas!

Verifique sua solução
O cliente que mais gastou de acordo com as faturas foi o Cliente 6 com 49.62 
em compras.


-- solucao!!!

SELECT Invoice.Customerid,
sum(InvoiceLine.Quantity*InvoiceLine.UnitPrice)
FROM Invoice
join Customer
on Customer.Customerid=Invoice.Customerid
join InvoiceLine
on Invoice.Invoiceid=InvoiceLine.InvoiceId
group by 1
order by 2 desc
LIMIT 10;


Conjunto de Perguntas 2

Pergunta 1

Use sua consulta para retornar o e-mail, nome, sobrenome e gênero de todos 
os ouvintes de Rock. Retorne sua lista ordenada alfabeticamente por endereço 
de e-mail, começando por A. Você consegue encontrar um jeito de lidar com e-mails 
duplicados para que ninguém receba vários e-mails?

Eu escolhi linkar as informações das tabelas Customer (cliente), Invoice (fatura), 
InvoiceLine (linha de faturamento), Track (música) e Genre (gênero), 
mas você pode encontrar outra forma de obter a informação.


SELECT distinct Customer.Email,Customer.FirstName,
Customer.LastName,Genre.GenreId
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



Verifique sua solução

Com a minha consulta, descobri que todos os clientes possuem uma 
conexão ao Rock (você poderia ver isso olhando para o comprimento original 
da tabela de clientes. Sua tabela final deve ter 59 linhas e 4 colunas 
(se você quiser checar a conexão com 'Rock'). 

O cabeçalho da tabela é fornecido abaixo.






Pergunta 2: Quem está escrevendo as músicas de rock?

Agora que sabemos que nossos clientes amam rock, podemos decidir quais 
músicos convidar para tocar no show.

Vamos convidar os artistas que mais escreveram as músicas de rock em nosso 
banco de dados. Escreva uma consulta que retorna o nome do Artist (artista) 
e a contagem total de músicas das dez melhores bandas de rock.

Você precisará usar as tabelas Genre (gênero), Track (música) , Album (álbum),
 and Artist (artista).

-- solucao

SELECT distinct Artist.ArtistId,Artist.Name,
count(Album.AlbumId)
FROM Track
join Genre
on Genre.GenreId=Track.GenreId
join Album
on Album.AlbumId=Track.AlbumId
join Artist
on Artist.ArtistId=Album.ArtistId
where Genre.Name='Rock'
group by 1
order by 3 desc
limit 10


Verifique sua solução

As dez melhores bandas são mostradas abaixo junto do número de canções que 
cada uma possui em registro.


Pergunta 3

Primeiro, descubra qual artista ganhou mais de acordo com InvoiceLines 
(linhas de faturamento).

Agora encontre qual cliente gastou mais com o artista que você encontrou acima.

Para essa consulta, você precisará usar as tabelas Invoice (fatura), 
InvoiceLine (linha de faturamento), Track (música), Customer (cliente), 
Album (álbum) e Artist (artista).

Observe que essa consulta é complicada porque a quantia Total gasta na 
tabela Invoice (fatura) pode não ser em um só produto, então você precisa usar 
a tabela InvoiceLine (linha de faturamento) para descobrir quanto de cada 
produto foi comprado e, então, multiplicar isso pelo preço de cada artista.


SELECT Artist.Name, 
sum(InvoiceLine.UnitPrice*Quantity)
FROM Invoice
join Customer
on Customer.Customerid=Invoice.Customerid
join InvoiceLine
on Invoice.Invoiceid=InvoiceLine.InvoiceId
join Track
on Track.TrackId=InvoiceLine.TrackId
join Genre
on Genre.GenreId=Track.GenreId
join Album
on Album.AlbumId=Track.AlbumId
join Artist
on Artist.ArtistId=Album.ArtistId
group by 1
order by 2 desc
limit 10




SELECT Customer.FirstName,Customer.CustomerId, 
sum(InvoiceLine.UnitPrice*Quantity)
-- +sum(InvoiceLine.Quantity)*Track.UnitPrice total_spent
FROM Invoice
join Customer
on Customer.Customerid=Invoice.Customerid
join InvoiceLine
on Invoice.Invoiceid=InvoiceLine.InvoiceId
join Track
on Track.TrackId=InvoiceLine.TrackId
join Genre
on Genre.GenreId=Track.GenreId
join Album
on Album.AlbumId=Track.AlbumId
join Artist
on Artist.ArtistId=Album.ArtistId
where Artist.Name='Iron Maiden'
group by 1,2
order by 3 desc
limit 10


-- Verifique sua solução

Os artistas com maior faturamento são mostrados na tabela abaixo. 
Em primeiro lugar, temos Iron Maiden.


Continuação da solução com o maior comprador
Então, os maiores compradores são mostrados na tabela abaixo. O cliente com 
a maior quantia total em fatura é o cliente 55, Mark Taylor.





-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------
-----------------------------------------------------------------------------------

SQL Avançado:

Para resolver as perguntas que estão aqui, você precisa escrever uma consulta
que se estende além do conteúdo abordado nessas aulas. Essas perguntas estão 
aqui simplesmente para mostrar que há extensões do material que já abordamos, 
mas você definitivamente tem os blocos de construção necessários para enfrentar 
esses tópicos mais difíceis! Essas perguntas são dadas como material adicional 
para desafiar você! Cada uma das perguntas abaixo requer as ferramentas com 
as quais você já está familiarizado(a), mas elas também usam um novo método 
conhecido como uma SUBCONSULTA.

Pergunta 1

Queremos descobrir o gênero musical mais popular em cada país. Determinamos 
o gênero mais popular como o gênero com o maior número de compras. Escreva 
uma consulta que retorna cada país juntamente a seu gênero mais vendido. 
Para países onde o número máximo de compras é compartilhado retorne todos os gêneros.


Para essa consulta você precisará usar as tabelas Invoice (fatura), 
InvoiceLine (linha de faturamento), Track (música), Customer (cliente) 
e Genre (gênero).








Verifique sua solução

Embora existam apenas 24 países, a consulta deve retornar 25 linhas. 
As primeiras 11 linhas são mostradas na imagem abaixo. Observe que Argentina 
possui 2 gêneros que compartilham o máximo.

1-Purchases=9, Country=Argentina, Name=Alternative & Punk, GenreId=4


-- quase solucao

SELECT Customer.Country cty,Genre.Name nm, 
sum(InvoiceLine.Quantity) qtty1
-- +sum(InvoiceLine.Quantity)*Track.UnitPrice total_spent
FROM Invoice
join Customer
on Customer.Customerid=Invoice.Customerid
join InvoiceLine
on Invoice.Invoiceid=InvoiceLine.InvoiceId
join Track
on Track.TrackId=InvoiceLine.TrackId
join Genre
on Genre.GenreId=Track.GenreId
group by 1,2
order by 1 


Pergunta 2

Retorne todos os nomes de músicas que possuem um comprimento de canção 
maior que o comprimento médio de canção. Embora você possa fazer isso 
com duas consultas. Imagine que você queira que sua consulta atualize 
com base em onde os dados são colocados no banco de dados. Portanto, 
você não quer fazer um hard code da média na sua consulta. 
Você só precisa da tabela Track (música) para completar essa consulta.


Retorne o Name (nome) e os Milliseconds (milissegundos) para cada música. 
Ordene pelo comprimento da canção com as músicas mais longas sendo 
listadas primeiro.

-- solucao 


select Track.Name,Milliseconds
from Track
where Milliseconds >(SELECT avg(Milliseconds)
from Track)
order by 2 desc


Verifique sua solução

Abaixo temos uma imagem de como as primeiras dez linhas de sua tabela devem ser. 
Deve haver apenas 494 das 3503 músicas em sua tabela.

1 - Name = Occupation / Prepipice - Milliseconds = 5286953 




Pergunta 3

Escreva uma consulta que determina qual cliente gastou mais em músicas 
por país. Escreva uma consulta que retorna o país junto ao principal cliente 
e quanto ele gastou. Para países que compartilham a quantia total gasta, 
forneça todos os clientes que gastaram essa quantia.

Você só precisará usar as tabelas Customer (cliente) e Invoice (fatura).


Verifique sua solução

Embora existam apenas 24 países, a consulta deve retornar 25 linhas. 
As últimas 11 linhas são mostradas na imagem abaixo. Observe que o Reino Unido 
tem 2 clientes que compartilham o máximo.

15-Country = Ireland, TotalSpent=45.62,FirstName = Hugh, LastName=O Reilly,
CustomerId=46



