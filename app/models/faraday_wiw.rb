class Faraday_WIW
  require 'faraday'
  require 'json'

  class << self
    def work
      begin
        conn = Faraday.new(:url => "https://api.wheniwork.com/2/login") do |conn|
          conn.use Faraday::Response::RaiseError
          conn.request  :url_encoded

          # connect with authentication
          conn.basic_auth(ENV['WIW_UID'], ENV['WIW_PWD'])
          conn.use Faraday::Adapter::NetHttp
        end

        response = conn.post do |req|
          req.headers['Content-Type'] = 'application/json'
          req.body = {
              "username": ENV['WIW_UID'],
              "password": ENV['WIW_PWD'],
              "key": ENV['WIW_KEY']
          }.to_json
        end

        response_data = JSON.parse response.body
        token = response_data["user"]["token"]

        get_new_shifts(token)
        get_users(token)
        get_locations(token)

      # catch exceptions
      rescue Faraday::Response::RaiseError => ex
        error_message = ex.message
      rescue NoMethodError => ex
        error_message = ex.message
      rescue Faraday::Error::ClientError => ex
        error_message = ex.message
      rescue StandardError => ex
        error_message = ex.message
      end
      if error_message.present?
        puts 'Faraday WIW Error:', error_message
      end
    end

    def shifts_check_scheduler
      list_to_return = []
      temp_list = []
      shifts = ReadWrite.read("current_shifts.json", "public", "files")
      shifts.each do |shift|
        if not temp_list.include? shift['start_time']
          temp_list << shift['start_time']
        end
      end

      temp_list.each do |time|
        list_to_return << Time.parse(DateTime.strptime(time.split(", ")[1], "%d %b %Y %H:%M:%S %z").to_s).to_s
      end
      list_to_return
    end

    private

    def get_locations(token)
      begin
        puts 'Getting locations from WIW thru Faraday...'
        conn = Faraday.new(:url => "https://api.wheniwork.com/2/locations") do |conn|
          conn.use Faraday::Response::RaiseError
          conn.request  :url_encoded
          conn.use Faraday::Adapter::NetHttp
        end

        response = conn.get do |req|
          req.headers['Content-Type'] = 'application/json'
          req.headers['W-Token'] = token
        end
        locations_to_return = []
        response = JSON.parse response.body
        response["locations"].each do |location|
          locations_to_return << {"name": location["name"], "id": location["id"]}
        end
        puts 'Writing locations to json...'
        ReadWrite.write("wiw_locations.json", "public", "files", locations_to_return)
        puts 'Writing locations done!'

      rescue Faraday::Response::RaiseError => ex
        error_message = ex.message
      rescue NoMethodError => ex
        error_message = ex.message
      rescue Faraday::Error::ClientError => ex
        error_message = ex.message
      rescue StandardError => ex
        error_message = ex.message
      end
      if error_message.present?
        puts 'Get New Locations Error:', error_message
      end
    end

    def get_new_shifts(token)
      begin
        puts 'Getting shifts from WIW thru Faraday...'
        conn = Faraday.new(:url => "https://api.wheniwork.com/2/shifts/?start=#{Time.now.to_s.split("+")[0]}&end=#{(Time.now + 24*60*60).to_s.split("+")[0]}") do |conn|
          conn.use Faraday::Response::RaiseError
          conn.request  :url_encoded
          conn.use Faraday::Adapter::NetHttp
        end

        response = conn.get do |req|
          req.headers['Content-Type'] = 'application/json'
          req.headers['W-Token'] = token
        end
        position_list = [1554586, 1554589, 8540844]
        response_to_record = []
        response = JSON.parse response.body
        response["shifts"].each do |shift|
          if position_list.include? shift["position_id"]
            response_to_record << {"user_id": shift["user_id"], "location_id": shift["location_id"], "start_time": shift["start_time"]}
          end
        end
        puts 'Writing shifts to json...'
        ReadWrite.write("current_shifts.json", "public", "files", response_to_record)
        puts 'Writing shifts done!'

      rescue Faraday::Response::RaiseError => ex
        error_message = ex.message
      rescue NoMethodError => ex
        error_message = ex.message
      rescue Faraday::Error::ClientError => ex
        error_message = ex.message
      rescue StandardError => ex
        error_message = ex.message
      end
      if error_message.present?
        puts 'Get New Shifts Error:', error_message
      end
    end

    def get_users(token)
      begin
        puts 'Getting Users Info...'
        conn = Faraday.new(:url => "https://api.wheniwork.com/2/users") do |conn|
          conn.use Faraday::Response::RaiseError
          conn.request  :url_encoded
          conn.use Faraday::Adapter::NetHttp
        end

        response = conn.get do |req|
          req.headers['Content-Type'] = 'application/json'
          req.headers['W-Token'] = token
        end
        user_data = JSON.parse response.body
        user_data = user_data["users"]
        wiw_user_dict = {}

        # write shifts to json file
        puts 'Writing Users Info to Local JSON...'
        user_data.each do |user|
          wiw_user_dict[user['id']] = {"first_name": user["first_name"], "last_name": user["last_name"], "phone_number": user["phone_number"], "id": user["id"]}
        end
        ReadWrite.write("wiw_users.json", "public", "files", wiw_user_dict)

        puts 'Writing Users Done!'
      # catch exceptions
      rescue Faraday::Response::RaiseError => ex
        error_message = ex.message
      rescue NoMethodError => ex
        error_message = ex.message
      rescue Faraday::Error::ClientError => ex
        error_message = ex.message
      rescue StandardError => ex
        error_message = ex.message
      end
      if error_message.present?
        puts 'Get Users Error:', error_message
      end
    end

  end

end