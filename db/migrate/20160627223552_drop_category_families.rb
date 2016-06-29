class DropCategoryFamilies < ActiveRecord::Migration
  def change
    drop_table :category_families, force: :cascade
  end
end
