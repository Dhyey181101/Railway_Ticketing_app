class CreateTrains < ActiveRecord::Migration[7.0]
  def change
    create_table :trains do |t|
      t.integer :train_number, limit: 5
      t.string :departure_station
      t.string :termination_station
      t.date :departure_date
      t.time :departure_time
      t.date :arrival_date
      t.time :arrival_time
      t.decimal :ticket_price
      t.integer :max_seats
      t.integer :available_seats

      t.timestamps
    end
  end
end
