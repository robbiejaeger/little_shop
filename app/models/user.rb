class User < ActiveRecord::Base
  has_secure_password

  validates :username, presence: true
  validates :email, presence: true
  validates :password, presence: true
  validates :role, presence: true
  validate :password_correct?, on: :update

  has_many :donations
  has_many :donation_items, through: :donations

  enum role: ["default", "admin"]

  attr_accessor :current_password

  def password_correct?
    if !password.blank?
      user = User.find_by_id(id)
      if !user.authenticate(current_password)
        errors.add(:current_password, "is incorrect.")
      end
    end
  end
end
