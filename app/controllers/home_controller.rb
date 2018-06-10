class HomeController < ApplicationController
	before_action :request_tickets
  
  def index
  end

  private

  def request_tickets
    begin
      # use faraday library for http request
      require 'faraday'
      url = "https://#{ENV['ZENDESK_DOMAINNAME']}.zendesk.com/api/v2/tickets.json"
      conn = Faraday.new(:url => url) do |conn|
        conn.use Faraday::Response::RaiseError
        conn.use Faraday::Adapter::NetHttp
        # connect with authentication
        conn.basic_auth(ENV['ZENDESK_USERNAME'], ENV['ZENDESK_PASSWORD'])
      end
      response = conn.get 
      # pass response to front
      @ticket_info = JSON.parse response.body
    # catch exceptions
    rescue Faraday::Response::RaiseError => ex
      @error_message = ex.message
    rescue NoMethodError => ex
      @error_message = ex.message
    rescue Faraday::Error::ClientError => ex
      @error_message = ex.message
    rescue StandardError => ex
      @error_message = ex.message
    end
  end
end
