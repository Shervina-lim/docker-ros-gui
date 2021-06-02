#!/bin/bash

echo "Building image ..."
docker build -t sl/u18-melodic:nvidia -f docker/Dockerfile .
