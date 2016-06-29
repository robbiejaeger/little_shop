class Charity < ActiveRecord::Base
  validates :name, presence: true
  validates :description, presence: true

  has_many :causes_charities
  has_many :causes, through: :causes_charities
  has_many :recipients

  before_create :create_slug

  def create_slug
    self.slug = self.name.parameterize
  end

end
