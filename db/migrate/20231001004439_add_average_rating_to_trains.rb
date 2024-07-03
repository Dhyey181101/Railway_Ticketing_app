class AddAverageRatingToTrains < ActiveRecord::Migration[7.0]
  def change
    add_column :trains, :average_rating, :float
  end
end
