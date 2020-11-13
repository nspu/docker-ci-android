## Description
Compile android project.
Deploy file easily on amazon S3.
Fastlane is available as well.


This Docker Image use [gitlab-ci-android](https://hub.docker.com/r/jangrewe/gitlab-ci-android) image.
Script for s3md come from [garland/docker-s3cmd](https://hub.docker.com/r/garland/docker-s3cmd)

## Exemple
```
image: nspu/docker-android-s3cmd

variables:
  S3_BUCKET: mobile
  aws_key: "${AWS_KEY}"
  aws_secret: "${AWS_SECRET}"
  cmd: "interactive"

stages:
- build

before_script:
- export GRADLE_USER_HOME=$(pwd)/.gradle
- chmod +x ./gradlew

cache:
  key: ${CI_PROJECT_ID}
  paths:
  - .gradle/

build:
  stage: build
  script:
  - fastlane executeTwine
  - ./gradlew assembleDebug
  - s3cmd put app/build/reports/tests s3://${S3_BUCKET}/tests
  artifacts:
    paths:
    - app/build/outputs/apk/app-debug.apk
```
