class NeedItem < ActiveRecord::Base
  belongs_to :need
  belongs_to :recipient
  has_many :donation_items

  scope :retired, -> {where("deadline < ?", Date.today)}
  scope :active, -> {where("deadline > ?", Date.today)}

  # def self.find_family(id)
  #   find(id).family
  # end

  def name
    need.name
  end

  def description
    need.description
  end

  def price
    need.price
  end

  def quantity_remaining
    quantity - donation_items.sum(:quantity)
  end

  def subtotal(quantity)
    price * quantity
  end
end
