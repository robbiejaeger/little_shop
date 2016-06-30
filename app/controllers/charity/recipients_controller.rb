class Charity::RecipientsController < ApplicationController

  def index
    # @families = Family.all
    # @featured = Nationality.get_random
    # @nationalities = Nationality.all
  end

  def show
    @charity = Charity.find_by(slug: params[:charity]) #change
    @recipient = Recipient.find(params[:id])
    @items = @recipient.active_need_items
    if !@charity.associated_recipient?(@recipient.id)
       flash[:info] = "Recipient not found"
       redirect_to charity_path(@charity.slug)
    end
  end
end
