#!/bin/bash

echo "bulding build.shx"

# sh "git config user.email sree7k7@gmail.com"
# sh "git config user.name sree7k7"

cat deployment.yaml
# sh "sed -i  's+sree7k7/my-web.*+sree7k7/my-web:${{ steps.meta.outputs.tags }}+g' deployment.yaml"