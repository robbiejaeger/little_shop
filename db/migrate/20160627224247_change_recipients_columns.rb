class ChangeRecipientsColumns < ActiveRecord::Migration
  def change
    rename_column :recipients, :first_name, :name
    remove_column :recipients, :last_name
    remove_column :recipients, :arrival_date
    remove_column :recipients, :num_married_adults
    remove_column :recipients, :num_unmarried_adults
    remove_column :recipients, :num_children_over_two
    remove_column :recipients, :num_children_under_two
    remove_column :recipients, :donation_deadline
    remove_column :recipients, :nationality_id
    rename_column :recipients, :family_photo_file_name, :recipient_photo_file_name
    rename_column :recipients, :family_photo_content_type, :recipient_photo_content_type
    rename_column :recipients, :family_photo_file_size, :recipient_photo_file_size
    rename_column :recipients, :family_photo_updated_at, :recipient_photo_updated_at
  end
end
