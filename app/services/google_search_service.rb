require "net/http"

class GoogleSearchService
  BASE_URL = 'https://maps.googleapis.com/maps/api/place/nearbysearch/'

  def initialize(customer, latitude, longitude)
    query_params = {
      key: customer.api_key,
      keyword: customer.keyword,
      language: customer.language,
      location: "#{latitude},#{longitude}",
      rankby: 'distance'
    }

    uri = URI.parse(BASE_URL + "#{customer.response_output}?" + query_params.to_query)
    @http = Net::HTTP.new(uri.host, uri.port)
    @http.use_ssl = true
    @request = Net::HTTP::Get.new(uri.request_uri)
  end

  def get_request
    @http.request(@request)
  end

  def set_next_results(pagetoken, customer)
    query_params = {
      key: customer.api_key,
      pagetoken: pagetoken,
    }

    uri = URI.parse(BASE_URL + "#{customer.response_output}?" + query_params.to_query)
    @http = Net::HTTP.new(uri.host, uri.port)
    @http.use_ssl = true
    @request = Net::HTTP::Get.new(uri.request_uri)
  end
end
