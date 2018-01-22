#!/bin/bash

echo "need docker docker-compose git and code"
echo "also need sudo docker tag mvn_image_name mvn"

sudo docker network create backend
mkdir dicom
mkdir data
