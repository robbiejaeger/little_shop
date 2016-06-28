class Cause < ActiveRecord::Base
  validates :name, presence: true

  has_many :causes_charities
  has_many :charities, through: :causes_charities
end
