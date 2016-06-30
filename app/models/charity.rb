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

  def associated_recipient?(recipient_id)
    recipient_ids = recipients.pluck(:id)
    if recipient_ids.include?(recipient_id)
      true
    else
      false
    end
  end

  def active_recipients
    recipients.find_all { |recipient| !recipient.active_need_items.empty? }
  end

end