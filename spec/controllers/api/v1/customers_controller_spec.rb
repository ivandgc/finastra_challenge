require 'rails_helper'

RSpec.describe Api::V1::CustomersController, type: :controller do
  let(:customer) {
    {
      name: 'test_customer',
      api_key: '123',
      query_type: 'atm',
      language: 'english',
      response_output: 'json',
      locations: 200
    }
  }

  context '#create' do
    context 'invalid requests' do
      it 'responds with 400 code' do
        post :create
        expect(response).to have_http_status(400)
      end

      it 'sends appropriate error message' do
        test_customer = customer.except(:name)
        post :create, params: { customer: test_customer }

        response_body = JSON.parse(response.body)
        expect(response_body['name'][0]).to eq("can't be blank")
      end
    end

    context 'creates customer' do
      it 'responds with 200 code' do
        post :create, params: { customer: customer }

        expect(response).to have_http_status(200)
      end

      it 'responds with created customer' do
        post :create, params: { customer: customer }

        response_body = JSON.parse(response.body)
        expect(response_body['name']).to eq(customer[:name])
      end
    end
  end
end
