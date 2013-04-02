# eurucamp-cfp

## development

* `cp .env.sample .env`
* `cp config/database.yml.sample config/database.yml`
* update config files
* run migrations
* `bundle exec foreman start`

## deployment

* `bundle exec rake staging deploy`
* `bundle exec rake production deploy`