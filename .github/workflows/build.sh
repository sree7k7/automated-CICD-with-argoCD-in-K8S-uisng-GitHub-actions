#!/bin/bash
echo "bulding build.shx"

git config user.email sree7k7@gmail.com
git config user.name sree7k7

cat deployment.yaml

echo "1"
# sed -i 's+sree7k7/my-web.*+sree7k7/my-web: { steps.meta.outputs.tags }+g' deployment.yaml

echo "1.1"

sed -i 's+sree7k7/my-web:v6+sree7k7/my-web:v7+g' ./deployment.yaml

echo "2.1"

cat deployment.yaml