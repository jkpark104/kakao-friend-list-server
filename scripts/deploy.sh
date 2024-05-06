#!/usr/bin/env bash

REPOSITORY=/home/ec2-user/app
cd $REPOSITORY

echo "> 실행"

sudo docker-compose build
sudo docker-compose up -d