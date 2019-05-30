require 'rails_helper'

RSpec.describe Customer, type: :model do

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

  context 'Customer model validations' do
    it 'requires all fields' do
      expect(Customer.new).not_to be_valid
    end

    it 'name is unique' do
      customer_1 = Customer.create!(customer)
      customer_2 = Customer.new(customer)
      expect(customer_2).not_to be_valid
    end
  end
end
