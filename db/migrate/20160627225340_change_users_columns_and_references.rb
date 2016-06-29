class ChangeUsersColumnsAndReferences < ActiveRecord::Migration
  def change
    remove_column :event_items, :supply_id
    remove_column :event_items, :family_id
    remove_column :donation_items, :supply_item_id
    add_reference :event_items, :event, index: true, foreign_key: true
    add_reference :event_items, :recipient, index: true, foreign_key: true
    add_reference :donation_items, :event_item, index: true, foreign_key: true
    remove_column :users, :cell
  end
end
