class CreateTickets < ActiveRecord::Migration[7.0]
  def change
    create_table :tickets do |t|
      t.references :user, null: false, foreign_key: true
      t.references :train, null: false, foreign_key: true
      t.integer :confirmation_number, limit: 10

      t.timestamps
    end
  end
end
