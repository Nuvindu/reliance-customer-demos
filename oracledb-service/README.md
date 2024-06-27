# [Ballerina] Order Management System

## Prerequisites

- Ballerina Swan Lake Update 8+

## Deploying the system

### 1. Start a Kafka broker instance

Run the `docker compose` to set up the required dependencies.

```sh
    docker compose up
```

### 2. Run the OracleDB Client

Execute the following command in the project directory.

```ballerina
bal run oracledb-service.bal
```
