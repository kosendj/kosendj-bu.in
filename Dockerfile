FROM ruby:2.7.2-alpine3.13

RUN apk update && \
    apk add --no-cache tzdata curl-dev make g++ git bash nodejs yarn

RUN mkdir /app
WORKDIR /app

COPY ./Gemfile ./Gemfile.lock ./package.json ./yarn.lock ./

RUN gem install bundler -v 1.17.2
RUN bundle install
RUN yarn install

COPY . /app

ENV LANG=C.UTF-8
