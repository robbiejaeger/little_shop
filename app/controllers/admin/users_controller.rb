class Admin::UsersController < ApplicationController

  def index
    @charities = current_user.charities
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end


end
