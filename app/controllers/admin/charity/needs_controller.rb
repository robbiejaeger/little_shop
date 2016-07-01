class Admin::Charity::NeedsController < Admin::BaseController

  def index
    @charity = Charity.find_by(slug: params[:charity_slug])
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
    @charity = Charity.find_by(slug: params[:charity_slug])
    if @need.save
      redirect_to admin_charity_need_path(@charity.slug, @need)
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
