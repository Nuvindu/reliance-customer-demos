import ballerina/ftp;
import ballerina/io;

public function main() returns error? {
    ftp:Client fileClient = check new ({
        host: "localhost",
        auth: {
            credentials: {
                username: "user1",
                password: "pass456"
            }
        }
    });

    stream<io:Block, io:Error?> fileStream = check io:fileReadBlocksAsStream("./local/logFile.txt", 1024);
    check fileClient->put("/uploadFile.txt", fileStream);
    check fileStream.close();
}
