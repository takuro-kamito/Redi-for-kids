class User::RoomsController < ApplicationController
  before_action :authenticate_user!

  def create
    @room = Room.create #@room`という変数に、新しいチャットルームを作成。`Room.create`は、`Room`モデルに新しいレコードを作成するメソッド
    @current_entry = Entry.create(user_id: current_user.id, room_id: @room.id) #@current_entry`という変数に、現在のユーザー (`current_user`) のエントリーを作成
    @another_entry = Entry.create(user_id: params[:entry][:user_id], room_id: @room.id) #Entry`モデルに新しいレコードを作成するメソッドです。このエントリーには、`user_id`として現在のユーザーのID (`current_user.id`) を、`room_id`として先ほど作成したチャットルームのID (`@room.id`) を指定
    redirect_to user_rooms_path(@room) #@another_entry変数に、`params[:entry][:user_id]`で指定されたユーザーのエントリーを作成。`params[:entry][:user_id]`は、リクエストパラメータの`entry`ハッシュの`user_id`キーの値を取得しています。このエントリーには、`user_id`として指定されたユーザーのID、`room_id`として先ほど作成したチャットルームのIDを指定
  end


  def index
    @current_entries = current_user.entries.order('created_at DESC').page(params[:page]).per(3) #@current_entries変数に、current_userに関連するエントリーのデータを取得
    my_room_id = [] #my_room_id`という空の配列を作成
    @current_entries.each do |entry| #entry.room.id`でエントリーのルームIDを取得し、それを`my_room_id`配列に追加
      my_room_id << entry.room.id #現在のユーザーが関与しているエントリーを取得し、それぞれのエントリーからルームIDを抽出して、`my_room_id`配列に追加
    end
    @another_entries = Entry.where(room_id: my_room_id).where.not(user_id: @current_user.id)  # 自分のroom_idでuser_idが自分じゃないのを取得
  end

  def show
    @room = Room.find(params[:id])
    @messages = @room.messages.all
    @message = Message.new
    @entries = @room.entries
    @another_entry = @entries.where.not(user_id: current_user.id).first #@entries`は、ある特定のコンテキストや条件に関連するエントリーのデータを表しています。コード中の該当箇所では、他の部分で定義されている前提
  end                                                                   #@entries`から、現在のユーザー (`current_user`) のユーザーID (`user_id`) とは異なるエントリーをフィルタリングしています。`.where.not(user_id: current_user.id)`は、`user_id`が現在のユーザーのIDと異なるエントリーを抽出するための条件
end                                                                     #.first`は、フィルタリングされた結果から最初のエントリーを取得するメソッド
