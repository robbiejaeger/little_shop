class Need < ActiveRecord::Base
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true

  has_many :need_items
  has_many :recipients, through: :need_items
  has_many :donation_items, 
  belongs_to :needs_category
end
