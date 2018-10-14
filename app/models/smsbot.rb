class Smsbot
  require 'rubygems'
  require 'twilio-ruby'
  require 'date'
  require 'time'
  require 'slack-notifier'
  require 'rufus-scheduler'
  class << self
    def perform
      begin
        scheduler = Rufus::Scheduler.singleton
        puts 'Setting up WIW...'
        account_sid = ENV['TWILIO_SID']
        auth_token = ENV['TWILIO_AUTH_TOKEN']

        # set up a client to talk to the Twilio REST API
        client = Twilio::REST::Client.new account_sid, auth_token

        # setup SMS
        puts 'scheduling...'
        scheduler.every '24h', :first_in => '15h' do
          send_to_me("It's a new day! Get new shifts and users from WIW!")
          Faraday_WIW.work

          send_to_me("Get unique times of shifts!")
          Faraday_WIW.shifts_check_scheduler.each do |time|
            scheduler.at (Time.parse(time) - 2.5*60*60).to_s do
              scheduled_sends(time, client)
            end
            scheduler.at (Time.parse(time) - 60*60).to_s do
              scheduled_updates(client, time)
            end
          end

          send_to_me("Daily work scheduled!")
          scheduler.every '24h', :first_in => '1m' do
            cleanup_all
          end
        end

        puts 'All scheduling done!'


      rescue StandardError => ex
        error_message = ex.message
      end
      if error_message.present?
        puts "Twilio Set Up Error:", error_message
      end
    end

    private

    def cleanup_all
      ReadWrite.write("current_shifts.json", "public", "files", [])
      ReadWrite.write("wiw_users.json", "public", "files", [])
      ReadWrite.write("wiw_locations.json", "public", "files", [])
      send_to_me("Cleared up.")
    end

    def cleanup_msg
      ReadWrite.write("wiw_today_messages.json", "public", "files", [])
      send_to_me("Messages cleared.")
    end

    def scheduled_sends(time, client)
      begin
        puts "prevent exec"
        if Time.now >= Time.parse(time) - 2.5*60*60 and Time.now + 60*60 <= Time.parse(time)
          shifts = ReadWrite.read("current_shifts.json", "public", "files")
          if shifts.present?
            shifts.each do |shift|
              # if matched
              if Time.parse(shift["start_time"]).to_s == time
                puts 'should send..'
                send_SMS(client, get_user_phone(shift['user_id']))
                send_to_me(mock_sms_msg(get_user_name(shift['user_id'])))
                puts 'passed send..'
              end
            end
          end
        end
      rescue StandardError => ex
        send_to_me("ERROR: "+ ex.message)
      end
    end

    def scheduled_updates(client, time)
      begin
        #  read inbound messages and write to local json
        read_inbound_messages(client)
        send_to_me("Inbound messages updated!")
        puts "Inbound messages updated!"

        # compare shifts and messages
        shifts = ReadWrite.read("current_shifts.json", "public", "files")
        messages = ReadWrite.read("wiw_today_messages.json", "public", "files")
        if shifts.present?
          is_replied = false
          shifts.each do |shift|
            if messages.present?
              messages.each do |msg|
                # if matched
                if msg["from"] == get_user_phone(shift["user_id"]) and Time.parse(shift["start_time"]).to_s == time and Time.parse(msg["datetime"]) > Time.parse(shift["start_time"]) - 2.5*3600 and Time.parse(msg["datetime"]) < Time.parse(shift["start_time"])
                  is_replied = true
                  # process msg
                  if msg["body"] == "1"
                    send_to_me("User replied with 1")
                    send_slack(msg, shift, "*On Track* :white_check_mark:")
                  else
                    send_to_me("User replied with " + msg["body"])
                    send_slack(msg, shift, "*Alert* :warning:")
                  end
                end
              end
            end
            if not is_replied and Time.parse(shift["start_time"]).to_s == time and Time.parse(shift["start_time"]) < (Time.now + 60*60) and Time.parse(shift["start_time"]) > Time.now
              msg = {"body" => "No Reply"}
              send_slack(msg, shift, "*RED ALERT!* :rotating_light:")
            end
          end
        end
        puts 'All good schedule updates!'
        cleanup_msg
      rescue StandardError => ex
        send_to_me("ERROR: "+ ex.message)
      end
    end

    def get_user_phone(user_id)
      phone_to_return = nil
      users = ReadWrite.read('wiw_users.json', 'public', 'files')
      users.each do |user|
        if user[0].to_s == user_id.to_s
          phone_to_return = user[1]['phone_number']
        end
      end
      phone_to_return
    end

    def get_user_name(user_id)
      name_to_return = nil
      users = ReadWrite.read('wiw_users.json', 'public', 'files')
      users.each do |user|
        if user[0].to_s == user_id.to_s
          name_to_return = user[1]['first_name'] + " " + user[1]['last_name']
        end
      end
      name_to_return
    end

    def get_user_location(location_id)
      location_to_return = nil
      locations = ReadWrite.read("wiw_locations.json", "public", "files")
      locations.each do |location|
        if location_id == location["id"]
          location_to_return = location["name"]
        end
      end
      location_to_return
    end

    def read_inbound_messages(client)
      begin
        date = Time.now.to_s.split(" ")[0].split("-")
        messages = client.messages.list(
            date_sent: Date.new(date[0].to_i, date[1].to_i, date[2].to_i),
            to: '+61451266400'
        )

        sms_data = []
        messages.each do |record|
          sms_data << {sid: record.sid, from: record.from, body: record.body, datetime: record.date_sent}
        end

        # write today's message to file
        ReadWrite.write('wiw_today_messages.json', 'public', 'files', sms_data)

      rescue StandardError => ex
        puts 'Setup WIW Error:', ex.message
      end
    end

    def send_SMS(client, number)
      client.api.account.messages.create(
          from: '+61451266400',
          to: number,
          body: "Hi from ConnectBot!
On track for your session today?
Reply '1' = 'Yes, I’m on track.'
Reply '2' = 'Small issue, still on track.'
Issue? = Call 0488 807 660 ASAP.
Reply at least 1 hr before session or we’ll call to ensure all is okay :)
***Please bring your WWCC***
NOTE: Automated system, only reply '1' or '2'."
      )
    end

    def send_slack(msg, shift, type)
      puts 'sending slack msg...'
      notifier = Slack::Notifier.new "https://hooks.slack.com/services/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"
      notifier.ping "#{type}
Name: #{get_user_name(shift['user_id'])}
Replied: #{msg["body"]}
Shift Starting: #{shift['start_time']}
Shift Location: #{get_user_location(shift['location_id'])}
Phone: #{get_user_phone(shift['user_id'])}
                    "
      puts 'slack sent!'
    end

    def send_to_me(input)
      notifier = Slack::Notifier.new "https://hooks.slack.com/services/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"
      notifier.ping input
    end

    def mock_sms_msg(user_name)
      return 'Hi '+user_name+' from ConnectBot!
On track for your session today?
Reply "1" = "Yes, I’m on track."
Reply "2" = "Small issue, still on track."
Issue? = Call 8103 5028 ASAP.
Reply at least 1 hr before session or we’ll call to ensure all is okay :)
Please also remember your WWCC!
NOTE: Automated system, only reply 1 or 2.'
    end
  end
end