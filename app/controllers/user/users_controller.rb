class User::UsersController < ApplicationController
  def index
    @users = User.all
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
  @user = User.find(params[:id])
  if @user.update(user_params)
    flash[:notice] = "ユーザーの更新に成功しました"
    redirect_to user_users_path(@user)
  else
    render :edit
  end
  end


  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
