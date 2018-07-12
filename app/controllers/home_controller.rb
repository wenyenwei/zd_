class HomeController < ApplicationController
  
  def index
    # request_tickets(ENV['ZENDESK_DOMAINNAME_URL'], ENV['ZENDESK_USERNAME'], ENV['ZENDESK_PASSWORD'])
    request_tickets

  end

  def delete_ticket
    begin
      Ticket.where(_id: params[:ticket_id]).delete
      # show ticket deleted flash
      flash[:success] = "You have successfully deleted 1 ticket."
      redirect_to root_path
    rescue StandardError => ex
      # re-write to flash
      flash[:danger] = ex.message
      puts ex.message
    end
  end

  def edit_ticket
    begin
      @ticket_id = params[:ticket_id].to_s
      render 'edit_ticket'
    rescue StandardError => ex
      # re-write to flash
      flash[:danger] = ex.message
      puts ex.message
    end
  end

  def show
  end

  private

  # def request_tickets(zendesk_url, zendesk_uid, zendesk_pwd)
  #   begin
  #     # use faraday library for http request
  #     require 'faraday'
  #     conn = Faraday.new(:url => zendesk_url) do |conn|
  #       conn.use Faraday::Response::RaiseError
  #       conn.use Faraday::Adapter::NetHttp
  #       # connect with authentication
  #       conn.basic_auth(zendesk_uid, zendesk_pwd)
  #     end
  #     response = conn.get 
  #     # pass response to front
  #     @ticket_info = JSON.parse response.body
  #   # catch exceptions
  #   rescue Faraday::Response::RaiseError => ex
  #     @error_message = ex.message
  #   rescue NoMethodError => ex
  #     @error_message = ex.message
  #   rescue Faraday::Error::ClientError => ex
  #     @error_message = ex.message
  #   rescue StandardError => ex
  #     @error_message = ex.message
  #   end
  # end

  def request_tickets
    begin
      # file_name = './tickets.json'
      # classes_copy_file = File.read(file_name)
      # @ticket_info = JSON.parse(classes_copy_file) 
      @ticket_info = Ticket.all
    rescue StandardError => ex
      @error_message = ex.message
    end
  end



end
