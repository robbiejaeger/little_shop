require 'rails_helper'

RSpec.describe Status, type: :model do
   it "scopes admin status correctly " do
     active, inactive, suspended = create_list(:status, 3)
     expect(Status.admin_statuses.count).to eq(2)
     expect(Status.admin_statuses.exists?("suspended")).to eq(false)
     expect(Status.admin_statuses.exists?(name: "active")).to eq(true)
     expect(Status.admin_statuses.exists?(name: "inactive")).to eq(true)

   end

   it "returns form options correctly for business admin" do
     create_list(:status, 3)
     role = Role.create(name: 'business_admin')
     user = create(:user)
     user_role = UserRole.create(role_id: role.id, user_id: user.id)

     expect(Status.form_options(user)).to eq([["active", 1], ["inactive", 2]])

   end

   it "returns form options correctly for business admin" do
     create_list(:status, 3)
     role = Role.create(name: 'platform_admin')
     user = create(:user)
     user_role = UserRole.create(role_id: role.id, user_id: user.id)

     expect(Status.form_options(user)).to eq([["active", 1], ["inactive", 2], ["suspended", 3]])

   end

end
