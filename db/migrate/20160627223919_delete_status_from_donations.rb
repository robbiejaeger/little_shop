class DeleteStatusFromDonations < ActiveRecord::Migration
  def change
    remove_column :donations, :status
  end
end
