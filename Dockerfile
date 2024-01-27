FROM ruby:3.2.3-alpine3.19

RUN apk update && \
    apk add --no-cache tzdata curl-dev make g++ git bash nodejs yarn

RUN mkdir /app
WORKDIR /app

COPY ./Gemfile ./Gemfile.lock ./package.json ./yarn.lock ./

RUN gem install bundler
RUN bundle install
RUN yarn install

COPY . /app

ENV LANG=C.UTF-8
