

-- @block
-- List all directors and their movies, reviews and rating for each movie, and the user info that make the review (including history)

SELECT d.name, m.title, msv.rate, msv.review_content, u.name AS user_name, ms.title AS user_history
FROM directors AS d
JOIN movie_directors AS md ON md.director_id = d.director_id
JOIN movies AS m ON m.movie_id = md.movie_id
JOIN movies_rates_views AS msv ON msv.movie_id = m.movie_id
JOIN users AS u ON u.user_id = msv.user_id
JOIN user_watch_history as uwh ON uwh.user_id = u.user_id
JOIN movies AS ms ON ms.movie_id = uwh.movie_id;


-- @block 
-- Show me the username + the genres he watched + how many times he watched these genres
WITH UsersMovies AS (
    SELECT u.username, m.movie_id, m.title
    FROM users AS u
    JOIN user_watch_history AS uwh ON uwh.user_id = u.user_id  
    JOIN movies AS m ON m.movie_id = uwh.movie_id
),
UsersGenres AS (
    SELECT um.username, g.type, COUNT(um.movie_id)
    FROM UsersMovies AS um 
    JOIN movie_genres AS mg ON mg.movie_id = um.movie_id
    JOIN genres AS g ON g.genre_id = mg.genre_id
    GROUP BY um.username, g.type
    ORDER BY um.username ASC
)
SELECT *
FROM UsersGenres AS ug;



-- @block 
-- get all genres and how many have been watched 
WITH UsersMovies AS (
    SELECT u.username,
        m.movie_id,
        m.title
    FROM users AS u
        JOIN user_watch_history AS uwh ON uwh.user_id = u.user_id
        JOIN movies AS m ON m.movie_id = uwh.movie_id
),
UsersGenres AS (
    SELECT um.username,
        g.type,
        COUNT(um.movie_id)
    FROM UsersMovies AS um
        JOIN movie_genres AS mg ON mg.movie_id = um.movie_id
        JOIN genres AS g ON g.genre_id = mg.genre_id
    GROUP BY um.username,
        g.type
    ORDER BY um.username ASC
)
SELECT ug.type,
    sum(ug.count) as type_sum
FROM UsersGenres AS ug
GROUP BY ug.type
ORDER BY type_sum DESC;


-- @block
-- Show me the current subscriptions + the usernames + when they will finish their subscriptions + how many movies they watch

WITH UserSubs AS (
    SELECT u.user_id, u.username, p.name AS plan_name, p.amount, s.start_date, (s.start_date + INTERVAL '1 month' * p.total_months) AS expire_date
    FROM subscriptions AS s
    JOIN users AS u ON u.user_id = s.user_id
    JOIN plans AS p ON p.plan_id = s.plan_id
),
UserMovies AS(
    SELECT u.user_id ,COUNT(uwh.movie_id) AS num_movies_watch
    FROM users AS u
    JOIN user_watch_history AS uwh ON uwh.user_id = u.user_id
    GROUP BY u.user_id
)
SELECT us.username, us.plan_name, us.amount, us.start_date, us.expire_date, um.num_movies_watch
FROM UserSubs AS us
JOIN UserMovies AS um ON um.user_id = us.user_id




