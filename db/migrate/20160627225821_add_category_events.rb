class AddCategoryEvents < ActiveRecord::Migration
  def change
    create_table :category_events do |t|
      t.string :name
    end
  end
end
