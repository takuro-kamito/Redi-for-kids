class User::HomesController < ApplicationController
  def top
    @community = Community.all.order('created_at DESC').page(params[:page]).per(3)
  end
  
  def guest_sign_in
    @user = User.find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      # user.skip_confirmation!  # Confirmable を使用している場合は必要
      # 例えば name を入力必須としているならば， user.name = "ゲスト" なども必要
    end
    sign_in @user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  def about
  end
end
