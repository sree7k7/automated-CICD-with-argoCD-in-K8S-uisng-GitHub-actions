#!/bin/bash
echo "bulding build.shx"

git clone git@github.com:sree7k7/github-action-for-docker.git

git config user.email sree7k7@gmail.com
git config user.name sree7k7

cat deployment.yaml

echo "1"
# sed -i 's+sree7k7/my-web.*+sree7k7/my-web: { steps.meta.outputs.tags }+g' deployment.yaml

echo "1.1"

sed -i 's+sree7k7/my-web:v6+sree7k7/my-web:v7+g' ./deployment.yaml

echo "2.1"

cat deployment.yaml

git add .

git commit -m "added"

git push https://sree7k7:${GIT_PASS}@github.com/sree7k7/github-action-for-docker.git