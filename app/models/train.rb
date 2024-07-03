class Train < ApplicationRecord
  has_many :tickets, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates :train_number, presence: true, length: { is: 5 }

  validates :departure_station, presence: true
  validates :termination_station, presence: true, exclusion: { in: ->(train) { [train.departure_station] }, message: "and Departure station can't be the same" }

  validates :departure_date, :arrival_date, :departure_time, :arrival_time, presence: true
  validate :departure_must_be_earlier_than_arrival

  validates :available_seats, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :max_seats, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validate :available_seats_within_capacity

  validates :ticket_price, presence: true, numericality: { greater_than: 0 }

  private

  def departure_must_be_earlier_than_arrival
    if departure_date.present? && arrival_date.present? &&
        (departure_date > arrival_date || (departure_date == arrival_date && departure_time >= arrival_time))
      errors.add(:base, "Departure must be earlier than arrival")
    end
  end

  def update_train_average_rating
    new_average_rating = reviews.average(:rating).to_f
    update(average_rating: new_average_rating)
  end

  def available_seats_within_capacity
    if available_seats && available_seats > max_seats
      errors.add(:available_seats, "cannot be greater than train capacity")
    end
  end
end
