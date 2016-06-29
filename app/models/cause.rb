class Cause < ActiveRecord::Base
  validates :name, presence: true

  has_many :causes_charities
  has_many :charities, through: :causes_charities
  has_many :recipients, through: :charities
  before_create :create_slug

  def create_slug
    self.slug = self.name.parameterize
  end
end
