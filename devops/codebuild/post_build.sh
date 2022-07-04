#!/bin/sh

set -e

aws2 ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $ECR_DOMAIN
docker tag vaga-dev-sr:latest $ECR_DOMAIN/vaga-dev-sr:latest
docker push $ECR_DOMAIN/vaga-dev-sr:latest -q
