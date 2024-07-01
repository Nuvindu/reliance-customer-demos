import ballerina/sql;
import ballerinax/mysql;
import ballerinax/mysql.driver as _;
import ballerina/io;

type Book record {|
    string book_id;
    string title;
    string author;
    string price;
    int quantity;
|};

public function main() returns error? {
    // Initializing the MySQL client.
    mysql:Client db = check new ("localhost", "root", "password", "BOOK_STORE", 3306);

    // Inserting a record into the `books` table.
    sql:ExecutionResult execute = check db->execute(`INSERT INTO books (title, author, price, quantity) VALUES ('Sapiens', 'Yual Noah Harari', 8.99, 75)`);
    
    if execute.affectedRowCount < 1 {
        return error("Error occurred while inserting the record");
    }

    // Retrieving the inserted record from the `books` table.
    Book book = check db->queryRow(`SELECT * FROM books WHERE title = 'Sapiens'`);
    io:println("Book: ", book);
}
