import ballerina/ftp;
import ballerina/io;

// Creates the listener with the connection parameters and the protocol-related
// configuration. The listener listens to the files
// with the given file name pattern located in the specified path.
listener ftp:Listener fileListener = check new ({
        protocol: ftp:FTP,
        host: "localhost",
        port: 21,
        // username is set to `one` and the password is set to `1234` as we've given when running the docker ftp server.
        auth: {credentials: {username: "user1", password: "pass456"}},
        fileNamePattern: "(.*).(.*)"
});

// One or many services can listen to the FTP listener for the periodically-polled
// file related events.
service on fileListener {

    // When a file event is successfully received, the `onFileChange` method is called.
    remote function onFileChange(ftp:WatchEvent & readonly event, ftp:Caller caller) returns error? {
        foreach ftp:FileInfo addedFile in event.addedFiles {
            io:println("New file is added: " + addedFile.pathDecoded);
        }
    }
}
