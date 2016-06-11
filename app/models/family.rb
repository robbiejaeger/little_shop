class Family < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :arrival_date, presence: true
  validates :num_married_adults, presence: true
  validates :num_unmarried_adults, presence: true
  validates :num_children_over_two, presence: true
  validates :num_children_under_two, presence: true
  validates :donation_deadline, presence: true

  has_many :category_families
  has_many :categories, through: :category_families
  has_many :supply_items
  has_many :supplies, through: :supply_items
  belongs_to :nationality

  scope :retired, -> {where("arrival_date < ?", Date.today)}
  scope :active, -> {where("arrival_date > ?", Date.today)}

  def num_people
    num_married_adults + num_unmarried_adults +
    num_children_over_two + num_children_under_two
  end

  def num_adults
    num_married_adults + num_unmarried_adults
  end

  def supply_quantity_hash
    {"adult" => num_adults,
     "person" => num_people,
     "household" => 1,
     "baby" => num_children_under_two,
     "child" => num_children_over_two,
     "other" => 0}
  end

  def create_supply_items
    Supply.all.each do |supply|
      if supply_quantity_hash[supply.multiplier_type] != 0
        supply_items.create(supply: supply, quantity: supply_quantity_hash[supply.multiplier_type])
      end
    end
  end

  def retired?
    arrival_date <= Date.today
  end

  def donations_received
    supply_items.map do |supply_item|
      DonationItem.where(supply_item: supply_item)
    end.flatten.compact
  end
end
