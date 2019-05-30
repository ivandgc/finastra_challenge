class Api::V1::SearchController < ApplicationController
  def index
    customer = Customer.find_by(name: params[:customer_name])

    if customer && params[:latitude] && params[:longitude]
      service = GoogleSearchService.new(customer, params[:latitude], params[:longitude])
      response = handle_request(service)

      status = :ok
      results = check_response_count(response, customer, service)
    else
      status = :bad_request
      results = {}
    end

    render json: results, status: status
  end

  private

  def handle_request(service)
    service_response = service.get_request
    JSON.parse(service_response.body)
  end

  def check_response_count(response, customer, service)
    pagetoken = response['next_page_token']
    results = response['results']

    if get_next_page?(pagetoken, results.count , customer)
      service.set_next_results(pagetoken, customer)
      next_page_response = handle_request(service)
      results += next_page_response['results']

      last_response = next_page_response['status'] == 'INVALID_REQUEST' ? response : next_page_response
      results += check_response_count(last_response, customer, service) if get_next_page?(last_response['next_page_token'], results.count, customer)
    end

    results = results[0..(customer.locations - 1)] if results.count > customer.locations
    results
  end

  def get_next_page?(pagetoken, results_count, customer)
    pagetoken && (results_count < customer.locations)
  end
end
