class NeedsCategoriesController < ApplicationController

  def show
    @needs_category = NeedsCategory.find_by(slug: params[:needs_category_slug])
  end

end
