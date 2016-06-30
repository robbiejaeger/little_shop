class Admin::NeedsController < Admin::BaseController

  def index
    @needs = current_user.charities.first.needs
  end
end
