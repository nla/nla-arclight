#!/bin/bash

redis_cache_clear() {
  keys=$(redis-cli -n 0 KEYS "arclight:*")

  if [[ $keys ]]; then
    redis-cli -n 0 DEL $keys
  fi
}

ORIGDIR=$(pwd)
export ORIGDIR
source ~/.bashrc

export GEM_HOME=$ORIGDIR/gems
export GEM_PATH=$ORIGDIR/gems

echo "Build env $RAILS_ENV, unzip into $WEBROOT.. PWD $ORIGDIR"
export PATH=$GEM_PATH/bin:$PATH
export http_proxy=admin.nla.gov.au:3128
export https_proxy=admin.nla.gov.au:3128
cd "$ORIGDIR" || return

RUBY_VERSION=$(cat .ruby-version)
echo "Checking rbenv Ruby version $RUBY_VERSION is installed."
if [[ ! -d "/apps/etc/.rbenv/versions/$RUBY_VERSION" ]]; then
  echo "Ruby $RUBY_VERSION is not installed. Installing with rbenv..."
  rbenv install "$RUBY_VERSION"
  echo "Finished installing Ruby $RUBY_VERSION; continuing deployment..."
else
  echo "Ruby $RUBY_VERSION found; continuing deployment..."
fi

gem install bundler
bundle config --local jobs $(nproc)
bundle config --local path "vendor/bundle"
bundle config --local build.nokogiri --use-system-libraries

if [[ "$RAILS_ENV" == "staging" || "$RAILS_ENV" == "production" ]]; then
 bundle config --local without "development:test"
fi

bundle install
RAILS_ENV=$RAILS_ENV bundle exec rails db:migrate
RAILS_ENV=$RAILS_ENV bundle exec rails assets:precompile
if [[ "$RAILS_CACHE_DEV" == "y" ]]; then
  RAILS_ENV=$RAILS_ENV bundle exec rails dev:cache
fi

# try to fix permissions in vendor/bundle
chmod -R o+r ./vendor/bundle

mkdir -p "$ARCLIGHT_TMP_PATH"/pids

RAILS_ENV=$RAILS_ENV bundle exec rails log:clear tmp:clear
# Clear the Redis cache
redis_cache_clear

# Remove a potentially pre-existing server.pid for Rails.
rm -f "$PIDFILE"

cp -R .bundle .ruby-version ./** "$1"
