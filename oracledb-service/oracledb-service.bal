import ballerina/sql;
import ballerinax/oracledb;
import ballerinax/oracledb.driver as _;
import ballerina/io;

type Book record {|
    string book_id;
    string title;
    string author;
    string price;
    int quantity;
|};

public function main() returns error? {
    oracledb:Client db = check new ("localhost", "oracle", "dummypassword", "XEPDB1", 1521);
    sql:ParameterizedQuery query3 = `SELECT * FROM books`;
    stream<Book, sql:Error?> bookStream = db->query(query3);

    // Iterating the returned table.
    check from Book book in bookStream
    do {
        io:println("Book: ", book);
    };
}
