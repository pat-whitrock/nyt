### Getting started

1. Make sure you're using the appropriate Ruby version (2.5.0) via your Ruby version management tool of choice (e.g. rbenv, rvm). If your Ruby version manager is unable to install 2.5.0, you may have to update it (e.g. `brew update rbenv`). If you're using 2.5.0 for the first time, remember to `gem install bundler`.
2. Install PostgreSQL if you haven't already (can't go wrong with [Homebrew](https://brew.sh)).
3. Run `bundle exec bin/setup` to install gem dependencies, create, migrate, and seed the database with data from a live network request (so you'll need an active internet connection).
4. Run `RAILS_ENV=test bundle exec rake` to run the test suite.
5. Run `bundle exec rails server` to start the server.
6. The application should be visible at http://localhost:3000.

![](https://media.giphy.com/media/TaZddT2KC3wFa/giphy.gif)

### Running against the next version of Rails

The current `Gemfile` is using Rails 5.1.5, which is the latest stable version. In order to maintain forward compatibility with future versions, developers should strive to maintain all functionality and a passing test suite using both the current and next version of Rails. Use the `BUNDLE_GEMFILE=Gemfile.next` environment variable to do so. For example:

1. `BUNDLE_GEMFILE=Gemfile.next bundle exec bin/setup`
2. `BUNDLE_GEMFILE=Gemfile.next RAILS_ENV=test bundle exec rake`
3. `BUNDLE_GEMFILE=Gemfile.next bundle exec rails server`
