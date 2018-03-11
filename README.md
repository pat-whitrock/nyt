### Getting started

1. Make sure you're using the appropriate Ruby version (2.5.0) via your Ruby version management tool of choice (e.g. rbenv, rvm). If you're using 2.5.0 for the first time, remember to `gem install bundler`.
2. Install PostgreSQL if you haven't already (can't go wrong with [Homebrew](https://brew.sh)).
3. Run `bin/setup` to install gem dependencies, create, migrate, and seed the database with data from a live network request (so you'll need an active internet connection).
4. Run `bundle exec rake` to run the test suite.
5. Run `bundle exec rails server` to start the server.
6. The application should be visible at http://localhost:3000.

![](https://media.giphy.com/media/TaZddT2KC3wFa/giphy.gif)
