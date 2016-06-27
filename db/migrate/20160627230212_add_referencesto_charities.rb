class AddReferencestoCharities < ActiveRecord::Migration
  def change
    add_reference :events, :category_event, index: true, foreign_key: true
    add_reference :recipients, :charity, index: true, foreign_key: true
    add_reference :charities, :category_charity, index: true, foreign_key: true
  end
end
