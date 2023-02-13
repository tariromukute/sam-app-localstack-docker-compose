# Sample SAM application with localstack and docker compose

## Run Application Stack

Start the stack with docker compose

```bash
docker compose up
```

Create the dynamodb tables

```bash
aws dynamodb create-table --cli-input-json file://create-sample-table.json --endpoint-url http://localhost:4566
```

Send requests to app

```bash
# Put an item
curl -X POST http://127.0.0.1:3000/ -d '{"id": "id2","name": "name1"}'

# Get list of items
curl http://127.0.0.1:3000/
```

## Gotchas

- [Database sharing needs to be enabled for applications find the create table resource](https://stackoverflow.com/questions/29558948/dynamo-local-from-node-aws-all-operations-fail-cannot-do-operations-on-a-non-e)
- The network and container host need to be defined correctly for the application to respond. This was non trival. See the discussion [here](https://github.com/aws/aws-sam-cli/issues/2837)

## Useful Resources

- [AWS SAM CLI inside Docker Compose](https://cbax.me/posts/2019/03/aws-sam-cli-inside-docker-compose/)
- [Build a RESTful API using AWS Lambda, API Gateway, DynamoDB and the Serverless Framework](https://itnext.io/build-a-restful-api-using-aws-lambda-api-gateway-dynamodb-and-the-serverless-framework-30fc68e08a42)