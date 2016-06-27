class RenameSuppliesToEvents < ActiveRecord::Migration
  def change
    rename_column :supplies, :value, :ticket_price
    add_column :supplies, :date, :datetime
    rename_table :supplies, :events
    rename_table :supply_items, :event_items
  end
end
