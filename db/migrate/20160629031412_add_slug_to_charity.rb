class AddSlugToCharity < ActiveRecord::Migration
  def change
    add_column :charities, :slug, :string
  end
end
