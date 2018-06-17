class HomeController < ApplicationController
  
  def index
    request_tickets(ENV['ZENDESK_DOMAINNAME_URL'], ENV['ZENDESK_USERNAME'], ENV['ZENDESK_PASSWORD'])
  end

  private

  def request_tickets(zendesk_url, zendesk_uid, zendesk_pwd)
    begin
      # use faraday library for http request
      require 'faraday'
      conn = Faraday.new(:url => "https://internchallenge.zendesk.com/api/v2/tickets.json") do |conn|
        conn.use Faraday::Response::RaiseError
        conn.use Faraday::Adapter::NetHttp
        # connect with authentication
        conn.basic_auth(zendesk_uid, zendesk_pwd)
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
