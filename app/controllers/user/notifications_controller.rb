class User::NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications.page(params[:page]).per(5)
  end
    
def destroy
  @notification = Notification.find(params[:id])
  @notification.destroy
  redirect_to user_notifications_path, notice: '通知が削除されました。'
end
end
