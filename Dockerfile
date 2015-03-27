FROM ruby:2.2.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev libpq-dev libxml2-dev libxslt1-dev nodejs

WORKDIR /tmp
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN RAILS_ENV=development bundle install
RUN mkdir /cfp

ADD . /cfp
WORKDIR /cfp
