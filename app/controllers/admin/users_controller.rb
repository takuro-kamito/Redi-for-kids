class Admin::UsersController < ApplicationController
 before_action :authenticate_admin!
 
 
  def index
   @users = User.all.page(params[:page]).per(8)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update 
    @user = User.find(params[:id])
  if@user.update(user_params)
    redirect_to admin_user_path(@user)
  else
    render :edit
  end
  end

  private

  def user_params
    params.require(:user).permit(:name, :name_kana, :email, :is_active)
  end
end