class Admin::NeedsController < Admin::BaseController

  def index
    @needs = current_user.charity.needs
  end
end
