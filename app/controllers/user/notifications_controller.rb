class User::NotificationsController < ApplicationController
  
  #@notifications変数に、現在のユーザー `current_user` の受動的な（受け取った）通知を取得
  #@notificationsの中から`checked`が`false`（未確認）の通知を選択し、それぞれの通知に対しの処理
  #notification.update(checked: true)`：選択された通知の`checked`を`true`（確認済み）に更新
  
  def index
    @notifications = current_user.passive_notifications.page(params[:page]).per(5)
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
    end
  end
    
  def destroy
    @notifications = current_user.notifications.destroy_all
    redirect_to notifications_path
  end
end
