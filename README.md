# angular-build-env
> Angular CLI and Docker multi-stage compatible Alpine Node Build Environment

Use the multi-stage `Dockerfile` below in your Angular CLI generated project to build and ship your Angular application on its own Node server.

For more details see [Minimal Node Web Server](https://github.com/duluca/minimal-node-web-server) and [Angular 4 Material 2 Starter](https://github.com/duluca/angular4-material2-starter).

```Dockerfile
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

FROM duluca/minimal-node-web-server:8.6.0

WORKDIR /usr/src/app
COPY --from=builder /usr/src/app/dist public
```