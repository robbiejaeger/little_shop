class DropNationalities < ActiveRecord::Migration
  def change
    drop_table :nationalities, force: :cascade
  end
end
