CREATE TABLE theater (
    id INTEGER,
    name VARCHAR(10) NOT NULL,
    location TEXT,
    PRIMARY KEY (id)
)
;
CREATE TABLE screen (
    id INTEGER,
    theater_id INTEGER,
    movie_name TEXT,
    price INTEGER,
    seat_number INTEGER,
    start_dt DATE,
    end_dt DATE,
    PRIMARY KEY (id),
    FOREIGN KEY (theater_id) REFERENCES theater (id)
)
;
CREATE TABLE reservation (
    id INTEGER,
    theater_id INTEGER NOT NULL,
    screen_id INTEGER NOT NULL,
    movie_customer_id INTEGER NOT NULL,
    seat_number INTEGER NOT NULL,
    dt DATE NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (theater_id) REFERENCES theate (id),
    FOREIGN KEY (screen_id) REFERENCES screen (id),
    FOREIGN KEY (movie_customer_id) REFERENCES movie_customer (id)
);

CREATE TABLE movie_customer (
    id INTEGER,
    name VARCHAR(20),
    PRIMARY KEY (id)
)