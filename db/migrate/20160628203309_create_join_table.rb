class CreateJoinTable < ActiveRecord::Migration
  def change
    create_join_table :causes, :charities
  end
end
