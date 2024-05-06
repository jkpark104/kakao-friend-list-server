#!/usr/bin/env bash

REPOSITORY=/home/ec2-user/app
cd $REPOSITORY

echo "> 실행"
sudo docker kill $(sudo docker ps -q)
sudo docker-compose up -d