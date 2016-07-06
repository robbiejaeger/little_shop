class EditNameOfQuantity < ActiveRecord::Migration
  def change
    rename_column :event_items, :quantity, :ticket_quantity
  end
end
