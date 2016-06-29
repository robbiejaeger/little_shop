class DonationItem < ActiveRecord::Base
  belongs_to :need_item
  belongs_to :donation

  def family_nationality
    supply_item.family.nationality.name
  end

  def family
    supply_item.family
  end

  def family_size
    supply_item.family.num_people
  end

  def family_description
    "#{family_nationality} family of #{family_size}"
  end

  def name
    supply_item.supply.name
  end

  def value
    supply_item.supply.value
  end

  def subtotal
    value * quantity
  end

  def self.total_items
    sum(:quantity)
  end
end
