class User::UsersController < ApplicationController
   before_action :set_defaults, only: [:create]
   before_action :authenticate_user!, only: [:show]
   before_action :correct_user, only: [:edit, :update]


  def index
    @users = User.all.order('created_at DESC').page(params[:page]).per(4)
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    @current_entry = Entry.where(user_id: current_user.id)#現在ログインしているユーザーに関連するエントリーを取得し、`@current_entry`変数に代入。
    @another_entry = Entry.where(user_id: @user.id)
    unless @user.id == current_user.id #unless`文を使って、`@user`のIDが現在のユーザーのIDと一致しない場合の処理
    @current_entry.each do |current| #@current_entry`と`@another_entry`のそれぞれのエントリーを繰り返し処理し、`room_id`が一致する場合に、`@is_room`を`true`に設定し、その`room_id`を`@room_id`変数に代入
      @another_entry.each do |another|
        if current.room_id == another.room_id
          @is_room = true
          @room_id = current.room_id
        end
      end
    end
    unless @is_room #@is_room`が`false`の場合、新しい`Room`オブジェクトと`Entry`オブジェクトを作成し、`@room`変数と`@entry`変数にそれぞれ代入
      @room = Room.new
      @entry = Entry.new
    end
    end
  end

  def create
    @user = User.new(user_params)
    if User.exists?(email: params[:email])
      flash[:notice] = "そのメールアドレスはすでに登録されています。"
      redirect_to new_registration_path
    else
      @user = User.new(user_params)

      if @user.save
        flash[:notice] = "新規登録が完了しました"
        redirect_to root_path
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
    redirect_to user_path(@user)
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
    @favorites = Favorite.where(user_id: @user.id).pluck(:community_id) #Favorite`モデルを使って、データベースから特定のユーザーの`user_id`に一致する行を選択し、`pluck`メソッドを使ってそれぞれの行の`community_id`の値を抽出
    @favorite_communities = Community.where(id: @favorites).order('created_at DESC').page(params[:page]).per(3) #where(user_id: @user.id)`という条件にマッチする`Favorite`モデルのレコードを取得し、それらの`community_id`の値を配列として取得
 end


private

def user_params
  params.require(:user).permit(:admin,:name, :introduction, :profile_image, :is_active, :status, :email, :passwors)
end
 def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user == current_user
 end
def set_defaults
    self.admin = true
end
end
