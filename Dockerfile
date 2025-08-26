FROM ruby:2.6.8-bullseye

# skip apt key parsing warning
ARG APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1

ENV RAILS_ENV production
ENV RACK_ENV production
ENV RAILS_SERVE_STATIC_FILES true
ENV RAILS_LOG_TO_STDOUT true
ENV BUNDLE_PATH /app/vendor/gems

WORKDIR /app

# Install PostgreSQL repository and Yarn repository
RUN curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | gpg --dearmor -o /usr/share/keyrings/postgresql-keyring.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/postgresql-keyring.gpg] http://apt.postgresql.org/pub/repos/apt bullseye-pgdg main" > /etc/apt/sources.list.d/pgdg.list \
    && curl -fsSL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor -o /usr/share/keyrings/yarn-keyring.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/yarn-keyring.gpg] https://dl.yarnpkg.com/debian stable main" > /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install -y --no-install-recommends \
        nodejs \
        yarn \
        libpq-dev \
        ca-certificates \
        postgresql-client-13 \
    && rm -rf /var/lib/apt/lists/*

COPY Gemfile* /app/
RUN bundle config --global frozen 1 \
    && bundle config --global set without 'development test' \
    && bundle config set force_ruby_platform true \
    && bundle install --jobs 4 --retry 2

COPY . /app
ENV RACK_ENV production

ENTRYPOINT [ "/app/entrypoint.sh" ]
EXPOSE 3000
CMD ["server"]
