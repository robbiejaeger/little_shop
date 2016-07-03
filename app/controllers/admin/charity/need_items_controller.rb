class Admin::Charity::NeedItemsController < Admin::BaseController

  def new
    byebug
    @charity = Charity.find_by(slug: params[:charity_slug])
    @needs = @charity.needs.form_options
    @recipient = Recipient.find(params[:id])
    @need_item = @recipient.need_items.new(need_item_params)
  end

  def create

  end





  private
    def need_item_params
      params.require(:need_item).permit(:quantity, :recipient_id,
                                        :deadline, :need_id)
    end



end
