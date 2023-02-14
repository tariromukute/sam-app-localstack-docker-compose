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
- To run the application on Mac M1 had to change the `Architectures:` attribute to `arm64` otherwise would get error after sending a request to http://127.0.0.1:3000/. See [thread](https://github.com/aws/aws-sam-cli/issues/3169) for more details.
- Tried setting the Architectures using paramaters to allow to easy switch between different architectures `- !Ref Architecture` however it didn't work consistently. It would switch architectures on every other API call
- The endpoint url cannot be set as an env variable. This means it has to be handled in the code. There are plans to work on this, see the discussion [here](https://github.com/aws/aws-cli/issues/4454) and the PR for the work in progress [here](https://github.com/aws/aws-sdk/issues/229#issuecomment-1118725725). In the meantime the solution is to handle it as a template ENV.
- To run this locally successfully, we need to remove `.aws-sam` after running `sam build`

## Useful Resources

- [AWS SAM CLI inside Docker Compose](https://cbax.me/posts/2019/03/aws-sam-cli-inside-docker-compose/)
- [Build a RESTful API using AWS Lambda, API Gateway, DynamoDB and the Serverless Framework](https://itnext.io/build-a-restful-api-using-aws-lambda-api-gateway-dynamodb-and-the-serverless-framework-30fc68e08a42)