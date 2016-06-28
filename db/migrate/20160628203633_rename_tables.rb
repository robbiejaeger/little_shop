class RenameTables < ActiveRecord::Migration
  def change
    rename_table :category_events, :needs_categories
    rename_table :events, :needs
    rename_table :event_items, :need_items 
  end
end
