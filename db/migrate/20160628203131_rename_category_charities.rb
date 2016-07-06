class RenameCategoryCharities < ActiveRecord::Migration
  def change
    rename_table :category_charities, :causes
  end
end
