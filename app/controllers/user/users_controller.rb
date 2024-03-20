class User::UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  
  
  def index
    @users = User.all.order('created_at DESC').page(params[:page]).per(5)
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    @current_entry = Entry.where(user_id: current_user.id)
    @another_entry = Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
    @current_entry.each do |current|
      @another_entry.each do |another|
        if current.room_id == another.room_id
          @is_room = true
          @room_id = current.room_id
        end
      end
    end
    unless @is_room
      @room = Room.new
      @entry = Entry.new
    end
    end
  end
  def create
    if User.exists?(email: params[:email])
      redirect_to signup_path, alert: "そのメールアドレスはすでに登録されています。"
    else
      @user = User.new(user_params)
      
      if @user.save
        redirect_to success_path, notice: "新規登録が完了しました。"
      else
        render :new
      end
    end
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


def withdraw
  @user = current_user
  @user.destroy
  reset_session
  flash[:notice] = "退会処理を実行しました"
  redirect_to root_path
end

 def favorites
    @user = User.find(params[:id])
    @favorites = Favorite.where(user_id: @user.id).pluck(:community_id)
    @favorite_communities = Community.where(id: @favorites)
 end
  

private

def user_params
  params.require(:user).permit(:name, :introduction, :profile_image, :is_active, :status, :email, :passwors)
end
end
