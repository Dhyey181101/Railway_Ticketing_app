class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :train, null: false, foreign_key: true
      t.integer :rating, limit: 1
      t.text :feedback

      t.timestamps
    end
  end
end
