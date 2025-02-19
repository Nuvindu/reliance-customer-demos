import ballerinax/kafka;
import ballerina/io;

type Order readonly & record {|
    int orderId;
    string productName;
    decimal price;
    boolean isValid;
|};

public function main() returns error? {
    kafka:Consumer orderConsumer = check new (kafka:DEFAULT_URL, {
        groupId: "group-id",
        topics: "orders"
    });

    while true {
        Order[] orders = check orderConsumer->pollPayload(15);
        from Order 'order in orders
            where 'order.isValid
            do {
                io:println(string `Received valid order for ${'order.productName}`);
            };
    }
}
