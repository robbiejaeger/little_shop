class AddImageToCharities < ActiveRecord::Migration
  def change
    add_column :charities, :charity_photo_file_name, :string
    add_column :charities, :charity_photo_content_type, :string
    add_column :charities, :charity_photo_file_size, :integer
    add_column :charities, :charity_photo_updated_at, :datetime
  end
end
