class CreateCustomerBookings < ActiveRecord::Migration[5.1]
  def change
    create_table :customer_bookings do |t|
      t.integer :num_of_boxes
      t.string :destination_address
      t.string :pickup_address
      t.datetime :departure_date
      t.datetime :arrival_date
      t.string :message
      t.string :user_email
      t.string :status
      t.datetime :pickup_datetime
      t.integer :cost
      t.string :HBL_number
      t.string :message_to_customer

      t.timestamps
    end
  end
end
