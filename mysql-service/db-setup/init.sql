CREATE USER 'local_user'@'localhost' IDENTIFIED BY 'password';

GRANT ALL PRIVILEGES ON MUSIC_STORE.* TO 'local_user';

FLUSH PRIVILEGES;

-- CREATE DATABASE MUSIC_STORE;

CREATE TABLE MUSIC_STORE.albums (id VARCHAR(100) NOT NULL PRIMARY KEY, title VARCHAR(100), artist VARCHAR(100), price REAL );

INSERT INTO MUSIC_STORE.albums VALUES("A-123", "Lemonade", "Beyonce", 18.98);

INSERT INTO MUSIC_STORE.albums VALUES("A-321", "Renaissance", "Beyonce", 24.98);

CREATE TABLE MUSIC_STORE.artists (artist_id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY, first_name VARCHAR(300), last_name VARCHAR(300) );

INSERT INTO MUSIC_STORE.artists VALUES (1, "Beyonce", "Knowles");

INSERT INTO MUSIC_STORE.artists VALUES (2, "Rihanna", "Fenty");

CREATE TABLE MUSIC_STORE.inventory (id varchar(100) NOT NULL PRIMARY KEY, title varchar(100) DEFAULT NULL, artist varchar(100) DEFAULT NULL, price double DEFAULT NULL, quantity int NOT NULL, CHECK (quantity > 0) );

INSERT INTO MUSIC_STORE.inventory VALUES ("A-123", "Lemonade", "Beyonce", 18.98, 10);

INSERT INTO MUSIC_STORE.inventory VALUES ("A-321", "Renaissance", "Beyonce", 24.98, 100);

CREATE TABLE MUSIC_STORE.sales_order (id varchar(100) NOT NULL PRIMARY KEY, order_date DATE NOT NULL, product_id varchar(100) NOT NULL, quantity int );
                                                                                                                                      
INSERT INTO MUSIC_STORE.sales_order VALUES ("S-123", "2022-12-09", "A-123", 2);
INSERT INTO MUSIC_STORE.sales_order VALUES ("S-321", "2022-12-09", "A-321", 1);
INSERT INTO MUSIC_STORE.sales_order VALUES ("S-456", "2022-12-10", "A-321", 3);
