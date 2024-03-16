class User::UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  
  def index
    @users = User.all
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
  redirect_to user_root_path
end
  
def favorites 
    @user = User.find(params[:id])
    @favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.where(id: @favorites)
    # @post = Post.find(params[:id])
    @favorite_communities = Community.where(id: @favorite_posts.pluck(:community_id))
    @posts = Post.select("*, posts.id as post_id").joins(:community).order(created_at: :desc)
    
end

private

def user_params
  params.require(:user).permit(:name, :introduction, :profile_image, :is_active)
end
end
