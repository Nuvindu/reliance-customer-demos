// import ballerina/sql;
import ballerinax/oracledb;
import ballerinax/oracledb.driver as _;
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
    oracledb:Client db = check new ("localhost", "oracle", "dummypassword", "XEPDB1", 1521);
    int quantity = 100;
    transaction {
            _ = check db->execute(`INSERT INTO orders (order_id, book_id, customer_id, quantity, total_price, order_date) 
                                   VALUES (ORDER_SEQ.NEXTVAL, 1, 123, ${quantity}, (SELECT price FROM books WHERE book_id = 1), SYSTIMESTAMP)`);

            _ = check db->execute(`INSERT INTO sales (sale_id, book_id, sale_date, quantity, total_amount) 
                                   VALUES (SALE_SEQ.NEXTVAL, 1, SYSTIMESTAMP, ${quantity}, (SELECT price FROM books WHERE book_id = 1))`);

            _ = check db->execute(`UPDATE books SET quantity = quantity - ${quantity} WHERE book_id = 1`);
        check commit;
        io:println("Transaction is successful");
    } on fail error e {
        if e is sql:DatabaseError {
            if e.detail().errorCode == 3819 {
                return error(string `Transaction is failed`);
            }
        }
        return e;
    }
}
