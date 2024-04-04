# Table of Contents

* [Requirements](#requirements)
* [Before You Start](#before-you-start)
* [Pre Flight Checklist](#pre-flight-checklist)
* [Workflow](#workflow)
* [Deploy](#deploy)
* [Endpoints](#endpoints)
* [Clean Up](#clean-up)

## Requirements

* [Amazon AWS Account](https://aws.amazon.com/it/console/) - Create an AWS account with billing enabled
* [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) - AWS CLI to configure credentials
* [Docker](https://docs.docker.com/get-docker/) - To run script
* [ServiceNow](https://developer.servicenow.com/dev.do) - ServiceNow Personal Developer Instance (PDI)

### Veracode

There is a prerequisite that needs to be done on the [Veracode Platform](https://web.analysiscenter.veracode.com/login/#/login)

* Generate Veracode API ID and Key
    * Home > Profile (Top Right) > API Credentials > Generate API Credentials

## Before You Start

Note that this example uses AWS resources that are outside the AWS free tier.

## Pre Flight Checklist

Ensure Docker is installed

```
docker -v
```
[Configure](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html) the AWS CLI
```
aws configure
```

## Workflow

![veracode-workflow](https://raw.githubusercontent.com/restonlogic/veracode-examples/main/aws/k3s-terraform-cluster/diagrams/veracode-workflow.png)


## Deploy

We are now ready to deploy our infrastructure. We will use docker to create the infrastructure:

```
docker run -v ~/.aws/credentials:/root/.aws/credentials \
    -e GIT_ADDRESS="" \
    -e ACTION="apply" \
    -e NAME="" \
    -e ENVIRONMENT="" \
    -e GIT_ORG="" \
    -e GIT_REPO="" \
    -e GIT_BRANCH="" \
    -e GIT_USER="" \
    -e GIT_TOKEN="" \
    -e CEA="" \
    -e VERACODE_API_ID="" \
    -e VERACODE_API_KEY="" \
    -e AWS_PROFILE="" \
    -e SNOW_URL="" \
    -e SNOW_USR="" \
    -e SNOW_PWD="" \
    -e AWS_PROFILE="" \
    engrave/k3s-terraform-cluster:0.6
```
Below you will find the commands and their options


| Commands | Options |
| -------------|:-------------|
| GIT_ADDRESS         |provide a Github Address (github.com)      |
| ACTION              |action for terraform to use                |
| NAME                |name to use for deployment, can be veracode|
| ENVIRONMENT         |environment being deployed, can be poc     |
| GIT_ORG             |provide a Git Org                          |
| GIT_REPO            |provide a Git Repo                         |
| GIT_BRANCH          |provide a Git Branch                       |
| GIT_USER            |provide a Github username                  |
| GIT_TOKEN           |provide a Github token                     |
| CEA                 |certificate manager email address to use   |
| VERACODE_API_ID     |veracode api id                            |
| VERACODE_API_KEY    |veracode api key                           |
| AWS_PROFILE         |aws profile name                           |
| SNOW_URL            |ServiceNow Instance URL                    |
| SNOW_USR            |ServiceNow Username                        |
| SNOW_PWD            |ServiceNow Password                        |

## Endpoints
Once the infrastructure is created, you will find the following endpoints
* Jenkins URL and credentials
* Veracode Dashboard URL 
* K3s Monitoring Dashboard URL and token

## Clean Up

Use the following command to destroy all the previously created resources. Note that this is the same command to create the infrastructure but with "destroy" as the action.

```
docker run -v ~/.aws/credentials:/root/.aws/credentials \
    -e GIT_ADDRESS="" \
    -e ACTION="destroy" \
    -e NAME="" \
    -e ENVIRONMENT="" \
    -e GIT_ORG="" \
    -e GIT_REPO="" \
    -e GIT_BRANCH="" \
    -e GIT_USER="" \
    -e GIT_TOKEN="" \
    -e CEA="" \
    -e VERACODE_API_ID="" \
    -e VERACODE_API_KEY="" \
    -e AWS_PROFILE="" \
    -e SNOW_URL="" \
    -e SNOW_USR="" \
    -e SNOW_PWD="" \
    -e AWS_PROFILE="" \
    engrave/k3s-terraform-cluster:0.4
```
