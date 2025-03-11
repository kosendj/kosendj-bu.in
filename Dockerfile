FROM ruby:3.3-slim-bookworm

RUN apt-get update \
    && apt-get install --no-install-recommends -y build-essential git libpq-dev curl \
    && curl -sL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /app
WORKDIR /app

COPY ./Gemfile ./Gemfile.lock ./package.json ./yarn.lock ./

RUN gem install bundler
RUN bundle install
RUN corepack enable && corepack install
RUN yarn install

COPY . /app

ENV LANG=C.UTF-8
