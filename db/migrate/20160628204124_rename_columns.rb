class RenameColumns < ActiveRecord::Migration
  def change
    rename_column :donation_items, :ticket_quantity, :quantity
    rename_column :need_items, :ticket_quantity, :quantity
    add_column :need_items, :deadline, :datetime
    rename_column :needs, :ticket_price, :price
  end
end
