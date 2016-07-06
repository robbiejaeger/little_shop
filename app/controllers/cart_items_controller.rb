class CartItemsController < ApplicationController

  def create
    need_item = NeedItem.find(params[:need_item][:id])
    @cart.add_cart_item(need_item.id, params[:need_item][:quantity])
    session[:cart] = @cart.contents
    flash[:success] = "You added #{need_item.name}"
    redirect_to charity_recipient_path(need_item.recipient.charity.slug, need_item.recipient)
  end

  def update
    @cart.change_cart_item_quantity(params[:need_item][:id], params[:need_item][:quantity])
    session[:cart] = @cart.contents
    redirect_to cart_index_path
  end

  def destroy
    @cart.delete_cart_item(params[:id])
    session[:cart] = @cart.contents
    need_name = NeedItem.find(params[:id]).name
    flash[:success] = "Successfully deleted #{need_name} from your cart."
    redirect_to cart_index_path
  end
end
