class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :username
      t.string :email_address
      t.string :password_digest
      t.string :phone_number
      t.string :credit_card
      t.text :address
      t.boolean :admin, default: false

      t.timestamps
    end
    add_index :users, :username, unique: true
    add_index :users, :email_address, unique: true
  end
end
