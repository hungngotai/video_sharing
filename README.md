# Tab contents:
0. [App Home](https://video-sharing-nthung.herokuapp.com/sign_in)
1. [Features](#features)
2. [Local Development](#local-development)
3. [Docker Development](#docker-development)
4. [How to run test](#how-to-run-test)

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

# How to run test:
## With local machine:
    # Run unit test
    rspec
## With docker:
    # Run unit test
    docker compose run app_test bundle exec rspec

# User document:

## Brief:

- You need to sign in or sign up before access another pages
- You can switch between Sign In or Sign Up pages
- You can sign up without confirm your email address
- Home page list all of sharing videos at once
- From Home page, you can access to Share page or you can be notify about new shared video

# Further improvement - future features:
1. Paginate - Infinity scroll
2. Like/Unlike
3. User's sharing videos
