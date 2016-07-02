class Role < ActiveRecord::Base
  has_many :user_roles
  has_many :users, through: :user_roles


  def self.form_options
    all.map{ |role| [ role.name, role.id ] }
  end

end
