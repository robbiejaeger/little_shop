class Charity::RecipientsController < ApplicationController

  def index
    # @families = Family.all
    # @featured = Nationality.get_random
    # @nationalities = Nationality.all
  end

  def show
    # byebug
    @charity = Charity.find_by(slug: params[:charity]) #change
    @recipient = Recipient.find(params[:id])
    @items = @recipient.need_items.active
    # if @family.value_of_supplies_purchased > 0
    #   @supplies_needed_value = @family.value_of_supplies_needed
    #   @supplies_purchased_value = @family.value_of_supplies_purchased
    #   @percentage_purchased = @family.percentage_donated
    # else
    #   @supplies_needed_value = @family.value_of_supplies_needed
    #   @supplies_purchased_value = 0
    #   @percentage_purchased = 0
    # end
  end
end
