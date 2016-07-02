class Admin::Charity::RecipientsController < Admin::BaseController

  def index
    @charity = Charity.find_by(slug: params[:charity_slug])
    @recipients = @charity.recipients
  end

  def show
    @charity = Charity.find_by(slug: params[:charity_slug]) #change
    @recipient = Recipient.find(params[:id])
    @items = @recipient.active_need_items
    if !@charity.associated_recipient?(@recipient.id)
       flash[:info] = "Recipient not found"
       redirect_to charity_path(@charity.slug)
    end
  end

  def new
    @charity = Charity.find_by(slug: params[:charity_slug])
    @recipient = @charity.recipients.new
  end

  def create
    @recipient = Recipient.new(recipient_params)
    @charity = Charity.find_by(slug: params[:charity_slug])

    if @recipient.save
      redirect_to admin_charity_recipient_path(@charity.slug, @recipient)
    else
      render :edit
    end
  end

  def edit
    @charity = Charity.find_by(slug: params[:charity_slug])
    @recipient = Recipient.find(params[:id])
  end

  def update
    @recipient = Recipient.new(recipient_params)
    @charity = Charity.find_by(slug: params[:charity_slug])

    if @recipient.save
      redirect_to admin_charity_recipient_path(@charity.slug, @recipient)
    else
      render :edit
    end
  end

  def destroy
    @charity = Charity.find_by(slug: params[:charity_slug])
    @charity.destroy
    redirect_to charities_path
  end

  private
  def recipient_params
    params.require(:recipient).permit(:name, :description, :charity_id, :recipient_photo_file_name, :recipient_photo_content_type, :recipient_photo_file_size, :recipient_photo_updated_at)
  end
end
