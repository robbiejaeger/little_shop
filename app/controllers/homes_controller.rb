class HomesController < ApplicationController

  def index
    @charities = Charity.all 
  end

  def show
    @charities = Charity.all
  end
end
