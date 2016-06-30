class HomesController < ApplicationController

  def index
    @charities = Charity.all
  end

  def show
    @charities = Charity.all
    @causes = Cause.all
    @needs_categories = NeedsCategory.all
  end
end
