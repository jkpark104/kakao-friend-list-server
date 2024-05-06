#!/usr/bin/env bash

REPOSITORY=/home/ubuntu/my-nest-app
cd $REPOSITORY

echo "> 실행중인"
docker kill $(docker ps -q)
docker-compose up -d