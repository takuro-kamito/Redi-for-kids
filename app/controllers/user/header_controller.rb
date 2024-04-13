class User::HeaderController < ApplicationController
  def show
  @unread_notifications_count = Notification.where(read: false).count
  end
end
