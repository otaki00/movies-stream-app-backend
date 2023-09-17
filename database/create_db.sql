
-- Database: movies_streaming_app
DROP DATABASE IF EXISTS movies_streaming_app;
CREATE DATABASE movies_streaming_app WITH OWNER = postgres ENCODING = 'UTF8' LC_COLLATE = 'English_United States.1252' LC_CTYPE = 'English_United States.1252' TABLESPACE = pg_default CONNECTION
LIMIT = -1 IS_TEMPLATE = False;




CREATE TYPE sub_status_types AS ENUM ('active', 'inactive');
CREATE TYPE job_types AS ENUM ('actor', 'voice actor');
CREATE TYPE genre_types AS ENUM ('action', 'drama', 'horror', 'romance', 'comedy', 'mystery', 'fantasy', 'thriller', 'sci-fi','crime', 'adventure');
CREATE TYPE stream_status_type AS ENUM ('on air', 'cnacelled', 'soon', 'aired');
CREATE TYPE payment_method_status_type AS ENUM ('active', 'cnacelled', 'unactive');
CREATE TYPE payment_method_names AS ENUM ('credit card', 'paypal', 'gift code');




CREATE TABLE IF NOT EXISTS payment_methods (
	  payment_method_id SERIAL NOT NULL
	, name payment_method_names NOT NULL
	, payment_method_status payment_method_status_type NOT NULL
	, created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
	, updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP 
	, PRIMARY KEY(payment_method_id)
);



CREATE TABLE IF NOT EXISTS users (
	  user_id SERIAL NOT NULL
	, name VARCHAR(70) NOT NULL
	, username VARCHAR(40) NOT NULL
	, email VARCHAR(40) NOT NULL UNIQUE 
	, password VARCHAR(200) NOT NULL
	, payment_method_id INT NULL
	, created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
	, updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP 
	, PRIMARY KEY(user_id)
	, FOREIGN KEY(payment_method_id)
		REFERENCES payment_methods(payment_method_id)
			ON DELETE SET NULL
);


CREATE TABLE IF NOT EXISTS plans (
	  plan_id SERIAL NOT NULL
	, name VARCHAR(30) NOT NULL
	, amount DOUBLE PRECISION NOT NULL
	, total_months INT NOT NULL
	, created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
	, updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP 
	, PRIMARY KEY(plan_id)
);



CREATE TABLE IF NOT EXISTS subscriptions (
	  sub_id SERIAL NOT NULL
	, user_id INT NOT NULL
	, start_date DATE NOT NULL
	, sub_status sub_status_types NOT NULL
	, plan_id INT NOT NULL
	, created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
	, updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP 
	, PRIMARY KEY(sub_id)
	, FOREIGN KEY(user_id)
	    REFERENCES users(user_id)
	      ON DELETE CASCADE 
);



CREATE TABLE IF NOT EXISTS billis (
	  bill_id SERIAL NOT NULL
	, user_id INT NOT NULL
	, total_amount DOUBLE PRECISION NOT NULL
	, pay_time TIMESTAMP NOT NULL 
	, due_date DATE NOT NULL
	, created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
	, updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP 
	, PRIMARY KEY(bill_id)
	, FOREIGN KEY(user_id )
	   REFERENCES users(user_id)
	     ON DELETE CASCADE
);



CREATE TABLE IF NOT EXISTS movies (
	  movie_id SERIAL NOT NULL
	, title VARCHAR(150) NOT NULL
	, release_date DATE NOT NULL
	, created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
	, updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
	, PRIMARY KEY(movie_id)
);


CREATE TABLE IF NOT EXISTS movies_stream (
	  stream_id SERIAL NOT NULL
	, movie_id INT NOT NULL
	, stream_status stream_status_type NOT  NULL
	, start_time TIMESTAMP NOT NULL
	, end_time TIMESTAMP NOT NULL
	, created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
	, updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
	, PRIMARY KEY(stream_id)
	, FOREIGN KEY(movie_id)
		REFERENCES movies(movie_id)
			ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS directors (
	  director_id SERIAL NOT NULL
	, name VARCHAR(70) NOT NULL
	, created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
	, updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
	, PRIMARY KEY(director_id)
);

CREATE TABLE IF NOT EXISTS movie_directors (
	  director_id INT NOT NULL
	, movie_id INT NOT NULL  
	, created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
	, updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
	, PRIMARY KEY(director_id, movie_id)
	, FOREIGN KEY(movie_id)
		REFERENCES movies(movie_id)
		ON DELETE CASCADE
	, FOREIGN KEY (director_id)
		REFERENCES directors(director_id)
		ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS members (
	member_id SERIAL NOT NULL,
	name VARCHAR(40) NOT NULL,
	job job_types NOT NULL,
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(member_id)
);


CREATE TABLE IF NOT EXISTS cast_members(
	, movie_id INT NOT NULL
	, member_id INT NOT NULL
	, created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
	, updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP 
	, PRIMARY KEY(member_id, movie_id)
	, FOREIGN KEY(movie_id)
		REFERENCES movies(movie_id)
		ON DELETE CASCADE
		, FOREIGN KEY(member_id)
		REFERENCES members(member_id)
		ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS genres (
	  genre_id SERIAL NOT NULL
	, type genre_types NOT NULL
	, created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
	, updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP 
	, PRIMARY KEY(genre_id)
);

CREATE TABLE IF NOT EXISTS movie_genres(
	  movie_id INT NOT NULL
	, genre_id INT NOT NULL
	, created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
	, updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP 
	, PRIMARY KEY (genre_id, movie_id)
	, FOREIGN KEY(movie_id)
		REFERENCES movies(movie_id)
		ON DELETE CASCADE
	, FOREIGN KEY (genre_id)
		REFERENCES genres(genre_id)
		ON DELETE CASCADE
);


CREATE TABLE movies_rates_views (
	 movie_id INT NOT NULL
	, user_id INT NOT NULL
	, rate FLOAT NOT NULL CHECK (rate >= 1 AND rate <= 10)
	, review_content TEXT NULL DEFAULT 'no review from this user'
	, created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
	, updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP 
	, PRIMARY KEY (user_id, movie_id)
	, FOREIGN KEY(movie_id)
		REFERENCES movies(movie_id)
		ON DELETE CASCADE
	, FOREIGN KEY (user_id)
	    REFERENCES users(user_id)
	     ON DELETE CASCADE

);


CREATE TABLE IF NOT EXISTS user_views (
	  movie_id INT NOT NULL
	, user_id INT NOT NULL
	, watched_at TIMESTAMP NOT NULL
	, created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
	, updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP 
	, PRIMARY KEY (user_id, movie_id)
	, FOREIGN KEY(movie_id)
		REFERENCES movies(movie_id)
		ON DELETE CASCADE
	, FOREIGN KEY (user_id)
	    REFERENCES users(user_id)
	     ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS watchlists (
	watchlist_id SERIAL NOT NULL
	, list_name VARCHAR(30) NOT NULL
	, description VARCHAR(100) NULL SET DEFAULT 'no descriptoin'
	, created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
	, updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP 
	, PRIMARY KEY(watchlist_id)
);

CREATE TABLE IF NOT EXISTS user_watchlists (
	watchlist_id INT NOT NULL
	, user_id INT NOT NULL
	, movie_id INT NOT NULL
	, created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
	, updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP 
	, PRIMARY KEY (watchlist_id, user_id, movie_id)
	, FOREIGN KEY(movie_id)
		REFERENCES movies(movie_id)
			ON DELETE CASCADE
	, FOREIGN KEY(watchlist_id)
		REFERENCES watchlists(watchlist_id)
			ON DELETE CASCADE
	, FOREIGN KEY(user_id)
		REFERENCES users(user_id)
			ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS user_watch_history (
	user_id INT NOT NULL
	, movie_id INT NOT NULL
	, watch_at TIMESTAMP NOT NULL SET DEFAULT CURRENT_TIMESTAMP 
	, created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
	, updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP 
	, FOREIGN KEY(user_id)
		REFERENCES users(user_id)
			ON DELETE CASCADE
	, FOREIGN KEY(movie_id)
		REFERENCES movies(movie_id)
			ON DELETE CASCADE
)