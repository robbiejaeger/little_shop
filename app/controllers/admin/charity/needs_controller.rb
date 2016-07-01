class Admin::Charity::NeedsController < Admin::BaseController

  def index
    @charity = Charity.find(params[:charity_id])
    @needs = @charity.needs
  end

  def show
    @need = Need.find(params[:id])
  end

  def edit

  end

  def update

  end

  private

  def needs_params
    params.require(:need).permit(:name, :description, :price, :needs_category_id, :charity_id)
  end


end
