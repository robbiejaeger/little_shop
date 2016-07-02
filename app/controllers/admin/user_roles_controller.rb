class Admin::UserRolesController < ApplicationController

  def create
    @user = User.find(params[:user_id])
    @user_role = @user.user_roles.new(user_role_params)
    if @user_role.save
      redirect_to admin_user_path(params[:user_id])
    else
      render :new
    end
  end

  def new
    @charity_options = Charity.form_options
    @role_options = Role.form_options
    @user = User.find(params[:user_id])
    @user_role = UserRole.new
  end


  private

    def user_role_params
      params.require(:user_role).permit(:role_id, :charity_id, :user_id)
    end


end
