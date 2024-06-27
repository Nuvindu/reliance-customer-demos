# [Ballerina] Music Store

## Prerequisites

- Ballerina Swan Lake Update 8+

## Deploying the system

### 1. Setup a MySQL Database

Run the `docker compose` to set up the required dependencies.

```sh
    docker compose up
```

### 2. Run the MySQL service

Execute the following command in the project directory.

```ballerina
bal run mysql-service.bal
```

### 3. Invoke the Ballerina service

Use the following cURL command to invoke the service.

```ballerina
curl http://localhost:8080/albums
```
