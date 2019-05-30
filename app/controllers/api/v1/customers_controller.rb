class Api::V1::CustomersController < ApplicationController
  def create
    customer = Customer.new(customer_params)

    if customer.save
      status = :ok
      response = customer
    else
      status = :bad_request
      response = customer.errors.messages
    end

    render json: response, status: status
  end

  private

  def customer_params
    params.require(:customer).permit(Customer.attribute_names) if params[:customer]
  end
end
