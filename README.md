# eurucamp-cfp

## development

* `cp .env.sample .env`
* `cp config/database.yml.example config/database.yml`
* update config files. You should register on Localeapp for an API key and add your personal `LOCALE_API_KEY`. 
* run migrations
* `bundle exec foreman start`

## deployment

* `bundle exec rake staging deploy`
* `bundle exec rake production deploy`

## Contributing to translations

- Edit the translations directly on the [eurucamp/call4papers](http://www.localeapp.com/projects/public?search=eurucamp/call4papers) project on Locale.
- **That's it!**
- The maintainer will then pull translations from the Locale project and push to Github.

Happy translating!
