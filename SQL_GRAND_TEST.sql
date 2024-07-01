--#### Schemas#### Schemas

--```sql
CREATE TABLE artists (
    artist_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    country VARCHAR(50) NOT NULL,
    birth_year INT NOT NULL
);

CREATE TABLE artworks (
    artwork_id INT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    artist_id INT NOT NULL,
    genre VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (artist_id) REFERENCES artists(artist_id)
);

CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    artwork_id INT NOT NULL,
    sale_date DATE NOT NULL,
    quantity INT NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (artwork_id) REFERENCES artworks(artwork_id)
);

INSERT INTO artists (artist_id, name, country, birth_year) VALUES
(1, 'Vincent van Gogh', 'Netherlands', 1853),
(2, 'Pablo Picasso', 'Spain', 1881),
(3, 'Leonardo da Vinci', 'Italy', 1452),
(4, 'Claude Monet', 'France', 1840),
(5, 'Salvador Dalí', 'Spain', 1904);

INSERT INTO artworks (artwork_id, title, artist_id, genre, price) VALUES
(1, 'Starry Night', 1, 'Post-Impressionism', 1000000.00),
(2, 'Guernica', 2, 'Cubism', 2000000.00),
(3, 'Mona Lisa', 3, 'Renaissance', 3000000.00),
(4, 'Water Lilies', 4, 'Impressionism', 500000.00),
(5, 'The Persistence of Memory', 5, 'Surrealism', 1500000.00);

INSERT INTO sales (sale_id, artwork_id, sale_date, quantity, total_amount) VALUES
(1, 1, '2024-01-15', 1, 1000000.00),
(2, 2, '2024-02-10', 1, 2000000.00),
(3, 3, '2024-03-05', 1, 3000000.00),
(4, 4, '2024-04-20', 2, 1000000.00);


select * from artists;
select * from artworks;
select * from sales;
--### Section 1: 1 mark each

--1. Write a query to display the artist names in uppercase.
select UPPER(name )from artists;

--2. Write a query to find the top 2 highest-priced artworks and the total quantity sold for each.
select top(2) artworks.price,sales.quantity from artworks
join sales on artworks.artwork_id=sales.sale_id
order by price desc


--3. Write a query to find the total amount of sales for the artwork 'Mona Lisa'.
select title, total_amount from sales 
join artworks on artworks.artwork_id= sales.sale_id 
where artist_id=3;

--4. Write a query to extract the year from the sale date of 'Guernica'.
select sales.sale_date,artworks.title from sales 
join artworks on sales.sale_id=artworks.artwork_id
where artist_id=2;

select * from artists;
select * from artworks;
select * from sales;

--### Section 2: 2 marks each

--5. Write a query to find the artworks that have the highest sale total for each genre.



--6. Write a query to rank artists by their total sales amount and display the top 3 artists.

--7. Write a query to display artists who have artworks in multiple genres.
select name

--8. Write a query to find the average price of artworks for each artist.

--9. Write a query to create a non-clustered index on the `sales` table to improve query performance for queries filtering by `artwork_id`.

--10. Write a query to find the artists who have sold more artworks than the average number of artworks sold per artist.

--11. Write a query to find the artists who have created artworks in both 'Cubism' and 'Surrealism' genres.

--12. Write a query to display artists whose birth year is earlier than the average birth year of artists from their country.

--13. Write a query to find the artworks that have been sold in both January and February 2024.

--14. Write a query to calculate the price of 'Starry Night' plus 10% tax.

--15. Write a query to display the artists whose average artwork price is higher than every artwork price in the 'Renaissance' genre.

--### Section 3: 3 Marks Questions

--16. Write a query to find artworks that have a higher price than the average price of artworks by the same artist.
select artwork_id,title,genre,price 
from artworks 
join artists on artworks.artwork_id=artists.artist_id

-- Task: Find employees whose salary is higher than the average salary of all employees in their department

select artwork_id,AVG(price) from artworks 
--group by artwork_id 

join artists on artworks.artwork_id=artists.artist_id
select* from artworks o
where o.price > (select AVG(price)
--from artworks as i where i.artwork_id=o.artwork_id)
select * from artworks
select * from artists

--17. Write a query to find the average price of artworks for each artist and only include artists whose average artwork price is higher than the overall average artwork price.

--18. Write a query to create a view that shows artists who have created artworks in multiple genres.

create view artists 


--### Section 4: 4 Marks Questions

--19. Write a query to convert the artists and their artworks into JSON format.
select
    artists.artist_id,
     artists.name as artist_name,
     artists.country,
     artists.birth_year,
    (
        select
            artworks.artwork_id,
            artworks.title AS book_title,
            artworks.genre,
            artworks.price
        from
            artworks
           where artworks.artist_id=artists.artist_id 
        for json path
    ) as artworks
from
    artists
for json path, root('artist');




--20. Write a query to export the artists and their artworks into XML format.
select
artists.artist_id as [artist/id],
artists.name as [artist/name],
artists.country as [artist/country],
artists.birth_year as [artist/birthyear],
(
select 
artworks.artwork_id[artworks/artworkid],
artworks.title[artwork/title],
artworks.genre[artwork/genre],
artworks.price[artwork/price]
from artworks 
where artworks.artist_id=artists.artist_id 
for xml path('artwork') ,type
) 
from artists
for xml path('artist'),root('artists');


--### Section 5: 5 Marks Questions

select * from artists;
select * from artworks;
select * from sales;


--21. Create a trigger to log changes to the `artworks` table into an `artworks_log` table, capturing the `artwork_id`, `title`, and a change description.

create table artworks_log
(
ID int Identity primary key ,
title varchar(50),
artwork_id int,
genre varchar(30),
Chagedescription text
);
 
select * from artworks_log
select * from artworks
go
Create Trigger trg_artlog
on artworks
After update
As
Begin 
     if update(genre)
	 begin
	  Insert into artworks_log
	select i.artwork_id,d.genre,i.genre
	from inserted i
	join Deleted d
    on i.artwork_id=d.artwork_id
	end
End
Update artworks
set genre = 'Cubism'
where artwork_id = 1

select * from artworks_log
select * from artworks




select * from artists;
select * from artworks;
select * from sales;
--22. Create a scalar function to calculate the average sales amount for artworks in a given genre and write a query to use this function for 'Impressionism'.
Create Function dbo.avgsales(avgsalesamount)
Returns varchar
As
Begin
	Return artwork_id,genre from artworks;
End; 
select avg(price), artwork_id,title,dbo.avgsalesamount([genre]) as Genree
from artworks
where artist_id=4;
select dbo.avgsalesamount(Impressionism);

--23. Create a stored procedure to add a new sale and update the total sales for the artwork. Ensure the quantity is positive, and use transactions to maintain data integrity.

--Ensure the price is positive, use transactions to ensure data integrity, and return the new average price.

 
 select * from sales select * from artworks
 go 
 CREATE PROCEDURE newsales
AS  
    SELECT * FROM sales;    
BEGIN TRY 
    Begin transaction
   commit transaction
END TRY  
BEGIN CATCH  
    rollback 
END CATCH; 
go 
Alter PROCEDURE newsales 
    @sale_id int,
	@artwork_id int,
	@quantity int,
	@total_amount Decimal(120,2)
As
Begin
	Begin Transaction;
	Begin Try
	if not Exists (Select total_amount from sales where total_amount>0)
		throw 60000, 'negative value!!', 1;
	
     insert into artworks values(
	@sale_id ,
	@artwork_id ,
	@quantity ,
	@total_amount)
 
	 SELECT total_amount From sales
 
	Commit Transaction;
	End Try
	Begin Catch
		Rollback Transaction;
		print Concat('Error number is: ', Error_number());
		print Concat('Error message is: ', Error_message());
		print Concat('Error state is: ', Error_State());
	End Catch
End
select*from sales
exec newsales @sale_id=1,
	@artwork_id=1,
	@quantity=3 ,
	@total_amount=3000000


--24. Create a multi-statement table-valued function (MTVF) to return the total quantity sold for each genre and use it in a query to display the results.
go 
Create Function dbo.totalquant(@artwork_id int, @genre varchar)
returns table
As
Return(
Select title
from artworks
	inner join sales
	on artworks.artwork_id=sales.sale_id
	inner join artworks
	on sales.sale_id=artworks.artwork_id
Where genre=@genre and artworks.artwork_id=@artwork_id
)
Select *
from dbo.totalquant;
 
--Select * from dbo.GetMoviesByBudgetRange('Action Comedy')
 
--25. Write a query to create an NTILE distribution of artists based on their total sales, divided into 4 tiles.

select * from artists;
select * from artworks;
select * from sales;

With Case_CTE
As
(
select artist_id,name,country,birth_year ,ntile(4) over (order by artist_id ) as grpname from artists
)
Select *,
	Case
	When grpname = 1 then '1'
	When grpname = 2 then '2'
	When grpname = 3 then '3'
	When grpname = 3 then '4'
	Else 'Leave the group'
	End as Category
from Case_CTE;


--### Normalization (5 Marks)

--26. **Question:**
--    Given the denormalized table `ecommerce_data` with sample data:

--| id  | customer_name | customer_email      | product_name | product_category | product_price | order_date | order_quantity | order_total_amount |
--| --- | ------------- | ------------------- | ------------ | ---------------- | ------------- | ---------- | -------------- | ------------------ |
--| 1   | Alice Johnson | alice@example.com   | Laptop       | Electronics      | 1200.00       | 2023-01-10 | 1              | 1200.00            |
--| 2   | Bob Smith     | bob@example.com     | Smartphone   | Electronics      | 800.00        | 2023-01-15 | 2              | 1600.00            |
--| 3   | Alice Johnson | alice@example.com   | Headphones   | Accessories      | 150.00        | 2023-01-20 | 2              | 300.00             |
--| 4   | Charlie Brown | charlie@example.com | Desk Chair   | Furniture        | 200.00        | 2023-02-10 | 1              | 200.00             |

--Normalize this table into 3NF (Third Normal Form). Specify all primary keys, foreign key constraints, unique constraints, not null constraints, and check constraints.

CREATE TABLE Customer (
  customerid INT PRIMARY KEY,
  customer_name VARCHAR(100)NOT NULL,
    customer_email VARCHAR(50)NOT NULL
);
 create table products(
 productid int primary key,
 product_name varchar(30)not null,
  product_category varchar(50)not null,
  product_price decimal(10,2));

  create table orders(
  orderid int primary key,
   order_date date,
    order_quantity int,
	 order_total_amount decimal(10,2) );

	 create table injunction (
	 ID int primary key,
	 customerid int,
	 productid int,
	 orderid int);





--### ER Diagram (5 Marks)

--27. Using the normalized tables from Question 26, create an ER diagram. Include the entities, relationships, primary keys, foreign keys, unique constraints, not null constraints, and check constraints. Indicate the associations using proper ER diagram notation.

