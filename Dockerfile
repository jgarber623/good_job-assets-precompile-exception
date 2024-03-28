FROM ruby:3.1.4-bookworm

ARG WORKDIR=/usr/src/app

ENV BUNDLE_DEPLOYMENT=1 \
    BUNDLE_PATH=${WORKDIR}/vendor/bundle \
    BUNDLE_WITHOUT=development:test

ENV RAILS_ENV=production

WORKDIR ${WORKDIR}

COPY . .

ARG SECRET_KEY_BASE

RUN bundle install

RUN bundle exec rake assets:precompile
