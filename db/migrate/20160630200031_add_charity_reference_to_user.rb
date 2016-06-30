class AddCharityReferenceToUser < ActiveRecord::Migration
  def change
    add_reference :users, :charity, index: true, foreign_key: true
  end
end
