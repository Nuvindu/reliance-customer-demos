import ballerina/sql;
import ballerinax/oracledb;
import ballerinax/oracledb.driver as _;
import ballerina/io;

type Student record {
    int id;
    int age;
    string name;
};

public function main() returns error? {
    oracledb:Client db = check new ("localhost", "oracle", "dummypassword", "XEPDB1", 1521);
    sql:ParameterizedQuery query3 = `SELECT * FROM student`;
    stream<Student, sql:Error?> resultStream = db->query(query3);

    // Iterating the returned table.
    check from Student student in resultStream
    do {
        io:println("Student: ", student);
    };
}
