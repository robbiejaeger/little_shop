class AddCharities < ActiveRecord::Migration
  def change
    create_table :charities do |t|
      t.string :name
      t.string :description
    end
  end
end
