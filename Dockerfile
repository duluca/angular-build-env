FROM node:8.6-alpine as builder

RUN apk add --update --no-progress make python bash
ENV NPM_CONFIG_LOGLEVEL error

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY karma.conf.js .
COPY protractor.conf.js .
COPY tsconfig.json .
COPY tslint.json .
COPY package.json .
COPY package-lock.json .
COPY .angular-cli.json .
COPY e2e e2e
COPY src src

RUN npm install
RUN npx ng build --prod