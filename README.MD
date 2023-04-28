# Workshop DB 03 - CTEs and window functions

## Docker based setup

Build the image and start the app with database:
```
docker-compose up
```

Access container:
```
docker-compose exec web bash
```

Run migrations and seeds:
```
./entrypoint.sh migrate
./entrypoint.sh seeds
```

Exit container and visit http://localhost:3000 to access workshop,
or http://localhost:8081 to access database browser.

## Raw configuration

```
cp config/{database.yml.example,database.yml}
```

### Installation

```
bundle install
bundle exec rake db:create db:migrate db:seed
```

### Usage

Starting a server:

```
PORT=3000 foreman start # app will start at http://localhost:3000
```

Starting a console:

```
./bin/irb
```
