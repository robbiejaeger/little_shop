class Admin::Charity::DashboardsController < Admin::BaseController

  def show
    @charity = Charity.find(params[:charity_id])    
  end
end
