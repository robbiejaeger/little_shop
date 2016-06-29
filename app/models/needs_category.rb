class NeedsCategory < ActiveRecord::Base
  validates :name, presence: true
  has_many :needs
  before_create :create_slug
  has_many :need_items, through: :needs
  has_many :recipients, through: :need_items

  def create_slug
    self.slug = self.name.parameterize
  end
end
