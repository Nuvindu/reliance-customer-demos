-- init.sql
-- CREATE USER my_user IDENTIFIED BY my_password;
-- GRANT CONNECT, RESOURCE TO my_user;
CONNECT oracle/dummypassword@localhost:1521/XEPDB1
CREATE TABLE student ( id NUMBER GENERATED ALWAYS AS IDENTITY, age NUMBER, name VARCHAR(255), PRIMARY KEY (id) );
INSERT INTO student(age, name) VALUES (12, 'John');
