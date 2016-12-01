# AgWeather

## Getting Started

```bash
# create database configuration (copy from template)
cp config/database.yml{.example,}

# create the databases
bundle exec rake db:create db:migrate db:seed db:test:prepare

# run the server!
bundle exec rails server
```

## Running Tests
```bash
bundle exec rake test
```

## Migration Notes
When migrating from MySQL to PostgreSQL, need to translate:

* All e.g. 'w840' column names to 'w840'
* In all AWON and ASOS tables, old "id" field becomes "stnid"
* "stnid" pseudo-link field with AWON station number becomes real link, awon_station_id
* "stations" table in AWS becomes "awon_stations"
* "theDate" and "theTime" become just "date" and "time"
