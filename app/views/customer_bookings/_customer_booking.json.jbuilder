json.extract! customer_booking, :id, :num_of_boxes, :destination_address, :pickup_address, :departure_date, :arrival_date, :message, :user_email, :status, :pickup_datetime, :cost, :HBL_number, :message_to_customer, :created_at, :updated_at
json.url customer_booking_url(customer_booking, format: :json)
