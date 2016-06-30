class RenameFamilies < ActiveRecord::Migration
  def change
    rename_table :families, :recipients
  end
end
