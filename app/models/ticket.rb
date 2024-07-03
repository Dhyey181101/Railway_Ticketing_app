class Ticket < ApplicationRecord
  belongs_to :user
  belongs_to :train

  

  # validates :confirmation_number, presence: true, uniqueness: true
  # validates :quantity, presence: true

end
