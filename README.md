# Advocate #

Advocate provides tools for a concierge to help advocate for the homeless population of a city.

## Setup ##

1. clone
2. install ruby
3. bundle install
4. `bundle config build.libv8 --with-system-v8`
5. `rake db:create db:migrate db:seed`

## Running ##

`foreman start`

## Bridge ##

https://github.com/tpitale/advocate-bridge

## Local Docker Setup ##

1. configure `.env`
2. `sudo ifconfig lo0 10.200.10.1/24`
3. Trust all postgresql connections from 10.200.10.1
4. Change `listen_addresses = '*'` OR `listen_addresses = 'localhost,10.200.10.1'
