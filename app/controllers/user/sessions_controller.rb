# frozen_string_literal: true

class User::SessionsController < Devise::SessionsController
   before_action :user_state, only: [:create]

def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to root_path
end
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

#   protected

#   # アクティブであることを判断する処理
#   def user_state
#   @user = User.find_by(email: params[:user][:email])
#   return if @user.nil?
#   if @user.is_active
#   return unless @user.valid_password?(params[:user][:password])
#   sign_in(@user)
#     redirect_to user_root_path
#   else
#     flash[:notice] = "既に退会済みのアカウントです。新規会員登録が必要になります。"
#     redirect_to new_user_registration_path
#   end
#   end

#admmin側で制限中の場合ログインが出来ない権限

def user_state
    user = User.find_by(email: params[:user][:email])
    if user && user.status != "制限中" # statusが制限中でなければログイン可能
    else
      flash[:notice] = "メールアドレスが登録されていないか、制限中です。新規会員登録が必要です。"
      redirect_to new_user_session_path
    end
end
end
