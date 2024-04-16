module NotificationsHelper
  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end
end

#ユーザーに未読状態の通知対象があるか調べるメソッド
