#!/usr/bin/env bash

REPOSITORY=/home/ec2-user/app
cd $REPOSITORY

echo "> 실행중인"
docker kill $(docker ps -q)
docker-compose up -d