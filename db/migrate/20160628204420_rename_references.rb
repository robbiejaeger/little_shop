class RenameReferences < ActiveRecord::Migration
  def change
    remove_column :donation_items, :event_item_id
    add_reference :donation_items, :need_item, index: true, foreign_key: true
    remove_column :need_items, :event_id
    add_reference :need_items, :need, index:true, foreign_key: true
    remove_column :needs, :category_event_id
    add_reference :needs, :needs_category, index: true, foreign_key: true
  end
end
