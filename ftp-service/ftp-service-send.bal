import ballerina/ftp;
import ballerina/io;

listener ftp:Listener fileListener = check new ({
    protocol: ftp:FTP,
    host: "localhost",
    port: 21,
    auth: {
        credentials: {
            username: "user1",
            password: "pass456"
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
