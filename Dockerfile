FROM ruby:3.4-slim-bookworm

RUN apt-get update \
    && apt-get install --no-install-recommends -y build-essential git libpq-dev curl ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Node / pnpm は mise.toml の宣言どおりに mise が入れる。
# Ruby はベースイメージのものを使うので mise 側では扱わない。
RUN curl -fsSL https://mise.run | sh
ENV PATH="/root/.local/share/mise/shims:/root/.local/bin:${PATH}" \
    MISE_TRUSTED_CONFIG_PATHS=/app \
    MISE_DISABLE_TOOLS=ruby \
    MISE_YES=1

RUN mkdir /app
WORKDIR /app

COPY ./Gemfile ./Gemfile.lock ./package.json ./pnpm-lock.yaml ./pnpm-workspace.yaml ./mise.toml ./

RUN mise install
RUN gem install bundler
RUN bundle install
RUN pnpm install --frozen-lockfile

COPY . /app

ENV LANG=C.UTF-8
