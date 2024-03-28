class User::RoomsController < ApplicationController
  before_action :authenticate_user!

  def create
    @room = Room.create
    @current_entry = Entry.create(user_id: current_user.id, room_id: @room.id)
    @another_entry = Entry.create(user_id: params[:entry][:user_id], room_id: @room.id)
    redirect_to user_rooms_path(@room)
  end


  def index
    @current_entries = current_user.entries.order('created_at DESC').page(params[:page]).per(3)
    my_room_id = []
    @current_entries.each do |entry|
      my_room_id << entry.room.id
    end
    @another_entries = Entry.where(room_id: my_room_id).where.not(user_id: @current_user.id)  # 自分のroom_idでuser_idが自分じゃないのを取得
  end

  def show
    @room = Room.find(params[:id])
    @messages = @room.messages.all
    @message = Message.new
    @entries = @room.entries
    @another_entry = @entries.where.not(user_id: current_user.id).first
  end
end
