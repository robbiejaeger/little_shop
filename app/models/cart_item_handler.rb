class CartItemHandler < SimpleDelegator

  attr_reader :need_item, :quantity

  def initialize(need_item_id, quantity)
    @need_item  = NeedItem.find(need_item_id)
    @quantity = quantity
    super(@need_item)
  end
end
