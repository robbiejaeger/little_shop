class ChangeDonationItemsColumns < ActiveRecord::Migration
  def change
    rename_column :donation_items, :quantity, :ticket_quantity
  end
end
