class CharitiesController < ApplicationController

  def index
    @charities = Charity.all
  end

  def show
    @charity = Charity.find_by(slug: params[:charity_slug])
    @recipients = @charity.active_recipients
  end
end
