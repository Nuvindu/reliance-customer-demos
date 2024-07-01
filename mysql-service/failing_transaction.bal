// import ballerina/sql;
import ballerinax/mysql;
import ballerinax/mysql.driver as _;
import ballerina/io;
import ballerina/sql;

// The `Album` record to load records from `albums` table.
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

    int quantity = 1000;
    transaction {
        _ = check db->execute(`INSERT INTO orders (book_id, customer_id, quantity, total_price, order_date) VALUES (1, 123, ${quantity}, (SELECT price FROM books WHERE book_id = 1), NOW())`);

        _ = check db->execute(`INSERT INTO sales (book_id, sale_date, quantity, total_amount) VALUES (1, NOW(), ${quantity}, (SELECT price FROM books WHERE book_id = 1))`);

        // The following query will fail because the quantity of the book is not enough.
        _ = check db->execute(`UPDATE books SET quantity = quantity - ${quantity} WHERE book_id = 1`);

        check commit;

        io:println("Transaction is successful");
    } on fail error e {
        if e is sql:DatabaseError {
            if e.detail().errorCode == 3819 {
                return error(string `Transaction is failed: ${e.message()}`);
            }
        }
        return e;
    }
}
