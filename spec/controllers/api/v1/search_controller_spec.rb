require 'rails_helper'

RSpec.describe Api::V1::SearchController, type: :controller do
  NUMBER_OF_LOCATIONS = 25

  let(:create_test_customer) {
    Customer.create(
      name: 'test_customer',
      api_key: ENV['GOOGLE_API_KEY'],
      query_type: 'atm',
      language: 'english',
      response_output: 'json',
      locations: NUMBER_OF_LOCATIONS
    )
  }

  let(:query) {
    {
      customer_name: 'test_customer',
      latitude: '30.4284750',
      longitude: '-97.7550500'

    }
  }

  context 'invalid request' do
    it 'responds with 400 code' do
      post :index
      expect(response).to have_http_status(400)
    end
  end

  context 'valid request' do
    before(:each) do
      stub_request(:any, /maps.googleapis.com/).
        with(headers: {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
        to_return(status: 200, body: {results: [*1..NUMBER_OF_LOCATIONS]}.to_json, headers: {})
    end

    it 'responds with 200 code' do
      create_test_customer
      post :index, params: query
      expect(response).to have_http_status(200)
    end

    it 'returns the correct amount of locations' do
      create_test_customer
      post :index, params: query

      response_body = JSON.parse(response.body)
      expect(response_body.count).to eq(NUMBER_OF_LOCATIONS)
    end
  end
end
