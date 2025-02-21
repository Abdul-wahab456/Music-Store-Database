-- 1.	Hierarchy Check:
-- Find the senior-most employee based on their job title.
SELECT employee_id, first_name, last_name, title, levels,hire_date
FROM employee
WHERE reports_to IS NULL;

-- 2.	Sales by Country:
-- Determine the countries with the highest number of invoices.
SELECT c.country, COUNT(i.invoice_id) AS total_invoices
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
GROUP BY c.country
ORDER BY total_invoices DESC;

-- 3.	High-Value Transactions:
-- Identify the top three invoice totals.
SELECT invoice_id, total,billing_country
FROM invoice
ORDER BY total DESC
LIMIT 3;

-- 4.	Promotional City:
-- Find the city that generated the highest revenue and recommend hosting a music festival there.

select i.billing_city,sum(i.total)as total
from invoice i
group by billing_city
order by total desc
limit 1;


-- 5.	Best Customer:
-- Determine the customer who has spent the most money.
SELECT c.customer_id, c.first_name, c.last_name, SUM(i.total) AS total_spent
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC
LIMIT 1;


-- 6.	Genre Insights:
-- List all customers who listen to rock music, ordered alphabetically by email.
SELECT distinct c.customer_id, c.first_name, c.last_name, c.email,g.name
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
JOIN invoice_line il ON i.invoice_id = il.invoice_id
JOIN track t ON il.track_id = t.track_id
JOIN genre g ON t.genre_id = g.genre_id
and g.name = 'Rock'
ORDER BY c.email;

-- 7.	Top Rock Artists:
-- Identify the top 10 rock music artists with the highest number of tracks.
SELECT a.artist_id, a.name, COUNT(t.track_id) AS track_count
FROM artist a
join album al on a.artist_id = al.artist_id
join track t ON al.album_id = t.album_id
join genre g ON t.genre_id = g.genre_id
WHERE g.name = 'Rock'
GROUP BY a.artist_id, a.name
ORDER BY track_count DESC
LIMIT 10;

-- 8.	Long Tracks:
-- Find tracks longer than the average song length, ordered by duration in descending order.
SELECT track_id, name, milliseconds as duration
FROM track
WHERE milliseconds > (SELECT AVG(milliseconds) FROM track)
ORDER BY duration DESC;

-- 9.	Customer Spending by Artist:
-- Identify the top 10 customers and their total spending on specific artists.
SELECT c.customer_id, c.first_name, c.last_name, a.name AS artist_name, SUM(i.total) AS total_spent
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
JOIN invoice_line il ON i.invoice_id = il.invoice_id
JOIN track t ON il.track_id = t.track_id
join album al on t.album_id = al.album_id
JOIN artist a ON al.artist_id = a.artist_id
GROUP BY c.customer_id, c.first_name, c.last_name, a.artist_id, a.name
ORDER BY total_spent DESC
LIMIT 10;