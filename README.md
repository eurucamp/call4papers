# eurucamp Call for Papers [![License](http://img.shields.io/:license-AGPL-0030c8.svg)](COPYRIGHT) [![Build Status](https://travis-ci.org/eurucamp/call4papers.png?branch=master)](https://travis-ci.org/eurucamp/call4papers)

The eurucamp Call for Papers application allows users to submit conference proposals or suggest speakers. Signup works through Github or Twitter.

## Donationware

This app was originally created by the team from [wroc_love.rb](http://wrocloverb.com/).

This app is currently maintained by members of the Ruby Berlin e.V. on their free time as a community effort for the eurucamp conference. Ruby Berlin is the body behind RailsGirls Berlin and Hamburg, eurucamp and JRubyConf.eu.

If you end up using the app, please get in [contact](mailto:info@eurucamp.org) so that we know. Also, spread the word about our [projects](http://rubyberlin.org). Also, consider [donating](https://www.betterplace.org/en/organisations/ruby-berlin/), especially, if you run a commercial conference. We are a registered non-profit, donations are tax deducible. Betterplace handles all paperwork - if in doubt, send us a mail.

If you cannot or don't want to donate - use it, it's free.

## Logo

Don't use the eurucamp logo for your instance to avoid confusion.


## Development
An installed postgresql instance and a compiler is needed.

### **ENV** variables used:

* `GITHUB_KEY`: Your github application key.
* `GITHUB_SECRET`: Your github application secret.
* `TWITTER_KEY`: Your twitter application key.
* `TWITTER_SECRET`: Your twitter application secret.
* `LOCALE_API_KEY`: Your key for Locale.

### Basic setup

* `cp .env.sample .env`
* `cp config/database.yml.example config/database.yml`
* update config files. You should register on Localeapp for an API key and add your personal `LOCALE_API_KEY`.
* run migration scripts
* `bundle exec foreman start`

## Deployment

* `bundle exec rake staging deploy`
* `bundle exec rake production deploy`

## Contributing to translations

- Edit the translations directly on the [eurucamp/call4papers](http://www.localeapp.com/projects/public?search=eurucamp/call4papers) project on Locale.
- **That's it!**
- The maintainer will then pull translations from the Locale project and push to Github.

Happy translating!

## Authors

This app was originally created by the team from [wroc_love.rb](http://wrocloverb.com/) and subsequently extended by the eurucamp team.

## License

GNU-AGPL-3.0, see COPYRIGHT for details.
