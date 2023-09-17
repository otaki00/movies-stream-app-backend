-- Insert data into payment_methods table
INSERT INTO payment_methods (name, payment_method_status)
VALUES ('credit card', 'active'),
    ('paypal', 'active'),
    ('gift code', 'active');
-- Insert data into users table
INSERT INTO users (
        name,
        username,
        email,
        password,
        payment_method_id
    )
VALUES (
        'John Doe',
        'johndoe',
        'johndoe@email.com',
        'password123',
        1
    ),
    (
        'Jane Smith',
        'janesmith',
        'janesmith@email.com',
        'password456',
        2
    ),
    (
        'Alice Johnson',
        'alicej',
        'alice@email.com',
        'password789',
        3
    ),
    (
        'Bob Brown',
        'bobbrown',
        'bob@email.com',
        'passwordabc',
        2
    ),
    (
        'Eva Davis',
        'evadavis',
        'eva@email.com',
        'passwordefg',
        3
    ),
    (
        'Charlie Wilson',
        'charliew',
        'charlie@email.com',
        'passwordhij',
        1
    );
-- Insert data into plans table
INSERT INTO plans (name, amount, total_months)
VALUES ('Basic', 9.99, 1),
    ('Standard', 19.99, 3),
    ('Premium', 29.99, 6),
    ('Ultra', 39.99, 12),
    ('Silver', 24.99, 3),
    ('Gold', 34.99, 6);
-- Insert data into subscriptions table
INSERT INTO subscriptions (user_id, start_date, sub_status, plan_id)
VALUES (1, '2023-01-15', 'active', 1),
    (2, '2023-02-20', 'active', 2),
    (3, '2023-03-10', 'inactive', 3),
    (4, '2023-04-05', 'active', 4),
    (5, '2023-05-12', 'inactive', 5),
    (6, '2023-06-30', 'active', 6);
-- Insert data into bills table
INSERT INTO billis (user_id, total_amount, pay_time, due_date)
VALUES (1, 9.99, '2023-01-25 12:00:00', '2023-02-15'),
    (2, 19.99, '2023-02-28 15:30:00', '2023-03-20'),
    (3, 29.99, '2023-03-15 10:45:00', '2023-04-10'),
    (4, 39.99, '2023-04-10 14:20:00', '2023-05-05'),
    (5, 24.99, '2023-05-05 17:10:00', '2023-05-25'),
    (6, 34.99, '2023-06-20 08:55:00', '2023-07-10');
-- Insert data into movies table with fictional movie information
INSERT INTO movies (title, release_date)
VALUES ('The Dark Knight', '2008-07-18'),
    ('Inception', '2010-07-16'),
    ('The Shawshank Redemption', '1994-09-23'),
    ('Pulp Fiction', '1994-10-14'),
    ('Forrest Gump', '1994-07-06'),
    ('The Matrix', '1999-03-31');
-- Insert data into movies_stream table
INSERT INTO movies_stream (movie_id, stream_status, start_time, end_time)
VALUES (
        1,
        'on air',
        '2023-01-05 12:00:00',
        '2023-01-06 12:00:00'
    ),
    (
        2,
        'on air',
        '2023-02-20 15:30:00',
        '2023-02-21 15:30:00'
    ),
    (
        3,
        'cnacelled',
        '2023-03-10 10:45:00',
        '2023-03-11 10:45:00'
    ),
    (
        4,
        'soon',
        '2023-04-05 14:20:00',
        '2023-04-06 14:20:00'
    ),
    (
        5,
        'on air',
        '2023-05-12 17:10:00',
        '2023-05-13 17:10:00'
    ),
    (
        6,
        'soon',
        '2023-06-30 08:55:00',
        '2023-07-01 08:55:00'
    );
-- Insert data into directors table with fictional director information
INSERT INTO directors (name)
VALUES ('Christopher Nolan'),
    ('Frank Darabont'),
    ('Quentin Tarantino'),
    ('David Fincher'),
    ('Steven Spielberg'),
    ('Lana Wachowski');
-- Insert data into members table with fictional actor information
INSERT INTO members (name, job)
VALUES ('Christian Bale', 'actor'),
    ('Heath Ledger', 'actor'),
    ('Morgan Freeman', 'actor'),
    ('Tim Robbins', 'actor'),
    ('John Travolta', 'actor'),
    ('Samuel L. Jackson', 'actor');
-- Insert data into movie_directors table to associate directors with movies
INSERT INTO movie_directors (director_id, movie_id)
VALUES (1, 1),
    -- Christopher Nolan directed "The Dark Knight"
    (2, 3),
    -- Frank Darabont directed "The Shawshank Redemption"
    (3, 4),
    -- Quentin Tarantino directed "Pulp Fiction"
    (4, 5),
    -- David Fincher directed "Forrest Gump"
    (5, 6),
    -- Steven Spielberg directed "The Matrix"
    (6, 2);
-- Lana Wachowski directed "Inception"
-- Insert data into cast_members table to associate actors with movies
INSERT INTO cast_members (movie_id, member_id)
VALUES (1, 1),
    -- Christian Bale in "The Dark Knight"
    (1, 2),
    -- Heath Ledger in "The Dark Knight"
    (3, 3),
    -- Morgan Freeman in "The Shawshank Redemption"
    (3, 4),
    -- Tim Robbins in "The Shawshank Redemption"
    (4, 5),
    -- John Travolta in "Pulp Fiction"
    (4, 6);
-- Samuel L. Jackson in "Pulp Fiction"
-- Insert data into genres table with fictional genre information
INSERT INTO genres (type)
VALUES ('action'),
    ('drama'),
    ('crime'),
    ('sci-fi'),
    ('adventure'),
    ('mystery');
-- Insert data into movie_genres table to associate genres with movies
-- For simplicity, I'm associating genres randomly with the fictional movies
-- You can adjust these associations as needed.
INSERT INTO movie_genres (movie_id, genre_id)
VALUES (1, 1),
    -- Action genre for "The Dark Knight"
    (1, 6),
    -- Mystery genre for "The Dark Knight"
    (3, 2),
    -- Drama genre for "The Shawshank Redemption"
    (3, 3),
    -- Crime genre for "The Shawshank Redemption"
    (4, 3),
    -- Crime genre for "Pulp Fiction"
    (4, 6),
    -- Mystery genre for "Pulp Fiction"
    (5, 4),
    -- Sci-Fi genre for "Forrest Gump"
    (5, 5),
    -- Adventure genre for "Forrest Gump"
    (6, 1),
    -- Action genre for "The Matrix"
    (6, 4);
-- Sci-Fi genre for "The Matrix"
-- Insert data into movies_rates_views table
INSERT INTO movies_rates_views (movie_id, user_id, rate, review_content)
VALUES (1, 1, 8.5, 'Good movie overall.'),
    (2, 2, 7.0, 'Could have been better.'),
    (3, 3, 9.0, 'Loved it!'),
    (4, 4, 6.5, 'Not my type of movie.'),
    (5, 5, 8.0, 'Funny and entertaining.'),
    (6, 6, 7.5, 'Interesting plot.');
-- Insert data into user_views table
INSERT INTO user_views (movie_id, user_id, watched_at)
VALUES (1, 1, '2023-01-02 20:00:00'),
    (2, 2, '2023-02-18 14:30:00'),
    (3, 3, '2023-03-31 21:15:00'),
    (4, 4, '2023-04-12 17:45:00'),
    (5, 5, '2023-05-22 10:00:00'),
    (6, 6, '2023-06-10 19:30:00');
-- Insert data into watchlists table
INSERT INTO watchlists (list_name, description)
VALUES ('Favorites', 'My favorite movies'),
    ('To Watch', 'Movies to watch later'),
    ('Action Movies', 'Exciting action films'),
    ('Romantic Movies', 'Heartwarming love stories'),
    ('Comedies', 'Funny and light-hearted'),
    (
        'Horror Flicks',
        'Scary movies for thrill-seekers'
    );
-- Insert data into user_watchlists table
INSERT INTO user_watchlists (watchlist_id, user_id, movie_id)
VALUES (1, 1, 1),
    (1, 2, 2),
    (2, 1, 3),
    (2, 3, 4),
    (3, 2, 5),
    (3, 4, 6);
-- Insert data into user_watch_history table
INSERT INTO user_watch_history (user_id, movie_id, watch_at)
VALUES (1, 1, '2023-01-02 20:00:00'),
    (2, 2, '2023-02-18 14:30:00'),
    (3, 3, '2023-03-31 21:15:00'),
    (4, 4, '2023-04-12 17:45:00'),
    (5, 5, '2023-05-22 10:00:00'),
    (6, 6, '2023-06-10 19:30:00');