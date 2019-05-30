# README

Project solution for Finastra Ruby Code Challenge: allows you to create customers via the '/customer/create' endpoint and query via the '/search' endpoint the Google Places API using those customers to get places near a location

* Ruby version: 2.3.1
* Rails version: 5.1.7

* Configuration:
  Set GOOGLE_API_KEY as ENV variable.

* To run locally:
  bundle install
  rake db:create
  rake db:migrate
  rake db:seed

* To run all tests from terminal:
  rspec

* Documentation:

  /customer/create required params:
    name: string
    api_key: string
    query_type: string
    language: string
    response_output: string
    locations: integer

  /search required params:
    customer_name: string
    latitude: string
    longitude: string

* To Continue:
  Create CRUD functionality for Customer class
