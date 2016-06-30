class DonationItem < ActiveRecord::Base
  belongs_to :need_item
  belongs_to :donation

  def name
    supply_item.supply.name
  end

  def price
    need_item.need.price
  end

  def subtotal
    price * quantity
  end

  def self.total_items
    sum(:quantity)
  end
end
