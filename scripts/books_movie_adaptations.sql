SELECT * from books LIMIT 10; -- check samples of books
update books set name = REPLACE(name,';',','); -- update the values to previous version with commas.
SELECT name, author, avg_rating as "Average Rating" from books order by avg_rating DESC limit 10; -- Books with the highest rating
SELECT name, author, rating_count as "Rating Count" FROM books order by rating_count desc LIMIT 10; -- Books with the highest popularity
SELECT author, count(author) as "Number of Books" from books group by author ORDER by COUNT(author) desc limit 10; -- Authors with the highest number of books
SELECT MIN(avg_rating), MAX(avg_rating), MIN(rating_count), MAX(rating_count) from books; -- Find range of avg_rating and rating_counts
SELECT name, author, avg_rating as "Average Rating", rating_count AS "Rating Count" from books WHERE avg_rating>4.5 AND rating_count > 100000 order by rating_count desc; --Books with the highest rating and popularitybooks
SELECT AVG(avg_rating) as "Average Rating of Books" from books; -- Average Rating across all books
SELECT author, count(*) as "Books Written", SUM(rating_count) as "Total Rating Count" from books GROUP by author ORDER BY SUM(rating_count) DESC limit 10; --Top authors by total reader engagement
SELECT COUNT(*) FROM books WHERE avg_rating=0 and rating_count=0; -- Identifying rows with empty values.
SELECT name, author, avg_rating, vote_count, (avg_rating*vote_count) AS "Engagement Score", RANK() OVER (ORDER by (avg_rating*vote_count) DESC) as "Engagement Rank" from books limit 10; -- Books by weighted engagement 
SELECT name, author, avg_rating, rating_count, RANK() OVER (ORDER BY rating_count Desc, avg_rating asc) as hype_rank from books where avg_rating<4.0 and avg_rating!=0 LIMIT 10; -- Overhyped books with high popularity but low ratings
SELECT name, author, avg_rating, rating_count, RANK() OVER (ORDER BY avg_rating desc, rating_count ASC) as hype_rank from books where avg_rating > 4 and rating_count < 50000 and rating_count!=0 limit 10; -- Underrated books with high ratings but low popularity
SELECT 
    CASE 
        WHEN (rating_count < 50000 and rating_count!=0) THEN 'Low Popularity'
        WHEN rating_count < 200000 THEN 'Medium Popularity'
        WHEN rating_count < 1000000 THEN 'High Popularity'
        ELSE 'Very High Popularity'
    END AS popularity_bin,
    AVG(avg_rating) AS avg_rating,
    COUNT(*) AS book_count
FROM books
GROUP BY popularity_bin
ORDER BY book_count DESC;
