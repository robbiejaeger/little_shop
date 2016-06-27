class DeleteMultiplierTypeFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :multiplier_type
  end
end
