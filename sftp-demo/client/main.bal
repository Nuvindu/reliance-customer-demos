import ballerina/ftp;
import ballerina/io;

public function main() returns error? {
    ftp:Client fileClient = check new ({
        protocol: ftp:SFTP,
        host: "localhost",
        port: 21213,
        auth: {
            credentials: {
                username: "in",
                password: "wso2123"
            },
            privateKey: {
                path: "../resources/keys/pkcs8-key"
            }
        }
    });

    stream<io:Block, io:Error?> fileStream = check io:fileReadBlocksAsStream("./local/log_file.txt", 1024);
    check fileClient->put("/upload/uploadFile.txt", fileStream);
    check fileStream.close();
}
