class User < ActiveRecord::Base
  has_secure_password

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validate :password_correct?, on: :update

  has_many :donations
  has_many :donation_items, through: :donations
  has_many :user_roles
  has_many :roles, through: :user_roles
  has_many :charities, through: :user_roles

  attr_accessor :current_password

  def platform_admin?
    roles.exists?(name: "platform_admin")
  end

  def business_owner?
    roles.exists?(name: "business_owner")
  end

  def business_admin?
    roles.exists?(name: "business_admin")
  end

  def password_correct?
    if !password.blank?
      user = User.find_by_id(id)
      if !user.authenticate(current_password)
        errors.add(:current_password, "is incorrect.")
      end
    end
  end
end
