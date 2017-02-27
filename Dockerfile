# FROM ruby:2.4.0-slim # switch after Rails 5+
FROM ruby:2.3.3-slim
LABEL maintainer Tony Pitale <tpitale@gmail.com>

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -yq && apt-get install -y \
  build-essential \
  libpq-dev \
  libssl-dev \
  nodejs \
  zlib1g-dev

WORKDIR /app
RUN mkdir -p log
RUN mkdir -p /app/tmp/pids && chmod 755 /app/tmp/pids

# RUN gem update --system 2.6.8 && gem install bundler

ADD Gemfile Gemfile.lock /app/

RUN bundle config build.libv8 --with-system-v8
RUN bundle install

EXPOSE 80

ADD . /app

ARG BUILD_ENV=dev
ENV RAILS_ENV=$BUILD_ENV

RUN bin/rake assets:precompile

VOLUME /app/public/assets

# RAILS_ENV should be set in env_file or docker-compose.yml
CMD foreman start -f Procfile.docker >> /app/log/foreman.log 2>&1
