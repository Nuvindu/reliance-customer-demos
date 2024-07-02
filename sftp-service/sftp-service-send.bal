import ballerina/ftp;
import ballerina/io;

listener ftp:Listener fileListener = check new ({
        protocol: ftp:SFTP,
        host: "localhost",
        port: 21213,
        auth: {
            credentials: {
                username: "in",
                password: "wso2123"
            },
            privateKey: {
                path: "./resources/keys/pkcs8-key"
            }
        },
        fileNamePattern: "(.*).(.*)"
});

service on fileListener {
    remote function onFileChange(ftp:WatchEvent & readonly event, ftp:Caller caller) returns error? {
        foreach ftp:FileInfo addedFile in event.addedFiles {
            io:println("New file is added: " + addedFile.pathDecoded);
        }
    }
}
