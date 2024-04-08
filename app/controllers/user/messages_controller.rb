class User::MessagesController < ApplicationController
  before_action :authenticate_user!

def create
  if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
    @message = Message.new(message_params)
    @message.user_id = current_user.id
    @room = @message.room
    if @message.save
      # 追加の為一旦コメントアウト redirect_to user_room_path(@message.room)
      @roommembernotme = Entry.where(room_id: @room.id).where.not(user_id: current_user.id)
      @theid = @roommembernotme.find_by(room_id: @room.id)
      notification = current_user.active_notifications.new(
        room_id: @room.id,
        message_id: @message.id,
        visited_id: @theid.user_id,
        visitor_id: current_user.id,
        action: 'dm'
      )
      # 自分の投稿に対するコメントの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
      # ここまでを追加

      redirect_to user_room_path(@message.room)
    end
  else
    redirect_back(fallback_location: root_path)
  end
end
  private

    def message_params
      params.require(:message).permit(:user_id,:room_id, :body).merge(user_id: current_user)
    end
end