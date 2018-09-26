json.extract! booking, :id, :num_of_boxes, :destination_address, :pickup_address, :departure_date, :arrival_date, :message, :user_email, :created_at, :updated_at
json.url booking_url(booking, format: :json)
