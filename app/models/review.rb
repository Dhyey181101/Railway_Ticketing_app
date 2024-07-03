# app/models/review.rb
class Review < ApplicationRecord
  belongs_to :user
  belongs_to :train

  validates :rating, inclusion: { in: 0..5, message: "%{value} is not a valid rating" }

  after_create :update_train_average_rating

  private

  def update_train_average_rating
    # Calculate the new average rating for the associated train
    new_average_rating = train.reviews.average(:rating)

    # Update the train's average_rating attribute
    train.update(average_rating: new_average_rating)
  end
end
