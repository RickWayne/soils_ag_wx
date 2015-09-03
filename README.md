== README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

When migrating from MySQL to PostgreSQL, need to translate:

* All e.g. 'w840' column names to 'w840'

* In all AWON and ASOS tables, old "id" field becomes "stnid"

* "stnid" pseudo-link field with AWON station number becomes real link, awon_station_id

* "stations" table in AWS becomes "awon_stations"

* "theDate" and "theTime" become just "date" and "time"

Please feel free to use a different markup language if you do not plan to run
<tt>rake doc:app</tt>.
