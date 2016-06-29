class AddCategoryCharitites < ActiveRecord::Migration
  def change
    create_table :category_charities do |t|
      t.string :name
    end
  end
end
