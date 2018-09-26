class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.integer :num_of_boxes
      t.string :destination_address
      t.string :pickup_address
      t.datetime :departure_date
      t.datetime :arrival_date
      t.string :message
      t.string :user_email

      t.timestamps
    end
  end
end
