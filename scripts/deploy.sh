#!/usr/bin/env bash

REPOSITORY=/home/ubuntu/app
cd $REPOSITORY

echo "> 실행"

sudo docker-compose build
sudo docker-compose up -d