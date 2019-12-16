#!/bin/bash

# TEST
npm test &&

# BUILD
docker login --username pocteo --password Docker! &&
docker build -t pocteo/demo-app:$(git rev-parse --short=7 HEAD) . &&
  

# PUSH
docker push pocteo/demo-app:$(git rev-parse --short=7 HEAD)

# TRIGGER CD
export COMMIT_SHA=$(git rev-parse --short=7 HEAD)
rm -rf /tmp/demo-env && \
git clone git@github.com:pocteo/demo-env.git /tmp/demo-env && \
cd /tmp/demo-env && \
git checkout candidate && \
git config user.email "hi@pocteo.io" && \
git config user.name "Dridi Walid" && \
sed "s/COMMIT_SHA/${COMMIT_SHA}/g" kubernetes.yaml.tpl > kubernetes.yaml
git add kubernetes.yaml && \
git commit -m "Deploying image pocteo/demo-app:${COMMIT_SHA} Built from commit ${COMMIT_SHA} of repository pocteo/demo-env" && \
git push origin candidate

