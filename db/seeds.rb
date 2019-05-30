# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
API_KEY = ENV['GOOGLE_API_KEY']

customers = [
  {
    name: 'Customer A',
    api_key: API_KEY,
    query_type: 'atm',
    language: 'english',
    response_output: 'xml',
    locations: 200
  },
  {
    name: 'Customer B',
    api_key: API_KEY,
    query_type: 'bank',
    language: 'spanish',
    response_output: 'json',
    locations: 20
  },
  {
    name: 'Customer C',
    api_key: API_KEY,
    query_type: 'all',
    language: 'french',
    response_output: 'json',
    locations: 5
  }
]

customers.each do |customer|
  Customer.create(customer)
end
