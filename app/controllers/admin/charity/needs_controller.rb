class Admin::Charity::NeedsController < Admin::BaseController

  def index
    @charity = Charity.find(params[:charity_id])
    @needs = @charity.needs
  end

  def show
    @need = Need.find(params[:id])
  end

  def new
    @needs_category_options = NeedsCategory.form_options
    @need = Need.new
  end

  def create
    @need = Need.new(need_params)
    @charity = Charity.find(params[:charity_id])
    if @need.save
      redirect_to admin_charity_need_path(@charity, @need)
    else
      render :new
    end
  end


  def edit

  end

  def update

  end

  private

  def need_params
    params.require(:need).permit(:name, :description, :price, :needs_category_id, :charity_id)
  end


end
