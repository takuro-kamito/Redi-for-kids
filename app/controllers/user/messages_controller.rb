class User::MessagesController < ApplicationController
  before_action :authenticate_user!

def create
  if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
    @message = Message.new(message_params)
    @message.user_id = current_user.id
    @room = @message.room
    if @message.save
      # 追加の為一旦コメントアウト redirect_to user_room_path(@message.room)
      @roommembernotme = Entry.where(room_id: @room.id).where.not(user_id: current_user.id) #@roommembernotme`という変数に、`Entry`モデルからデータを取得
      @theid = @roommembernotme.find_by(room_id: @room.id)  #条件は、`room_id`が`@room.id`でありかつ`user_id`が現在のユーザーのID (`current_user.id`) ではないこと
      notification = current_user.active_notifications.new( #@theid`という変数に、`@roommembernotme`の中からさらに条件を指定してデータを取得しています。この条件は、`room_id`が`@room.id`であること
        room_id: @room.id,                                  #notification`という変数に、現在のユーザー (`current_user`) のアクティブな通知を作成しています。この通知には、以下の情報が含まれる
        message_id: @message.id,
        visited_id: @theid.user_id,
        visitor_id: current_user.id,
        action: 'dm'
      )
      # 特定の条件を持つデータを取得し、それを利用して通知を作成
      # 自分の投稿に対するコメントの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
      

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