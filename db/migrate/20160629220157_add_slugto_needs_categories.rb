class AddSlugtoNeedsCategories < ActiveRecord::Migration
  def change
    add_column :needs_categories, :slug, :string
  end
end
