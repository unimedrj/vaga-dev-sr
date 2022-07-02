#!/bin/sh

set -e

test -f .env.docker-compose && . ./.env.docker-compose

curl -H "Accept: application/vnd.github.v3+json" -H "Authorization: token ${GITHUB_PERSONAL_ACCESS_TOKEN}" https://api.github.com/repositories
