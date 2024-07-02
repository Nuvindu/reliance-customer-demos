import ballerina/io;
import ballerina/sql;
import ballerinax/mysql;
import ballerinax/mysql.driver as _;

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
    
    transaction {
        // Check the availability of the book.
        int bookAvailability = check db->queryRow(`SELECT quantity FROM books WHERE book_id = 1`);
        if bookAvailability == 0 {
            rollback;
            io:println("Book is not available");
        } else {
            // Inserting a new order into the `orders` table.
            _ = check db->execute(`INSERT INTO orders (book_id, customer_id, quantity, total_price, order_date) VALUES (1, 123, 1, (SELECT price FROM books WHERE book_id = 1), NOW())`);

            // Inserting a new sales record into the `sales` table.
            _ = check db->execute(`INSERT INTO sales (book_id, sale_date, quantity, total_amount) VALUES (1, NOW(), 1, (SELECT price FROM books WHERE book_id = 1))`);

            // Updating the quantity of the ordered book.
            _ = check db->execute(`UPDATE books SET quantity = quantity - 1 WHERE book_id = 1`);

            check commit;
            io:println("Transaction is successful");
        }
    } on fail error e {
        if e is sql:DatabaseError {
            if e.detail().errorCode == 3819 {
                return error(string `Transaction is failed`);
            }
        }
        return e;
    }
}
