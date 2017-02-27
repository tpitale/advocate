# Advocate #

Advocate provides tools for a concierge to help advocate for the homeless population of a city.

## Setup ##

1. clone
2. install ruby (2.3)
3. `bundle config build.libv8 --with-system-v8`
4. `bundle install`
5. `bin/rake db:create db:migrate db:seed`

## Running ##

`bundle exec foreman start`

## Bridge (for SMS) ##

https://github.com/tpitale/advocate-bridge

## Local Docker Setup ##

You can run all services together using https://github.com/tpitale/advocate-provision.

If you need to run one at a time follow the steps below:

### Postgres Setup for Docker ###

*Note:* You may have done this as part of AdvocateBridge setup

1. `sudo ifconfig lo0 alias 10.200.10.1/24`
2. Trust all postgresql connections from 10.200.10.1
3. Change `listen_addresses = '*'` OR `listen_addresses = 'localhost,10.200.10.1'

### ENV ###

*Note:* we advise installing `autoenv` (on macOS `brew install autoenv`) which loads `.env` when you `cd` into the project

1. `cp .env.sample .env`
2. configure `.env` with your username/password

### Run Docker Locally ###

`make run`

*Note:* while running locally, you can open a new terminal and run `make shell`

*Note:* rails autoloading does not yet work when running in docker

### TODO ###

1. rails autoloading without rebuilding docker
2. work with non-precompiled assets in development (probably nginx config not letting rails return assets)

## Build && Release ##

*Note:* Be sure to have `$DOCKER_REGISTRY` set to the registry you would like to use

`make release` will:

1. build
2. tag latest
3. push it to the registry
