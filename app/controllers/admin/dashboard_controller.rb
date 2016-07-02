class Admin::DashboardController < ApplicationController

  def index
    @charities = current_user.charities
  end

end
