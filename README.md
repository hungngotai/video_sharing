# Tab contents:
1. [Features](#features)
2. [Local Development](#local-development)
3. [Docker Development](#docker-development)

# Features:
1. Sign in/ Sign up
2. List videos sharing
3. Sharing a video
4. Notify a new video sharing
# Local Development:
1. [Prerequisites](#prerequisites)
2. [Scripts](#scripts)

## Prerequisites:
1. Ruby >= 3.2.2
2. Rails >= 7.0.4.3
3. Node >= 18.15.0
4. Yarn >= 1.22.19
5. Postgresql >= 14.7

## Scripts:
    # Setting up database:
    rails db:setup

    # Up and running:
    bin/dev
# Docker Development:
1. [Prerequisites](#prerequisites-1)
2. [Scripts](#scripts-1)

## Prerequisites:
1. Docker
2. Docker Compose

## Scripts:
    # Up and running:
    docker compose up

    # Setting up database - you must  app service first:
    docker compose exec app bundle exec rails db:setup

