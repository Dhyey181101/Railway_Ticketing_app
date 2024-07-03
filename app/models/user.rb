class User < ApplicationRecord
  has_secure_password

  has_many :tickets, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates :name, presence: true
  validates :username, presence: true, uniqueness: true
  validates :email_address, presence: true, uniqueness: true

  validates :email_address, format: {
    with: /^(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})\z/i,
    message: "is Invalid",
    multiline: true
  }

  validates :phone_number,
  format:    { with: /\A\d{10}\z/ },
  length:    { maximum: 10 },
  allow_blank: true

  validates :credit_card,
  format:    { with: /\A(\d{4}-){3}\d{4}/ },
  length:    { maximum: 19 }
  # allow_blank: true

  # validate :cannot_delete_admin_user, on: :destroy

  # private

  # def cannot_delete_admin_user
  #   if @user.admin? && User.admins.count == 1
  #     errors.add(:base, "Cannot delete the admin user.")
  #     throw(:abort)
  #   end
  # end

end
