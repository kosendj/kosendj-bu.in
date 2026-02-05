FROM ruby:3.4-slim-bookworm

RUN apt-get update \
    && apt-get install --no-install-recommends -y build-essential git libpq-dev curl \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g pnpm@10.11.1 \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /app
WORKDIR /app

COPY ./Gemfile ./Gemfile.lock ./package.json ./.npmrc ./

RUN gem install bundler
RUN bundle install
RUN pnpm install

COPY . /app

ENV LANG=C.UTF-8
