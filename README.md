# Management Buzzword Classifier



### Installation of serverless framework

This is base on the serverless.com framework version 3. The current version is 4 which I haven't tested against.

https://www.npmjs.com/package/serverless/v/3.36.0

`npm install -g serverless@3.36.0`

You also need to install the serverless ruby layer

`npm install -n serverless-ruby-layer`

and dot env 

`npm install dotenv --save`

`sls create -t aws-ruby`



### Deploying the app

Deploys are in the serverless.yml file of each application which define:

* The lambda functions
* The AWS IAM role that runs these functions
* Resources such as DynamoDB

To deploy an application simply run:

`sls deploy --stage staging` 

All applications use a dotenv file for each stage e.g. `.env.staging`
