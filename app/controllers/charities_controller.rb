class CharitiesController < ApplicationController

  def index
    @charities = Charity.all
  end

  def show
    @charity = Charity.find_by(slug: params[:charity_slug])
    @recipients = @charity.active_recipients
  end

  def new
    @charity = Charity.new
  end

  def create
    @charity = Charity.new(charity_params)
    if @charity.save
      @charity.create_charity_owner(current_user)
      redirect_to dashboard_path(current_user)
    else
      render :new
    end
  end


  private

  def charity_params
    params.require(:charity).permit(:name, :description, :charity_photo)
  end




end
