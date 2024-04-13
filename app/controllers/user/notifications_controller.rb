class User::NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications.page(params[:page]).per(5)
    @notifications.where(checked: false).each do |notification|
      notification.update(checked: true)
  end
  end
    
def destroy
  @notifications = current_user.notifications.destroy_all
  redirect_to user_notifications_path
end
end
