class Admin::DashboardController < ApplicationController

  def index
    if current_user.platform_admin?
      @active_charities
      @
    else
      @charities = current_user.charities_to_display
    end
  end

end
