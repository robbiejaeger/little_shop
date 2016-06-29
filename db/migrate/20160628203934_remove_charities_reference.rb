class RemoveCharitiesReference < ActiveRecord::Migration
  def change
    remove_column :charities, :category_charity_id 
  end
end
